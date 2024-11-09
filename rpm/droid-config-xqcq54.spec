%define device pdx224
%define rpm_device xqcq54

%define device_pretty Xperia 5 IV

# Community HW adaptations need this
%define community_adaptation 1

# specify to match available ration of sailfish-content-graphics-z{} packages
%define pixel_ratio 2.0

%include droid-config-common.inc
%include droid-configs-device/droid-configs.inc
%include patterns/patterns-sailfish-device-adaptation.inc
%include patterns/patterns-sailfish-device-configuration.inc
