#!/bin/bash

cat $1 |\
    grep -Eo '<Version>[0-9]+\.[0-9]+\.[0-9]+-.*<\/Version>' |\
    perl -pe 's/<Version>//g and s/<\/Version>//g'