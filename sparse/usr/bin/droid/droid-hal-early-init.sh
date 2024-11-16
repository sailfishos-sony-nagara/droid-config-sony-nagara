#!/bin/bash

# bind mounts
mount -o bind /dev/null /system/system_ext/etc/gsi/init.vndk-nodef.rc

# overlays
mount-overlays /overlays
