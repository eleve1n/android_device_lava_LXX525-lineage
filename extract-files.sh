#!/bin/bash
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# extract-files.sh - Extract proprietary blobs from firmware dump
# Usage: ./extract-files.sh /path/to/firmware/dump

set -e

DEVICE=LXX525
VENDOR=lava
OUTDIR=../../../vendor/${VENDOR}/${DEVICE}
MYDIR="${BASH_SOURCE%/*}"

if [ ! -d "$MYDIR" ]; then
    MYDIR="$PWD"
fi

if [ -z "$1" ]; then
    echo "Usage: ./extract-files.sh /path/to/firmware/dump"
    echo ""
    echo "The firmware dump should contain extracted partitions:"
    echo "  system/, vendor/, product/, system_ext/, odm/, vendor_dlkm/"
    exit 1
fi

SRC="$1"

if [ ! -d "$SRC" ]; then
    echo "Error: Source directory $SRC does not exist"
    exit 1
fi

# Create output directory
mkdir -p "$OUTDIR"

# Extract blobs from vendor partition
echo "Extracting vendor blobs..."
for blob in $(cat "$MYDIR/proprietary-files.txt" | grep -v "^#" | grep -v "^$"); do
    src_path="$SRC/vendor/$blob"
    dst_path="$OUTDIR/$blob"

    if [ -f "$src_path" ]; then
        mkdir -p "$(dirname "$dst_path")"
        cp -p "$src_path" "$dst_path"
    else
        echo "WARNING: $blob not found in vendor partition"
    fi
done

# Extract blobs from system_ext partition
echo "Extracting system_ext blobs..."
for blob in $(cat "$MYDIR/proprietary-files-system_ext.txt" 2>/dev/null | grep -v "^#" | grep -v "^$"); do
    src_path="$SRC/system_ext/$blob"
    dst_path="$OUTDIR/system_ext/$blob"

    if [ -f "$src_path" ]; then
        mkdir -p "$(dirname "$dst_path")"
        cp -p "$src_path" "$dst_path"
    fi
done

# Extract blobs from odm partition
echo "Extracting odm blobs..."
for blob in $(cat "$MYDIR/proprietary-files-odm.txt" 2>/dev/null | grep -v "^#" | grep -v "^$"); do
    src_path="$SRC/odm/$blob"
    dst_path="$OUTDIR/odm/$blob"

    if [ -f "$src_path" ]; then
        mkdir -p "$(dirname "$dst_path")"
        cp -p "$src_path" "$dst_path"
    fi
done

echo "Extraction complete. Blobs are in $OUTDIR"

# Generate vendor makefile
cat > "$OUTDIR/LXX525-vendor.mk" << 'VENDORMK'
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0

PRODUCT_PACKAGES += \
    LXX525-vendor
VENDORMK

echo "Generated $OUTDIR/LXX525-vendor.mk"
