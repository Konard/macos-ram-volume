#!/bin/bash

# create_ram_volume.sh
# This script creates a RAM volume on macOS and mounts it as /Volumes/ram_volume_<size>MB

# === Configuration ===

# Size of RAM volume in MB (default to 128 if not provided)
SIZE_MB=${1:-128}

# Name for the RAM volume
RAM_VOLUME_NAME="ram_volume_${SIZE_MB}MB"

# === Calculation ===

# Calculate the number of sectors (512 bytes per sector)
SIZE_SECTORS=$(( SIZE_MB * 2048 )) # 128 * 2048 = 262144

# === Function to Create RAM Volume ===

create_ram_volume() {
    echo "Creating a ${SIZE_MB}MB RAM volume named '${RAM_VOLUME_NAME}'..."

    # Create the RAM volume using hdiutil and capture the disk identifier
    DISK_IDENTIFIER=$(hdiutil attach -nomount ram://$SIZE_SECTORS 2>&1)

    # Check if hdiutil was successful
    if [[ $? -ne 0 ]]; then
        echo "❌ hdiutil failed to attach RAM volume."
        echo "🔍 Details: $DISK_IDENTIFIER"
        exit 1
    fi

    # Extract the disk identifier (e.g., /dev/disk8)
    DISK_IDENTIFIER=$(echo "$DISK_IDENTIFIER" | grep "^/dev/" | awk '{print $1}')

    # Verify that a valid disk identifier was obtained
    if [[ -z "$DISK_IDENTIFIER" ]]; then
        echo "❌ Failed to obtain a valid disk identifier from hdiutil."
        echo "🔍 hdiutil Output: $DISK_IDENTIFIER"
        exit 1
    fi

    echo "🔍 RAM volume assigned to ${DISK_IDENTIFIER}."

    # Erase and format the RAM volume
    diskutil erasevolume HFS+ "$RAM_VOLUME_NAME" "$DISK_IDENTIFIER" > /dev/null 2>&1

    # Check if diskutil was successful
    if [[ $? -eq 0 ]]; then
        echo "✅ RAM volume '${RAM_VOLUME_NAME}' created and mounted successfully."
        echo "📂 Path: /Volumes/${RAM_VOLUME_NAME}"
    else
        echo "❌ diskutil failed to erase and format the RAM volume."
        echo "🔍 Attempting to detach the disk..."
        hdiutil detach "$DISK_IDENTIFIER"
        exit 1
    fi
}

# === Function to Check Existing RAM Volume ===

check_existing_ram_volume() {
    if [ -d "/Volumes/$RAM_VOLUME_NAME" ]; then
        echo "⚠️ RAM volume '${RAM_VOLUME_NAME}' already exists at /Volumes/${RAM_VOLUME_NAME}."
        echo "If you wish to create a new one, please remove the existing RAM volume first."
        exit 0
    fi
}

# === Main Execution ===

# Check if the RAM volume already exists
check_existing_ram_volume

# Create the RAM volume
create_ram_volume

exit 0