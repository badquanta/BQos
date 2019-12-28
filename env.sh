#!/usr/bin/env bash

PREFIX="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export -x PREFIX
TARGET=i386-elf
export TARGET
PATH="$PREFIX/bin:$PATH"
export -x PATH
export 
echo -n "$0 :"
#echo $PREFIX
#echo $TARGET
echo $PATH
