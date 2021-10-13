#!/bin/bash

if [ -z ${1+x} ]; then
    echo "The script expects 1 argument: the project file path."
    exit 2
fi

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ver=`bash ${__dir}/csproj-version.sh $1`

if ! [ $? == 0 ]; then
    echo "Version couldn't be parsed."
    echo $ver
    exit 3
fi

echo "Project version is ${ver}. Tagging..."

git tag ${ver}

echo "Pushing tags..."

git push origin ${ver}