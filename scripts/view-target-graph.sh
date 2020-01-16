#!/usr/bin/env bash
#make-target-graph.sh
# Created on: Jan 11, 2020
#     Author: badquanta
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
FILE=`$DIR/make-target-graph.sh $@`
xdg-open $FILE