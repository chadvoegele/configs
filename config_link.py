#!/usr/bin/env python
import os, sys, argparse

def dirs_to_check_for_dead_links():
  # relative to $HOME
  # (dir, recursive_find?)
  dirs = [("", False), (".config", True)]
  return dirs

def parse_args():
  parser = argparse.ArgumentParser(description='Link configs from git to local')
  parser.add_argument('-v', dest="verbose", action="store_true", default=False,
      help='verbose')
  parser.add_argument('-n', dest="dry", action="store_true", default=False,
      help='Dry run. No changes to fs.')
  parser.add_argument('-f', dest="force", action="store_true", default=False,
      help='Commit changes to fs.')
  parser.add_argument('-c', dest="clean", action="store_true", default=False,
      help='Clean links')
  args = parser.parse_args()

  args.git_dir = os.path.dirname(os.path.abspath(__file__))
  args.hostname = os.uname()[1]
  args.home = os.path.expanduser("~")

  if args.hostname == 'any':
    print("Hostname cannot be 'any'.")
    sys.exit(1)

  if not ((args.dry and not args.force) or (not args.dry and args.force)):
    print("Exactly one of dry or force must be turned on.")
    sys.exit(1)

  if args.verbose:
    print("Current parameters:")
    print("  Verbose: " + str(args.verbose))
    print("  Clean: " + str(args.clean))
    print("  Git directory: " + args.git_dir)
    print("  Hostname: " + args.hostname)
    print("  Dry run: " + str(args.dry))
    print("  Force: " + str(args.force))

  return args

def clean_links(verbose, force, home):
  dirs = dirs_to_check_for_dead_links()

  for (direc, recursive) in dirs:
    direc = os.path.join(home, direc)
    if recursive:
      clean_links_recurse(verbose, force, direc)
    else:
      clean_links_no_recurse(verbose, force, direc)

def clean_links_recurse(verbose, force, direc):
  for root, sub_folder, files in os.walk(direc):
    for f in files:
      f = os.path.join(root, f)
      remove_if_dead_link(verbose, force, f)

def clean_links_no_recurse(verbose, force, direc):
  files = os.listdir(direc)
  for f in files:
    f = os.path.join(direc, f)
    remove_if_dead_link(verbose, force, f)

def remove_if_dead_link(verbose, force, link):
  if not os.path.islink(link):
    return

  link_dest = os.readlink(link)
  if not os.path.isabs(link_dest):
    link_dest = os.path.join(os.path.dirname(link), link_dest)

  if not os.path.exists(link_dest):
    if verbose:
      print("Removing dead link: " + link)
    if force:
      os.remove(link)

def makelinks(verbose, force, home, direc):
  for root, sub_folder, files in os.walk(direc):
    for f in files:
      link_src = os.path.join(root, f)
      link_dest = os.path.join(home, os.path.relpath(link_src, direc))

      if not (os.path.islink(link_dest) and os.readlink(link_dest) == link_src):
        if os.path.isfile(link_dest) or (os.path.islink(link_dest) and not os.readlink(link_dest) == link_src):
          if verbose:
            print("Removing: " + link_dest)
          if force:
            os.remove(link_dest)

        if verbose:
          print("Making: " + link_src + " -> " + link_dest)
        if force:
          os.symlink(link_src, link_dest)

def main():
  args = parse_args()

  if args.clean:
    clean_links(args.verbose, args.force, args.home)

  makelinks(args.verbose, args.force, args.home, os.path.join(args.git_dir, "any"))

  if os.path.exists(args.hostname):
    makelinks(args.verbose, args.force, args.home, os.path.join(args.git_dir, args.hostname))

if __name__ == "__main__":
  main()

