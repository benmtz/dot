from ast import parse
from configparser import ConfigParser, ExtendedInterpolation
import jinja2
from dataclasses import dataclass
import logging 
from pathlib import Path
import zipfile
import argparse
import argparse
import os
import shutil
from urllib import request


class CustomFormatter(logging.Formatter):

    grey = "\x1b[38;20m"
    yellow = "\x1b[33;20m"
    red = "\x1b[31;20m"
    bold_red = "\x1b[31;1m"
    reset = "\x1b[0m"
    format = "%(asctime)s - %(name)s - %(levelname)s - %(message)s (%(filename)s:%(lineno)d)"

    FORMATS = {
        logging.DEBUG: grey + format + reset,
        logging.INFO: grey + format + reset,
        logging.WARNING: yellow + format + reset,
        logging.ERROR: red + format + reset,
        logging.CRITICAL: bold_red + format + reset
    }

    def format(self, record):
        log_fmt = self.FORMATS.get(record.levelno)
        formatter = logging.Formatter(log_fmt)
        return formatter.format(record)

# create logger with 'spam_application'
log = logging.getLogger("dotfiles")
log.setLevel(logging.INFO)

# create console handler with a higher log level
ch = logging.StreamHandler()
ch.setLevel(logging.DEBUG)

ch.setFormatter(CustomFormatter())

log.addHandler(ch)

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


def link_config(src: str, dest: str, options: DotfilesOptions):
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
      else:
        log.debug(f"rm    {dest}")
        os.remove(dest)
      return os.symlink(src, dest)
    log.debug(options)
    log.error(f"""Cannot link to {dest} because this \
file exists, use the --force option if you are sure""")


def link_configs(options: DotfilesOptions):
  config_dir = get_filepath("dist/.config")
  for config in os.listdir(config_dir):
    link_src = os.path.join(config_dir, config)
    link_dest = os.path.join(Path.home(), ".config",config)
    link_config(link_src, link_dest, options)

def ensure_dir(path: str):
  try: 
    os.makedirs(path)
  except:
    log.debug("Directory already present, skipping")
  return

def download_font_to(font_url: str, target_path: str):
  log.info("Downloading nerdfont...")
  request.urlretrieve(font_url, target_path)

def install_font_from(zip_path: str):
  font_dir = os.path.join(Path.home(), ".fonts")
  ensure_dir(font_dir)
  with zipfile.ZipFile(zip_path, 'r') as zip_ref:
    zip_ref.extractall(font_dir)

def install_font(font: str, options: DotfilesOptions):
  temp_zip_path = f"/tmp/{font}.zip"
  download_font_to(f"https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/{font}.zip", temp_zip_path)
  install_font_from(temp_zip_path)

def hydrate(src: str, dest: str, values: dict):
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

def compile():
  print("compiling dotfiles")
  options = read_config()
  target_root = get_filepath("dist")
  src_root = get_filepath("src")
  log.debug("options", options)
  log.debug("src", src_root)
  log.debug("target", target_root)
  for file_root, file_dirs, file_files in os.walk(src_root, topdown=False):
    new_root = file_root.replace(src_root, target_root)
    for filename in file_files:
      old_path = os.path.join(file_root, filename)
      new_path = old_path.replace(src_root, target_root)
      hydrate(old_path, new_path, options)

    # hydrate(files)

parser = argparse.ArgumentParser()
parser.add_argument("action")
parser.add_argument("--force", action=argparse.BooleanOptionalAction)
args = parser.parse_args()
options = DotfilesOptions(
  force=args.force
)

if args.action == "link":
  link_configs(options)
elif args.action == "install-font":
  install_font("Cousine", options)
elif args.action == "compile":
  compile()
else:
  raise f"No such action {args.action}"

