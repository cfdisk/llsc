#!/bin/sh

detectShell() {
    # output may be:
    # bash
    # sh
    # busybox
    # ...
    
    ps -p $PPID -ocomm=
    # or:
    ls -l /proc/$PPID/exe | sed 's%.*/%%'
}

detectShell
