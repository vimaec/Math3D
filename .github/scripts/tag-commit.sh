#!/bin/bash

# ver=`xpath -e '/Project/PropertyGroup/Version/text()' -q $1`
ver=`cat $1 | grep -Eo '<Version>[0-9].[0-9].[0-9]<\/Version>' | grep -Eo '[0-9].[0-9].[0-9]'`

echo "Project version is ${ver}. Tagging..."

git tag ${ver}

echo "Pushing tags..."

git push origin ${ver}