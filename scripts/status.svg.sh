#!/usr/bin/env bash
#status.svg.sh
# Created on: Jan 11, 2020
#     Author: badquanta
if [ -z $1 ]; then
    TARGET="all"
else 
    TARGET=$1
fi
if [ -z $2 ]; then
    FILE=$TARGET.svg
    FILE=${FILE//\//__}
else
    FILE=$2
fi

echo "Creating SVG graph of target: $TARGET as $FILE"
rm -f $FILE
make $TARGET -nd | make2graph | unflatten | dot -y -T svg -o $FILE
