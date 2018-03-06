#!/bin/sh

# scan directory and interactivly delete oldest file while below threshold

THRESHOLD=1000000000
DATADIR=/mnt/hdd/movie/

##############################################################################

checkFree() {
    sync
    freeSpace=`df $DATADIR | tail -n 1`
    freeSpace=`echo $freeSpace | awk -F " " '{print $4}'`
    echo $freeSpace
}

getOldestFile() {
    oldestFile="$(find $DATADIR/ -type f -printf '%p\n' | sort | head -n 1)"
    #oldestFile="$(ls -1t $DATADIR | tail -1)"
    echo $oldestFile
}

while [ `checkFree` -le "$THRESHOLD" ]; do
    echo "######################################################"
    echo "Media ($DATADIR) almost full: Free: `checkFree` / Threshold: $THRESHOLD"
    _oldestFile=`getOldestFile`
    echo "Oldest File: $DATADIR$_oldestFile"
    touch "$DATADIR/$_oldestFile"
    rm -i "$DATADIR/$_oldestFile"
    #mv $DATADIR/$_oldestFile /mnt/hdd/tmp
    sleep 1
done

echo "Media ($DATADIR) Free: `checkFree` / Threshold: $THRESHOLD"

exit 0
