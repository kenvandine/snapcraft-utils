#!/bin/bash

usage() {
    echo "USAGE: $0 <SNAP> <ARCH> <OLDCHANNEL> <NEWCHANNEL>";
    exit 1;
}

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ] || [ -z $4 ];
then
    usage;
fi

snap=$1
arch=$2
oldchannel=$3
newchannel=$4

rev=`snapcraft revisions $snap --arch $arch | grep $oldchannel|head -1|grep -v $newchannel | awk '{print $1}'`

if [ -z $rev ];
then
    echo "No suitable revision found"
else
    echo "publishing $rev of $snap from $oldchannel to $newchannel"
    snapcraft release $snap $rev $newchannel
fi
