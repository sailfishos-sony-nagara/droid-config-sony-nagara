%package -n patterns-sailfish-device-configuration-%{rpm_device}
Summary: Jolla Configuration %{rpm_device}
Requires: patterns-sailfish-device-configuration-common-%{rpm_device}
Requires: patterns-sailfish-device-adaptation-%{device}

Requires: droid-config-%{rpm_device}-sailfish
Requires: droid-config-%{rpm_device}-pulseaudio-settings
Requires: droid-config-%{rpm_device}-policy-settings
Requires: droid-config-%{rpm_device}-preinit-plugin
Requires: droid-config-%{rpm_device}-flashing
Requires: droid-config-%{rpm_device}-bluez5
Requires: droid-hal-version-%{rpm_device}

# For devices with cellular modem. Those without one, please comment out:
Requires: patterns-sailfish-cellular-apps

Requires: sailfish-content-graphics-z%{icon_res}

# For multi-SIM devices
# Disabled until eSIM support is added
#Requires: jolla-settings-networking-multisim

# Flashlight
Requires: jolla-settings-system-flashlight

# For devices which support NFC
Requires: jolla-settings-system-nfc
Requires: nfcd-dbuslog-plugin
Requires: nfcd-mce-plugin

# For Mozilla location services (online)
Requires: geoclue-provider-mlsdb

# Devices with 2G or more memory should also include this booster
# to improve camera startup times and the like
Requires: mapplauncherd-booster-silica-qt5-media

%description -n patterns-sailfish-device-configuration-%{rpm_device}
Pattern with packages for %{rpm_device} configurations

%files -n patterns-sailfish-device-configuration-%{rpm_device}