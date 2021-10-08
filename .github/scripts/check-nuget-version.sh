#!/bin/bash

if [ -z ${2+x} ]; then
    echo "The script expects 2 arguments: (1) project file path and (2) package name."
    exit 2
fi

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ver=`bash ${__dir}/csproj-version.sh $1`

if ! [ $? == 0 ]; then
    echo "Version couldn't be parsed."
    echo $ver
    exit 3
fi

echo "Project version is ${ver}. Checking NuGet versions..."

for nuget in $(nuget list -AllVersions $2 | awk '{print $2}')
do
    echo "Version found $nuget"

    if [ $nuget == ${ver} ] || [ $nuget == "v${ver}" ] || ([ ${ver:0:1} == 'v' ] && [ $nuget == ${ver:1} ]) ; then
        echo "The NuGet version $nuget already exists. The package cannot be pushed."
        exit 1
    fi
done