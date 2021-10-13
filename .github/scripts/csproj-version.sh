#!/bin/bash

if [ -z ${1+x} ]; then
    echo "The script expects 1 argument: the project file path."
    exit 2
fi

if ! [ -f $1 ]; then
    echo "Project file $1 doesn't exist."
    exit 1
fi

cat $1 |\
    grep -Eo '<Version>[0-9]+\.[0-9]+\.[0-9]+(?:-(?:[a-z]|[A-Z])+)?<\/Version>' |\
    perl -pe 's/<Version>//g and s/<\/Version>//g'