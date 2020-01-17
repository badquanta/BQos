#!/usr/bin/env bash
#make-target-graph.sh
# outputs the name of file it generated.
# Created on: Jan 11, 2020
#     Author: badquanta
if [ ! -e docs/make ]; then    
    mkdir -p docs/make
fi

if [ -z $1 ]; then
    TARGET="all"
else 
    TARGET=$1
fi
if [ -z $2 ]; then
    FILE=$TARGET.svg
    FILE=${FILE//\//__}
    FILE=docs/make/target-$FILE
else
    FILE=$2
fi

#echo "Creating SVG graph of target: $TARGET as $FILE"
rm -f $FILE


make $TARGET -nd | make2graph | sed s@$PWD\/@@g | sed s@\/@\/\\n@g | dot -y -T svg -o $FILE

echo $FILE
