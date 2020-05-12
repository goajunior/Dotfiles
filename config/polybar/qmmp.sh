#!/bin/bash
status=`qmmp --nowplaying '%p - %t'`
if [[ $status == "-" ]]
then
    echo "Stopped"
else
    echo "$status"
fi
