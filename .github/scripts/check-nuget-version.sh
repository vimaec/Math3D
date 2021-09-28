#!/bin/bash

ver=`./csproj-version.sh`

echo "Project version is ${ver}. Checking NuGet versions..."

for nuget in $(nuget list -AllVersions $2 | awk '{print $2}')
do
    if [ $nuget == ${ver} ] || [ $nuget == "v${ver}" ] || ([ ${ver:0:1} == 'v' ] && [ $nuget == ${ver:1} ]) ; then
        echo "The NuGet version $nuget already exists. The package cannot be pushed."
        exit 1
    fi
done