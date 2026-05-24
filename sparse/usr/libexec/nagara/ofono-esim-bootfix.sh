#!/bin/sh

LPAC=/usr/bin/lpac
GETPROP=/system/bin/getprop

TARGET_MODEMS="array:objpath:/ril_0"

log() {
    echo "[esim-fix] $*"
}

#
# Wait for Android properties to become available
#
wait_for_device() {
    while :; do
        DEVICE="$($GETPROP ro.product.device 2>/dev/null)"

        if [ -n "$DEVICE" ]; then
            echo "$DEVICE"
            return 0
        fi

        sleep 1
    done
}

#
# Wait until ofono exposes enabled modems
#
wait_for_modems() {
    while :; do
        OUTPUT="$(dbus-send --system \
            --print-reply \
            --dest=org.ofono \
            / \
            org.nemomobile.ofono.ModemManager.GetEnabledModems \
            2>/dev/null)"

        if [ -n "$OUTPUT" ]; then
            echo "$OUTPUT"
            return 0
        fi

        sleep 1
    done
}

#
# Check whether ril_1 is enabled
#
ril1_enabled() {
    echo "$1" | grep -q '"/ril_1"'
}

#
# Check if lpac has at least one enabled profile
#
has_enabled_profile() {
    [ -x "$LPAC" ] || return 1

    "$LPAC" profile list 2>/dev/null | python3 -c '
import json
import sys

try:
    data = json.load(sys.stdin)

    profiles = data.get("payload", {}).get("data", [])

    for p in profiles:
        if p.get("profileState") == "enabled":
            sys.exit(0)

except Exception:
    pass

sys.exit(1)
'
}

##############################################################################

DEVICE="$(wait_for_device)"

case "$DEVICE" in
    XQ-CT54|XQ-CQ54)
        log "special boot handling required for $DEVICE"
        ;;
    *)
        log "device $DEVICE does not require special handling"
        exit 0
        ;;
esac

MODEMS="$(wait_for_modems)"

if ! ril1_enabled "$MODEMS"; then
    log "ril_1 is not enabled, nothing to do"
    exit 0
fi

log "ril_1 is enabled"

if has_enabled_profile; then
    log "enabled eSIM profile found, nothing to do"
    exit 0
fi

log "no enabled eSIM profiles found"
log "disabling ril_1 and restarting ofono"

dbus-send --system \
    --print-reply \
    --dest=org.ofono \
    / \
    org.nemomobile.ofono.ModemManager.SetEnabledModems \
    $TARGET_MODEMS \
    >/dev/null 2>&1

systemctl restart ofono

exit 0
