#! /bin/bash

# This is used to obtain the absolute path of certain files.
# The script is copied and referenced from the following link:

################################################################################
# @Function
# convert to Absolute Path.
# 
# @Usage
#   # print Absolute Path of current directory.
#   $ ./ap
#   # print Absolute Path of arguments.
#   $ ./ap a.txt ../dir1/b.txt
# 
# @online-doc https://github.com/oldratlee/useful-scripts/blob/dev-3.x/docs/shell.md#-ap-and-rp
# @author Jerry Lee (oldratlee at gmail dot com)
################################################################################



# set -e: exit on error
#     -E: inherit error status
#     -u: exit on using undefined variable
#     -o pipefail: exit on pipe fail

set -eEuo pipefail


# `realpath` command exists on Linux and macOS, return resolved physical path
#   - realpath command on macOS do NOT support option `-e`;
#     combined `[ -e $file ]` to check file existence first.
#   - How can I get the behavior of GNU's readlink -f on a Mac?
#     https://stackoverflow.com/questions/1055671
realpath() {
  [ -e "$1" ] && command realpath -- "$1"
}

################################################################################
# parse options
################################################################################

files=()
while (($# > 0)); do
  case "$1" in
  --)
    shift
    files=(${files[@]:+"${files[@]}"} "$@")
    break
    ;;
  *)
    # if not option, treat all follow files as args
    files=(${files[@]:+"${files[@]}"} "$@")
    break
    ;;
  esac
done

# if files is empty, use "."
readonly files=("${files[@]:-.}")

################################################################################
# biz logic
################################################################################

has_error=false

for f in "${files[@]}"; do
  realpath "$f" || {
    has_error=true
    echo "$f: No such file or directory!"
  }
done

# set exit status
! $has_error