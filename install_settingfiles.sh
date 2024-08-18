#!/bin/sh
set -eu

######################################################################
# setting
######################################################################

print_usage_and_exit () {
  cat <<USAGE 1>&2
Usage   : ${0##*/}
Options : -f

copy the setting files

-f: replace the existing files
USAGE
  exit 1
}

######################################################################
# parameter
######################################################################

opr=''
opt_f='no'

i=1
for arg in ${1+"$@"}
do
  case "$arg" in
    -h|--help|--version) print_usage_and_exit ;;
    -f)                  opt_f='yes'          ;;
    *)
      if [ $i -eq $# ] && [ -z "$opr" ]; then
        opr=$arg
      else
        echo "${0##*/}: invalid args" 1>&2
        exit 11
      fi
      ;;
  esac

  i=$((i + 1))
done

IS_FORCE=${opt_f}

TOP_DIR=$(dirname $0)
SRC_DIR="${TOP_DIR}/setting"
DST_DIR=${HOME}

######################################################################
# main routine
######################################################################

find "${SRC_DIR}" -type f                                            |
while read -r src_file;
do
  dst_file="${DST_DIR}/${src_file##*/}"

  if [ "${opt_f}" = 'no' ] && [ -e "${dst_file}" ]; then
    echo "${0##*/}: there is existing file <${dst_file}> and skip copy" 1>&2
    continue
  fi

  cp "${src_file}" "${dst_file}"
done
