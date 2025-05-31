#!/bin/sh

wait_for_service() {
    BINDER_ADDRESS="$1"
    TIMEOUT=10
    ELAPSED=0

    while [ "$(binder-list -d /dev/hwbinder | grep "$BINDER_ADDRESS")" = "" ]; do
        if [ "$ELAPSED" -ge "$TIMEOUT" ]; then
            echo "Timeout reached: process $PROCESS_NAME did not $MSG"
            return 1
        fi
        echo "Waiting for $BINDER_ADDRESS"
        sleep 1
        ELAPSED=$((ELAPSED + 1))
    done
}

# trigger starting nagara hal class services
setprop droid.nagara.trigger nagara_hal

# wait for services to start and register
wait_for_service "android.hardware.media.c2@1.0::IComponentStore/default"
wait_for_service "android.hardware.media.c2@1.0::IComponentStore/default2"

echo "Services are running"

exit 0
