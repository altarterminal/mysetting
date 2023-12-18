#!/bin/sh
set -eu

######################################################################
# 設定
######################################################################

tdir=~/Tools
ddir="${tdir}/download"
idir="${tdir}/install"

######################################################################
# 設定
######################################################################

print_usage_and_exit () {
  cat <<-USAGE 1>&2
	Usage   : ${0##*/}
	Options : -c

	必要な環境をインストールする。

	-cオプションでシステムにコマンドをインストールする（要管理者権限）。
	USAGE
  exit 1
}

######################################################################
# パラメータ
######################################################################

opr=''
opt_c='no'

i=1
for arg in ${1+"$@"}
do
  case "$arg" in
    -h|--help|--version) print_usage_and_exit ;;
    -c)                  opt_c='yes'          ;;
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

iscmdinstall=$opt_c

######################################################################
# 事前準備
######################################################################

mkdir -p "$ddir"
mkdir -p "$idir"

######################################################################
# 本体処理
######################################################################

# shellshoccar
(
  # 既存のツールを削除
  cd "$idir"
  [ -d 'shellshoccar' ] && rm -rf 'shellshoccar'

  # ツールを配置
  cd "$ddir"
  [ -d 'shellshoccar' ] && rm -rf 'shellshoccar'
  git clone https://github.com/ShellShoccar-jpn/installer.git shellshoccar
  cd shellshoccar
  sh shellshoccar.sh --prefix="${idir}/shellshoccar" install

  # パスを追加
  estr='export PATH="'"${idir}/shellshoccar/bin:"'${PATH}''"'
  if ! cat ~/.bashrc | grep -q "$estr"; then
    echo "$estr" >> ~/.bashrc
  fi
)

# コマンドインストール
if [ "$iscmdinstall" = 'yes' ]; then
  sudo apt install -y vim screen
  sudo apt install -y gawk
  sudo apt install -y nkf
fi
