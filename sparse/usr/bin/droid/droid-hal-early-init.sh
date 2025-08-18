#!/bin/bash

# prerequisite for double-tap-to wake
echo 1 > /sys/devices/dsi_panel_driver/pre_sod_mode

# accesible binder devices in /dev
ln -sf /dev/binderfs/* /dev/

