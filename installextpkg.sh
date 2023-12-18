#!/bin/sh
set -eu

######################################################################
# 設定
######################################################################

tdir=~/Tools
ddir="${tdir}/download"
idir="${tdir}/install"

print_usage_and_exit () {
  cat <<-USAGE 1>&2
	Usage   : ${0##*/}
	Options : -f

	必要な環境をインストールする。

	-fオプションで既存のディレクトリを削除して再インストールできる。
	USAGE
  exit 1
}

######################################################################
# パラメータ
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

isreinstall=$opt_f

######################################################################
# 事前準備
######################################################################

mkdir -p "$ddir"
mkdir -p "$idir"

#####################################################################
# 前準備
######################################################################

if [ "$isreinstall" == 'yes' ]; then
  # 既存のツールを削除
  cd "$idir"

  [ -d 'shellshoccar' ] && rm -rf 'shellshoccar'
fi

######################################################################
# 本体処理
######################################################################

# shellshoccar
(
  cd "$ddir"

  # インストール本体処理
  if [ ! -d 'shellshoccar' ]; then
    git clone https://github.com/ShellShoccar-jpn/installer.git shellshoccar
    cd shellshoccar
    sh shellshoccar.sh --prefix="${idir}/shellshoccar" install
  fi

  # パスを追加
  estr='export PATH="'"${idir}/shellshoccar/bin:"'${PATH}''"'
  if ! cat ~/.bashrc | grep -q "$estr"; then
    echo "$estr" >> ~/.bashrc
  fi
)
