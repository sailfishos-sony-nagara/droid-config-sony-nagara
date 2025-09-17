#!/bin/bash

set -e

wait_for_file() {
    local file="$1"
    local timeout="${2:-30}"  # default 30 seconds

    for i in $(seq 1 "$timeout"); do
        if [[ -f "$file" ]]; then
            return 0
        fi
        sleep 1
    done

    echo "ERROR: $file not found after $timeout seconds" >&2
    return 1
}

# Wait for cpu0, 4, and 7 cpufreq file
wait_for_file "/sys/devices/system/cpu/cpu0/cpufreq/walt/up_rate_limit_us"
wait_for_file "/sys/devices/system/cpu/cpu4/cpufreq/walt/up_rate_limit_us"
wait_for_file "/sys/devices/system/cpu/cpu7/cpufreq/walt/up_rate_limit_us"

# Wait for /proc sysfs entry
wait_for_file "/proc/sys/walt/sched_conservative_pl"

# Apply settings
echo 1 > /proc/sys/walt/sched_conservative_pl
# echo 250 | tee /sys/devices/system/cpu/cpu*/cpufreq/walt/up_rate_limit_us

# apply for CPUs 0 1 2 3; other CPUs already are set to min available freq
# echo 307200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
