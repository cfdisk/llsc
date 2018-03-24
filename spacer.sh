#!/bin/sh

# scan directory and interactivly delete oldest file while below threshold

threshold=1000000000
datadir=/tmp

##############################################################################

checkfree() {
    sync
    freespace=$( df $datadir | tail -n 1 )
    freespace=$( echo $freespace | awk -F " " '{print $4}' )
    echo "$freespace"
}

getoldestfile() {
    oldestfile="$(find $datadir/ -type f -printf '%p\n' | sort | head -n 1)"
    #oldestfile="$(ls -1t $datadir | tail -1)"
    echo "$oldestFile"
}

while [ `checkfree` -le "$threshold" ]; do
    echo "######################################################"
    echo "Media ($datadir) below threshold (Free: $(checkfree) / threshold: $threshold)"
    oldestfile=`getoldestfile`
    echo "Oldest File: $datadir$oldestfile"
#    rm -i "$datadir/$oldestfile"
#    touch "$datadir/$oldestfile" 2&1>/dev/null
    #mv $datadir/$oldestfile /mnt/hdd/tmp
    sleep 1
done

echo "Media ($datadir) Free: `checkfree` / threshold: $threshold"

exit 0
