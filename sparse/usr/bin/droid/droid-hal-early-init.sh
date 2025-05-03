#!/bin/bash

# bind mounts
# mount -o bind /dev/null /system/system_ext/etc/gsi/init.vndk-nodef.rc

# overlays
# mount-overlays /overlays

# load modules as in early init (odm/etc/init/init.sony-device-common.rc)
for module in sec_touchscreen bu520x1nvx et603-int ;
do
   echo Loading $module
   /sbin/insmod /vendor/lib/modules/$module.ko
done

# required to enable touch
echo 1 > /sys/devices/virtual/sec/tsp/after_work
echo 1 > /sys/module/sec_touchscreen/parameters/report_rejected_event
