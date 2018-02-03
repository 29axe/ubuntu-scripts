#!/bin/sh
if trayopen /dev/sr0
then
    eject -t
else
    eject
fi

