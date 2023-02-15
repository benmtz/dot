from utility.logger import log
import os

def flat_walk(top_dir: str):

  directories: set[str] = set()
  files: set[str] = set()
  for file_root, file_dirs, file_files in os.walk(top_dir, topdown=False):
      for directory in file_dirs:
        directories.add(os.path.join(file_root, directory))
      for file in file_files:
        files.add(os.path.join(file_root, file))
  return directories, files


def ensure_dir(path: str):
  try: 
    os.makedirs(path)
  except:
    log.debug("Directory already present, skipping")
  return

