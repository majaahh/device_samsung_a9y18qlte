#
# Copyright (C) The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit proprietary files
$(call inherit-product, vendor/samsung/a9y18qlte/a9y18qlte-vendor.mk)

DEVICE_PATH := device/samsung/a9y18qlte

# Audio
TARGET_EXCLUDES_AUDIOFX := true

# Display
PRODUCT_PACKAGES += \
    android.hardware.graphics.mapper@3.0-impl-qti-display \
    android.hardware.renderscript@1.0-impl \
    libgrallocutils \
    libgralloccore \
    gralloc.qcom \
    vendor.qti.hardware.display.allocator-service

# fastbootd
PRODUCT_PACKAGES += fastbootd

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-impl \
    android.hardware.gatekeeper@1.0-service

# Graphics
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := 450dpi
PRODUCT_AAPT_PREBUILT_DPI := xxxhdpi xxhdpi xhdpi hdpi

# Init
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/init/fstab.qcom:$(TARGET_COPY_OUT_RAMDISK)/etc/fstab.qcom \
    $(DEVICE_PATH)/configs/init/fstab.qcom:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.qcom \
    $(DEVICE_PATH)/configs/init/init.a9y18qlte.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.a9y18qlte.rc \
    $(DEVICE_PATH)/configs/init/init.qcom.factory.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.qcom.factory.rc \
    $(DEVICE_PATH)/configs/init/init.qcom.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.qcom.rc \
    $(DEVICE_PATH)/configs/init/init.qcom.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.qcom.usb.rc \
    $(DEVICE_PATH)/configs/init/init.samsung.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.samsung.rc \
    $(DEVICE_PATH)/configs/init/init.target.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.target.rc \
    $(DEVICE_PATH)/configs/init/init.msm.usb.configfs.rc:$(TARGET_COPY_OUT_VENDOR)/vendor/etc/init.msm.usb.configfs.rc \
    $(DEVICE_PATH)/configs/init/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/etc/ueventd.rc \
    $(DEVICE_PATH)/configs/init/bin/init.class_main.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.class_main.sh \
    $(DEVICE_PATH)/configs/init/bin/init.crda.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.crda.sh \
    $(DEVICE_PATH)/configs/init/bin/init.qcom.class_core.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qcom.class_core.sh \
    $(DEVICE_PATH)/configs/init/bin/init.qcom.crashdata.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qcom.crashdata.sh \
    $(DEVICE_PATH)/configs/init/bin/init.qcom.early_boot.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qcom.early_boot.sh \
    $(DEVICE_PATH)/configs/init/bin/init.qcom.post_boot.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qcom.post_boot.sh \
    $(DEVICE_PATH)/configs/init/bin/init.qcom.sdio.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qcom.sdio.sh \
    $(DEVICE_PATH)/configs/init/bin/init.qcom.sensors.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qcom.sensors.sh \
    $(DEVICE_PATH)/configs/init/bin/init.qcom.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qcom.sh \
    $(DEVICE_PATH)/configs/init/bin/init.qcom.usb.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qcom.usb.sh \
    $(DEVICE_PATH)/configs/init/bin/init.qti.can.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qti.can.sh \
    $(DEVICE_PATH)/configs/init/bin/init.qti.qseecomd.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qti.qseecomd.sh

# Public Libraries
PRODUCT_COPY_FILES += $(DEVICE_PATH)/configs/linker/public.libraries.txt:$(TARGET_COPY_OUT_VENDOR)/etc/public.libraries.txt

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += $(DEVICE_PATH)

# VNDK prebuilts
PRODUCT_COPY_FILES += \
    prebuilts/vndk/v29/arm64/arch-arm64-armv8-a/shared/vndk-core/libprotobuf-cpp-lite.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libprotobuf-cpp-lite-v29.so \
    prebuilts/vndk/v29/arm64/arch-arm-armv8-a/shared/vndk-core/libprotobuf-cpp-lite.so:$(TARGET_COPY_OUT_VENDOR)/lib/libprotobuf-cpp-lite-v29.so \
    prebuilts/vndk/v29/arm64/arch-arm64-armv8-a/shared/vndk-core/libprotobuf-cpp-full.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libprotobuf-cpp-full-v29.so \
    prebuilts/vndk/v29/arm64/arch-arm-armv8-a/shared/vndk-core/libprotobuf-cpp-full.so:$(TARGET_COPY_OUT_VENDOR)/lib/libprotobuf-cpp-full-v29.so
