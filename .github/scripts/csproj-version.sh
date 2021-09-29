#!/bin/bash

cat $1 |\
    grep -Eo '<Version>[0-9]+\.[0-9]+\.[0-9]+(?:-(?:[a-z]|[A-Z])+)?<\/Version>' |\
    perl -pe 's/<Version>//g and s/<\/Version>//g'