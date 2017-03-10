$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

$(call inherit-product-if-exists, vendor/samsung/xcover3lte/xcover3lte-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/samsung/xcover3lte/overlay

# Boot Animation
TARGET_SCREEN_HEIGHT := 800
TARGET_SCREEN_WIDTH :=	400

LOCAL_PATH := device/samsung/xcover3lte

ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := $(LOCAL_PATH)/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# Init files
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/ramdisk/boot/fstab.pxa1908:root/fstab.pxa1908 \
	$(LOCAL_PATH)/ramdisk/boot/init.pxa1908.rc:root/init.pxa1908.rc \
	$(LOCAL_PATH)/ramdisk/boot/init.pxa1908.security.rc:root/init.pxa1908.security.rc \
	$(LOCAL_PATH)/ramdisk/boot/init.pxa1908.sensor.rc:root/init.pxa1908.sensor.rc \
	$(LOCAL_PATH)/ramdisk/boot/init.pxa1908.tel.rc:root/init.pxa1908.tel.rc \
	$(LOCAL_PATH)/ramdisk/boot/init.pxa1908.usb.rc:root/init.pxa1908.usb.rc \
	$(LOCAL_PATH)/ramdisk/boot/init_bsp.pxa1908.rc:root/init_bsp.pxa1908.rc \
	$(LOCAL_PATH)/ramdisk/boot/init_bsp.pxa1908.tel.rc:root/init_bsp.pxa1908.tel.rc \
	$(LOCAL_PATH)/ramdisk/boot/ueventd.pxa1908.rc:root:ueventd.pxa1908.rc 

# Key mappings and touchscreen files
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/prebuilts/usr/idc/elan-ts.idc:/system/usr/idc/elan-ts.idc \
	$(LOCAL_PATH)/prebuilts/usr/idc/ft5306-ts.idc:/system/usr/idc/ft5306-ts.idc \
	$(LOCAL_PATH)/prebuilts/usr/idc/msg2133.idc:/system/usr/idc/msg2133.idc \
	$(LOCAL_PATH)/prebuilts/usr/idc/qwerty2.idc:/system/usr/idc/qwerty2.idc \
	$(LOCAL_PATH)/prebuilts/usr/idc/qwerty.idc:/system/usr/idc/qwerty.idc \
	$(LOCAL_PATH)/prebuilts/usr/idc/synaptics_dsx_i2c.idc:/system/usr/idc/synaptics_dsx_i2c.idc \
	$(LOCAL_PATH)/prebuilts/usr/idc/Synaptics_HID_TouchPad.idc:/system/usr/idc/Synaptics_HID_TouchPad.idc

# Hardware capabilities
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/etc/permissions/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
	frameworks/native/data/etc/android.hardware.nfc.hce.xml:system/etc/permissions/android.hardware.nfc.hce.xml \
	frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
	frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
	frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
	frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
	frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml

# Media Profiles
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/etc/media_profiles.xml:system/etc/media_profiles.xml \
	$(LOCAL_PATH)/etc/media_codecs.xml:system/etc/media_codecs.xml

$(call inherit-product-if-exists, external/alsa-lib/alsa-lib-products.mk)
PRODUCT_PACKAGES += \
	libaudio \
	alsa.omap3
# Note to self, look into alsa.omap3

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/etc/audio_policy.conf:system/etc/audio_policy.conf

# Product specfic packages

# Screen density
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := mdpi

PRODUCT_COPY_FILES += $(LOCAL_PATH)/twrp.fstab:recovery/root/etc/twrp.fstab
PRODUCT_COPY_FILES += $(LOCAL_PATH)/poweroff.sh:recovery/root/sbin/poweroff.sh

#PRODUCT_COPY_FILES += \
#    $(LOCAL_KERNEL):kernel

$(call inherit-product, build/target/product/full.mk)

# Get Proprietary Libraries and binaries
$(call inherit-product, vendor/samsung/xcover3lte/xcover3lte-vendor.mk)

