#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#
# LXX525 blob extraction — generates the module-based vendor tree
# Usage: ./extract-files.py /path/to/firmware-dump
#
# The dump must contain extracted partitions:
#   system/ vendor/ product/ system_ext/ odm/ vendor_dlkm/

from extract_utils.fixups_blob import (
    blob_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'hardware/mediatek',
    'vendor/lava/LXX525',
]

blob_fixups: blob_fixups_user_type = {
}  # fmt: skip

module = ExtractUtilsModule(
    'LXX525',
    'lava',
    blob_fixups=blob_fixups,
    namespace_imports=namespace_imports,
)

if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
