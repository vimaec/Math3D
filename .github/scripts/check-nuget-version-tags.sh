#!/bin/bash

ver=`./csproj-version.sh $1`

echo "Project version is ${ver}. Checking git tags..."

git fetch origin 'refs/tags/*:refs/tags/*'

for tag in $(git tag)
do
    if [ $tag == ${ver} ] || [ $tag == "v${ver}" ] || ([ ${ver:0:1} == 'v' ] && [ $tag == ${ver:1} ]) ; then
        echo "The tag $tag already exists. The package cannot be pushed."
        exit 1
    fi
done