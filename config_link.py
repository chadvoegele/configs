#!/usr/bin/env python
import os, argparse, re, sys, errno, filecmp

def my_parse_args():
  parser = argparse.ArgumentParser(description='Link configs from git to local')
  parser.add_argument('-v', dest="verbose", action="store_true", default=False,
      help='verbose')
  parser.add_argument('-t', dest="test", action="store_true", default=False,
      help='run in test mode. (don\'t change the fs)')
  conf_file = os.path.expanduser("~/.config_git/") + 'config_git_' + \
    os.uname()[1]
  parser.add_argument('-c', dest="config", action="store", default=conf_file,
      help='config link file')
  git_dir = os.path.expanduser("~/.config_git")
  parser.add_argument('-d', dest="git_dir", action="store", default=git_dir,
      help='git config directory')
  args = parser.parse_args()

  if args.verbose:
    print("Current parameters:")
    print("  Verbose: " + str(args.verbose))
    print("  Test: " + str(args.test))
    print("  Config file: " + args.config)
    print("  Git directory: " + args.git_dir)

  return args

def read_config_file(args):
  file_open = open(args.config, "r")
  file_read = []
  for line in file_open:
    # remove comments, whitespace, newlines
    line = re.sub("#.*$", "", line)
    line = re.sub("\s*\n", "", line)
    line = re.sub("\$CONFIG_GIT", args.git_dir, line)
    line = re.sub("\$HOME", os.path.expanduser("~"), line)
    split = line.split(' ')
    if not line == '':
      file_read.append(split)
  file_open.close()
  return file_read

def check_config_file(config_link_read, args):
  number_links = len(config_link_read)
  number_files_directory = 0
  for root, sub_folder, files in os.walk(args.git_dir):
    for file in files:
      if not re.match(".*\.git.*", root):
        number_files_directory = number_files_directory + 1
  if args.verbose:
    print("There are " + str(number_files_directory) + \
        " files in the git directory.")
    print("There are " + str(number_links) + \
        " config files to be linked.")
  if not number_links == number_files_directory:
    print("The number of files in the git dir and the config link list do " + \
        "not match. Quitting.")
    sys.exit(1)

def get_yes_no():
  choice = input().lower()
  if not (choice == 'y' or choice == 'n'):
    print("Invalid response. Quitting.")
    sys.exit(1)
  return choice

def write_link_record(link, args):
  link_record_file = open(args.git_dir + "/" + "link_record_" + 
      os.uname()[1], "r")
  for line in link_record_file.readlines():
    line = re.sub("\n", "", line)
    if line == link:
      return
  link_record_file.close()  
  link_record_file = open(args.git_dir + "/" + "link_record_" + 
      os.uname()[1], "a")
  link_record_file.writelines(link + "\n")
  link_record_file.close()

def remove_link_record(link, args):
  link_record_file = open(args.git_dir + "/" + "link_record_" + 
      os.uname()[1], "r")
  link_record_read = link_record_file.readlines()
  link_remove = []
  for i in range(0, len(link_record_read)):
    # line = re.sub("\n", "", line)
    if link == re.sub("\n", "", link_record_read[i]):
      link_remove.append(i)
  
  # need to adjust indices for prior removals
  for i in range(0, len(link_remove)):
    link_record_read.remove(link_record_read[link_remove[i]-i])

  link_record_file.close()
  link_record_file = open(args.git_dir + "/" + "link_record_" + 
      os.uname()[1], "w")
  link_record_file.writelines(link_record_read)
  link_record_file.close()

def check_dead_links(args):
  link_record_file = open(args.git_dir + "/" + "link_record_" + 
      os.uname()[1], "r")
  for link in link_record_file.readlines():
    link = re.sub("\n", "", link)
    if not os.path.lexists(link):
      print("Link record is corrupted. " + link + " does not exist in" +\
          " the filesystem. Please check. Quitting")
      sys.exit(1)
    if not os.path.exists(os.readlink(link)):
      print(link + " is dead. Remove [Y/n]?")
      answer = get_yes_no()
      if answer == 'y':
        if args.verbose:
          print("Removing " + link)
        if not args.test:
          remove_link_record(link, args)
          os.remove(link)

def link_files(config_link_read, args):
  for config_file in config_link_read:
    if not config_file[1] == '-':
      if not os.path.exists(config_file[0]):
        print("Git_dir config file, "  + config_file[0] + ", does not " +  \
            "exist. Quitting.")
        sys.exit(1)
      if not os.path.exists(os.path.dirname(config_file[1])):
        print("Local config dir, " + os.path.dirname(config_file[1]) + \
            ", does not exist. Quitting.")
        sys.exit(1)
      if os.path.exists(config_file[1]) and not os.path.islink(config_file[1]):
        if filecmp.cmp(config_file[0], config_file[1]):
          print("")
          print(config_file[1] + " is a file and not a sym link.")
          print("The git-dir file and the local file are the same.")
          print("Delete the file and make a sym link from " + \
              args.git_dir + "? [Y/n]")
          answer = get_yes_no()
          if answer == 'n':
            print("Skipping " + config_file[1])
            continue
      if os.path.exists(config_file[1]) and os.path.islink(config_file[1]):
        if os.path.realpath(config_file[1]) == config_file[0]:
          if args.verbose:
            print("Link from " + config_file[0] + " to \n    " + config_file[1] + \
                " already exists. Skipping.")
          continue
      if args.verbose:
        print("Linking " + config_file[1] + " to " + config_file[0])
      if not args.test:
        if os.path.exists(config_file[1]) and not os.path.islink(
            config_file[1]):
          os.remove(config_file[1])
        os.symlink(config_file[0], config_file[1])
        write_link_record(config_file[1], args)

def main():
  args = my_parse_args()
  check_dead_links(args)
  config_link_read = read_config_file(args)
  check_config_file(config_link_read, args)
  link_files(config_link_read, args)

if __name__ == "__main__":
  main()
