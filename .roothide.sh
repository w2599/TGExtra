#!/bin/bash

## export LC_ALL=C
export THEOS=/Users/zqbb/theos_roothide
export THEOS_DEVICE_IP=192.168.31.158
export THEOS_DEVICE_PORT=2222
export ARCHS=arm64

buildPath="$(dirname "$(dirname "$0")")/__build_roothide/$(basename "$(dirname "$0")")"
echo "buildPath: $buildPath"

cd $(dirname $0);pwd


versionFile=$(ls _version_* | head -n 1)
versionSee=$(echo $versionFile | sed 's/_version_//g')


## Switch Compilation Path
rm -rf $buildPath && mkdir -p $buildPath && cp -a ./ $buildPath && cd $buildPath


## Replace version number
sed -i '' "s/^\(Version:\s*\).*/\1 ${versionSee}/" control


if [ $1 -eq "1" ]
then
    export THEOS_PACKAGE_SCHEME=roothide
	make do -j$(sysctl -n hw.physicalcpu)
	exit
fi
