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

# Init
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/init/fstab.qcom:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.qcom \
    $(DEVICE_PATH)/configs/init/init.a9y18qlte.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.a9y18qlte.rc \
    $(DEVICE_PATH)/configs/init/init.qcom.factory.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.qcom.factory.rc \
    $(DEVICE_PATH)/configs/init/init.qcom.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.qcom.rc \
    $(DEVICE_PATH)/configs/init/init.qcom.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.qcom.usb.rc \
    $(DEVICE_PATH)/configs/init/init.samsung.bsp.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.samsung.bsp.rc \
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

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += $(DEVICE_PATH)
