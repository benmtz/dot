from ast import parse
from configparser import ConfigParser, ExtendedInterpolation
from os.path import islink
import jinja2
from dataclasses import dataclass
from pathlib import Path
import tempfile
import zipfile
import argparse
import argparse
import os
import shutil
from urllib import request
from utility.current_os import get_current_os
from utility.logger import log
from utility.jinja_templates import hex_to_rgb
from utility.files import flat_walk, ensure_dir
from utility.dict_util import flatten_dict_with_dots
from jinja2.filters import FILTERS
FILTERS["hex_to_rgb"] = hex_to_rgb


@dataclass
class DotfilesOptions:
  force: bool


def get_filepath(filename: str):
  env_dotfiles_dir = os.path.dirname(os.path.abspath(__file__))
  return os.path.join(env_dotfiles_dir, filename)


def read_config():
  parser = ConfigParser(interpolation = ExtendedInterpolation())
  parser.read(get_filepath("theme.ini"))
  return {section: dict(parser.items(section)) for section in parser.sections()}


def link_config(src: str, dest: str, options):
  """
  link_config create a symlink from dest to src and handle edge cases, unlinking
  or removing the files found in dest if needed
  """
  try:
    log.info(f"Linking {dest} to {src}")
    os.symlink(src, dest)
  except (FileExistsError, FileNotFoundError):
    if options.force:
      if os.path.islink(dest):
        log.debug(f"unlink {dest}")
        os.unlink(dest)
      elif os.path.isdir(dest):
        log.debug(f"rmdir {dest}")
        shutil.rmtree(dest)
      elif os.path.isfile(dest):
        log.debug(f"rm {dest}")
        os.remove(dest)
      else:
        log.debug(f"nothing to clean")
      return os.symlink(src, dest)
    log.debug(options)
    log.error(f"""Cannot link to {dest} because this \
file exists, use the --force option if you are sure""")


def link_configs(options):
  """
  link_configs link files from the dist folder to the home user directory
  """
  config_dir = get_filepath("dist")
  directories, files = flat_walk(config_dir)
  for directory in directories:
      target_dir = directory.replace(config_dir, os.getenv("HOME"))
      if os.path.islink(target_dir):
          os.unlink(target_dir)
      ensure_dir(target_dir)
  for link_to in files:
      link_from = link_to.replace(config_dir, os.getenv("HOME"))
      link_config(link_to, link_from, options)


def download_font_to(font_url: str, target_path: str):
  log.info("Downloading nerdfont...")
  request.urlretrieve(font_url, target_path)

def install_macos_font_from(zip_path: str):
  font_dir = os.path.join(Path.home(), "Library", "Fonts")
  ensure_dir(font_dir)
  with zipfile.ZipFile(zip_path, 'r') as zip_ref:
    zip_ref.extractall(font_dir)

def install_linux_font_from(zip_path: str):
  font_dir = os.path.join(Path.home(), ".fonts")
  ensure_dir(font_dir)
  with zipfile.ZipFile(zip_path, 'r') as zip_ref:
    zip_ref.extractall(font_dir)

def install_termux_font_from(zip_path:str, theme_data):
  font_dir = os.path.join(Path.home(), ".termux")
  main_font_file = theme_data["font"]["main"]
  ensure_dir(font_dir)
  with zipfile.ZipFile(zip_path, 'r') as zip_ref:
    zip_ref.extract(main_font_file, path=font_dir)
    os.replace(f"{font_dir}/{main_font_file}", f"{font_dir}/font.ttf")


def install_font(theme_data):
  theme_data = read_config()
  with tempfile.TemporaryDirectory() as tmpdir:
    temp_zip_path = f"{tmpdir}/font.zip"
    download_font_to(theme_data["font"]["zip_url"], temp_zip_path)
    current_os = get_current_os()
    log.debug(f"{current_os} font install")
    if current_os == "linux":
        install_linux_font_from(temp_zip_path)
    elif current_os == "termux":
        install_termux_font_from(temp_zip_path, theme_data)
    elif current_os == "macos":
        install_macos_font_from(temp_zip_path)

def hydrate(src: str, dest: str, values: dict):
  """
  Hydrate replace values in src into the dest file
  """
  log.debug(f"hydrating {src} to {dest}")
  file_dir = os.path.split(dest)[0]
  ensure_dir(file_dir)
  if (src.endswith(".j2")):
    with open(src) as file_:
      template = jinja2.Template(file_.read())
      output = template.render(values)
      with open(dest.replace(".j2", ""), 'w') as f:
        f.write(output)
        f.close()
  else:
    shutil.copyfile(src, dest)
    shutil.copymode(src, dest)

def compile(args):
  """
  Compile takes files from the src directory and hydrate to the dist folder
  """
  print("compiling dotfiles")
  options = read_config()
  target_root = get_filepath("dist")
  src_root = get_filepath("src")
  log.debug(f"options {options}")
  log.debug(f"src {src_root}")
  log.debug(f"target {target_root}")
  for file_root, file_dirs, file_files in os.walk(src_root, topdown=False):
    new_root = file_root.replace(src_root, target_root)
    for filename in file_files:
      old_path = os.path.join(file_root, filename)
      new_path = old_path.replace(src_root, target_root)
      hydrate(old_path, new_path, options)

def extract(args):
  src_dir = get_filepath("src")
  config = read_config()
  target_path = args.path.replace(os.getenv("HOME"), src_dir)
  log.debug(f"extract {args.path} to {target_path}")
  with open(args.path, "r") as f:
    content = f.read()
    for key, value in flatten_dict_with_dots(config).items():
      content = content.replace(value, "{{ " + key + " }}")
      with open(f"{target_path}.j2", "w") as t:
        t.write(content)


parser = argparse.ArgumentParser()
subparsers = parser.add_subparsers(required=True)

link_parser = subparsers.add_parser('link', help='Link configuration files')
link_parser.set_defaults(func=link_configs)
link_parser.add_argument("--force", action=argparse.BooleanOptionalAction)

compile_parser = subparsers.add_parser('compile', help='Compile configuration files')
compile_parser.set_defaults(func=compile)
compile_parser.add_argument("--force", action=argparse.BooleanOptionalAction)

extract_parser = subparsers.add_parser('extract', help='Extract a configuration file')
extract_parser.set_defaults(func=extract)
extract_parser.add_argument("path",type=str)

install_font_parser = subparsers.add_parser('install-font', help='Install dotfiles fonts')

args = parser.parse_args()
args.func(args)
