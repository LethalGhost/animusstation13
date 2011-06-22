#!/bin/bash
set -euo pipefail

make || exit $?
bzip2 --best -f --keep tgstation.dmb || exit $?

SVNVER=$(svnversion | grep -o '[0-9]*')
PATTYVER=$(cat patty.version)
VER=${SVNVER}_${PATTYVER}

scp tgstation.dmb.bz2 Rastaf0@92.255.21.18: || exit $?
ssh Rastaf0@92.255.21.18 "
cd /home/byond/tgstation/ && 
mv ~/tgstation.dmb.bz2 . && 
rm tgstation.dmb && 
bunzip2 tgstation.dmb.bz2
chmod ug+w builds/$VER &&
rm builds/$VER/tgstation.dmb &&
cp tgstation.dmb builds/$VER/tgstation.dmb &&
chgrp animusstation builds/$VER/tgstation.dmb &&
chmod ug-w builds/$VER &&
for i in black white; do cd \$i; ./select.sh $VER; cd ..; done
"

