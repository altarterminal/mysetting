#!/bin/sh
set -eu

######################################################################
# 設定
######################################################################

print_usage_and_exit () {
  cat <<-USAGE 1>&2
	Usage   : ${0##*/}
	Options :

	必要な環境をインストールする（apt）。
	※管理者権限が必要

	USAGE
  exit 1
}

######################################################################
# パラメータ
######################################################################

opr=''

i=1
for arg in ${1+"$@"}
do
  case "$arg" in
    -h|--help|--version) print_usage_and_exit ;;
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

######################################################################
# 本体処理
######################################################################

sudo apt install -y vim screen
sudo apt install -y gawk
sudo apt install -y nkf
