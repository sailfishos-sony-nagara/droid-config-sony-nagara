#!/bin/sh
#Misc setup script

WHICH=/apex/com.android.art/lib/libnativehelper.so

# wait for a file we know its last mounted in linkerconfig
echo "Waiting for $WHICH to be mounted.."
while [ ! -f $WHICH ]; do sleep 1; done;
echo "Waiting for $WHICH done."

# Transform softlinks into real copies where needed
find /overlays -type l | while read SOFTLINK; do cp -f `readlink $SOFTLINK` $SOFTLINK; done

