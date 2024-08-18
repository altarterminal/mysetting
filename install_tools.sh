#!/bin/sh
set -eu

######################################################################
# setting
######################################################################

print_usage_and_exit () {
  cat <<USAGE 1>&2
Usage   : ${0##*/}
Options : -f

install tools.

-f: delete the existing files
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

TOOL_DIR=${HOME}/Tools
DOWNLOAD_DIR=${TOOL_DIR}/download
INSTALL_DIR=${TOOL_DIR}/install

######################################################################
# prepare
######################################################################

mkdir -p "${DOWNLOAD_DIR}"
mkdir -p "${INSTALL_DIR}"

if [ "${IS_FORCE}" = 'yes' ]; then
  (
    cd "${INSTALL_DIR}"
    [ -d 'shellshoccar' ] && rm -rf 'shellshoccar'
  )
fi

######################################################################
# main routine
######################################################################

# shellshoccar
(
  if [ ! -d "${INSTALL_DIR}/shellshoccar" ]; then
    cd "${DOWNLOAD_DIR}"

    [ -d 'shellshoccar' ] && rm -rf 'shellshoccar'
    git clone 'https://github.com/ShellShoccar-jpn/installer.git' 'shellshoccar'

    cd 'shellshoccar'
    sh shellshoccar.sh --prefix="${INSTALL_DIR}/shellshoccar" install
  fi

  PATH_DESC='export PATH="'"${INSTALL_DIR}/shellshoccar/bin:"'${PATH}''"'
  if ! cat ~/.bashrc | grep -q "${PATH_DESC}"; then
    echo "${PATH_DESC}" >> ~/.bashrc
  fi
)
