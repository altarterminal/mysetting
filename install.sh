#!/bin/sh
set -eu

######################################################################
# 設定
######################################################################

tdir=~/Tools
ddir="${tdir}/download"
idir="${tdir}/install"

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
