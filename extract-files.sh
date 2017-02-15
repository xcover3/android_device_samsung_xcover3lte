#!/bin/sh

LOS_TOP=../../..
BOARD=marvell/pxa1088
VENDOR=samsung
DEVICE=degaswifi

BASE=$LOS_TOP/vendor/$BOARD/$VENDOR/$DEVICE/

mkdir -p $BASE

for FILE in `cat proprietary-files.txt | grep -v "^#"`; do

    echo Pulling $FILE to $BASE/$(dirname "${FILE}")

	# Check if pull dir already exists in $BASE
	if [ ! -d $BASE/$(dirname "${FILE}") ]; then
		mkdir -p $BASE/$(dirname "${FILE}")
	fi

    adb pull /system/$FILE $BASE/$(dirname "${FILE}")
done

./setup-makefiles.sh