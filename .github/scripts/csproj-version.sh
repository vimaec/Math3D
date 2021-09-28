#!/bin/bash

cat $1 | grep -Eo '<Version>[0-9]+.[0-9]+.[0-9]+<\/Version>' | grep -Eo '[0-9]+.[0-9]+.[0-9]+'