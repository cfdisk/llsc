#!/bin/sh

# scan directory and interactivly delete oldest file while below threshold

THRESHOLD=10000000
MOVIEDIR=/mnt/hdd/movie/

##############################################################################

checkFree() {
    sync
    freeSpace=`df $MOVIEDIR | tail -n 1`
    freeSpace=`echo $freeSpace | awk -F " " '{print $4}'`
    echo $freeSpace
}

getOldestFile() {
    oldestFile="$(ls -1t $MOVIEDIR | tail -1)"
    echo $oldestFile
}

while [ `checkFree` -le "$THRESHOLD" ]; do
    echo "######################################################"
    echo "Media ($MOVIEDIR) almost full: Free: `checkFree` / Threshold: $THRESHOLD"
    echo "Oldest File: $MOVIEDIR`getOldestFile`"
    rm -i $MOVIEDIR/`getOldestFile`
    #mv $MOVIEDIR/`getOldestFile` /mnt/hdd/tmp
    sleep 1
done

exit 0
