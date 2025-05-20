#!/bin/bash

# bind mounts to mask odm inits
for init_s in init.sony-platform.rc init.sony.rc ;
do
   init=/odm/etc/init/$init_s
   echo Masking $init
   mount -o bind /dev/null $init
done

# mount overlays
mount-overlays /overlays
