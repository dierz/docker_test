#!/bin/bash
if [ -x /usr/bin/nextid ]
then
    sudo rm /usr/bin/nextid
else
    echo error!
    exit 1
fi
if [ ! -e /usr/bin/nextid ]
then
    echo "Application has successfully uninstalled"
else
    echo rm error
    exit 1
fi
