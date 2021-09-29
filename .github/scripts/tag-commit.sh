#!/bin/bash

ver=`./csproj-version.sh $1`

echo "Project version is ${ver}. Tagging..."

git tag ${ver}

echo "Pushing tags..."

git push origin ${ver}