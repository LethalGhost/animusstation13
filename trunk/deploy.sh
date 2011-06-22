#!/bin/bash
set -euo pipefail

make || exit $?
./package.sh || exit $?

SVNVER=$(svnversion | grep -o '[0-9]*' | tail -n 1)
PATTYVER=$(cat patty.version)
VER=${SVNVER}_${PATTYVER}

scp $VER.tar.bz2 Rastaf0@92.255.21.18: || exit $?
ssh Rastaf0@92.255.21.18 "
~/unpack.sh $VER;
cd /home/byond/tgstation/;
for i in black white; do cd \$i; ./select.sh $VER; cd ..; done;"

