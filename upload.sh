#!/bin/bash
set -euo pipefail

SVNVER=$(svnversion | grep -o '[0-9]*' | tail -n 1)
PATTYVER=$(cat patty.version)

VER=${SVNVER}_${PATTYVER}

scp $VER.tar.bz2   Rastaf0@92.255.21.18:
ssh Rastaf0@92.255.21.18 '~/unpack.sh' $VER
