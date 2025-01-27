#!/bin/bash

# remove_ram_volume.sh
# This script unmounts and removes the RAM volume named ram_volume_<size>MB

# === Configuration ===

# Size of RAM volume in MB (default to 128 if not provided)
SIZE_MB=${1:-128}

# Name of the RAM volume
RAM_VOLUME_NAME="ram_volume_${SIZE_MB}MB"

# === Function to Remove RAM Volume ===

remove_ram_volume() {
    echo "Removing RAM volume '${RAM_VOLUME_NAME}'..."

    # Eject the RAM volume
    EJECT_OUTPUT=$(diskutil eject "/Volumes/${RAM_VOLUME_NAME}" 2>&1)

    # Check if diskutil was successful
    if [[ $? -eq 0 ]]; then
        echo "✅ RAM volume '${RAM_VOLUME_NAME}' unmounted successfully."
    else
        echo "❌ Failed to unmount RAM volume '${RAM_VOLUME_NAME}'."
        echo "🔍 Details: $EJECT_OUTPUT"
        exit 1
    fi
}

# === Main Execution ===

remove_ram_volume

exit 0