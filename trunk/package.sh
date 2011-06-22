#!/bin/bash
set -euo pipefail

SVNVER=$(svnversion | grep -o '[0-9]*' | tail -n 1)
PATTYVER=$(cat patty.version)

VER=${SVNVER}_${PATTYVER}
if [ -f $VER.tar.bz2 ]; then
	echo "$VER.tar.bz2 is already here"
	exit 1
fi
mkdir $VER

ln tgstation.dmb tgstation.rsc $VER/
tar -cjf $VER.tar.bz2 --owner=0 $VER
rm -rf $VER

