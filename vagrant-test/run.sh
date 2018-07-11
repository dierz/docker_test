#!/bin/bash
if [ -r ./src/nextid.c ]
then
    gcc ./src/nextid.c -o ./src/nextid
else
    echo File src/nextid.c not found! Check dir where you are currently located.
    exit 1
fi
if [ -x ./src/nextid ]
then
    sudo mv ./src/nextid /usr/bin/nextid
else
    echo Compilation error!
    exit 1
fi
if [ -x /usr/bin/nextid ]
then
    echo "Application has successfully installed"
else
    echo mv error
    exit 1
fi

