#!/usr/bin/env bash
for i in $1; do
    if test -e $i; then echo "☑" $2 $i; else echo "☐" $2 $i; fi
done