#!/bin/bash

mount -o bind /dev/null /system/system_ext/etc/gsi/init.vndk-nodef.rc

# mount used overlays
WDIR=/overlays/.work

mkdir -p $WDIR/system/lib
mkdir -p $WDIR/system/lib64

mount -t overlay overlay -o lowerdir=/system/lib,upperdir=/overlays/system/lib,workdir=$WDIR/system/lib /system/lib
mount -t overlay overlay -o lowerdir=/system/lib64,upperdir=/overlays/system/lib64,workdir=$WDIR/system/lib64 /system/lib64
