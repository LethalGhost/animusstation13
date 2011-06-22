#!/bin/bash
source /usr/local/bin/byondsetup
NAME=`basename $1 .dme`
fname=`mktemp`
trap "rm $fname" SIGINT SIGTERM
DreamMaker "$NAME.dme" | tee $fname | awk '/:/ { print $0 }' >&2
grep --line-buffered "saving $NAME.dmb" > /dev/null <$fname
err=$?
rm $fname
exit $err