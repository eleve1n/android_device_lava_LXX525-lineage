#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from device makefile.
$(call inherit-product, device/lava/LXX525/device.mk)

# Inherit some common LineageOS stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_BRAND := Lava
PRODUCT_DEVICE := LXX525
PRODUCT_MANUFACTURER := Lava
PRODUCT_MODEL := Agni 4 5G
PRODUCT_NAME := lineage_LXX525

PRODUCT_CHARACTERISTICS := nosdcard
PRODUCT_GMS_CLIENTID_BASE := android-lava

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="LXX525-user 15 AP3A.240905.015.A2 release-keys" \
    BuildFingerprint=Lava/LXX525/LXX525:15/AP3A.240905.015.A2/release-keys \
    DeviceProduct=LXX525
