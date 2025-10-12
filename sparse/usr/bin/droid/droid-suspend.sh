#!/bin/sh
#
# Controls Android suspend service via binder interface
#

BINDER_DEVICE="/dev/binder"
SERVICE_NAME="suspend_control_internal"

print_usage() {
    cat << EOF
Usage: $(basename "$0") [OPTION]

Control Android system suspend functionality via binder interface.

Options:
  --enable        Enable automatic system suspension
  --disable       Disable automatic system suspension
  --verbose       Enable verbose logging for suspend operations
  --no-verbose    Disable verbose logging for suspend operations
  -h, --help      Show this help message

Examples:
  $(basename "$0") --enable
  $(basename "$0") --disable
  $(basename "$0") --verbose

EOF
}

call_binder() {
    local method_code="$1"
    local method_name="$2"
    
    echo "Calling ${method_name}..."
    
    binder-call -a -d "$BINDER_DEVICE" "$SERVICE_NAME" "$method_code"

    return 0
}

# Check if no arguments provided
if [ $# -eq 0 ]; then
    echo "Error: No option specified" >&2
    echo ""
    print_usage
    exit 1
fi

# Parse command line arguments
case "$1" in
    --enable)
        call_binder 1 "enableAutosuspend"
        exit $?
        ;;
    --disable)
        call_binder 2 "disableAutosuspend"
        exit $?
        ;;
    --verbose)
        call_binder 3 "enableVerbose"
        exit $?
        ;;
    --no-verbose)
        call_binder 4 "disableVerbose"
        exit $?
        ;;
    -h|--help)
        print_usage
        exit 0
        ;;
    *)
        echo "Error: Unknown option '$1'" >&2
        echo ""
        print_usage
        exit 1
        ;;
esac
