$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

$(call inherit-product-if-exists, vendor/samsung/xcover3lte/xcover3lte-vendor.mk)

# Overlay
DEVICE_PACKAGE_OVERLAYS += device/samsung/xcover3lte/overlay

# Android EGL implementation
PRODUCT_PACKAGES += libGLES_android

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

# NFC
PRODUCTS_PACKAGES += \
	Tag \
	com.android.nfc_extras \
	libnfc_nci_jni \
	libnfc_nci 

# NFC Prebuilt files
PRODUCT_COPY_FILES += \
$(LOCAL_PATH)/etc/libnfc-brcm.conf:system/etc/libnfc-brcm.conf \
$(LOCAL_PATH)/etc/libnfc-nxp.conf:system/etc/libnfc-nxp.conf \
$(LOCAL_PATH)/etc/nfcee_access.xml:system/etc/nfcee_access.xml

# Location, WiDi
PRODUCT_PACKAGES += \
	com.android.location.provider \
	com.android.location.provider.xml \
	com.android.media.remotedisplay \
	com.android.media.remotedisplay.xml

# Live Wallpapers
PRODUCT_PACKAGES += \
	librs_jni

# Screen density
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := mdpi

# Sensors
PRODUCT_PACKAGES += \
	sensors.default

# defult.prop
DEFAULT_PROPERTY_OVERRIDES += \
	ro.sf.lcd_density=240 \
	ro.wifi.active_roaming.enable=true \
	ro.config.max_starting_bg=10 \
	persist.service.camera.isptype=1 \
	ro.cmd.ssipc_enable=true \
	ro.security.mode=tz \
	ro.cmd.WORLD_PHONE=true \
	ro.atm.manufacturer.id=Marvell \
	ro.atm.model.id=LINUX \
	ro.atm.id=Marvell \
	dalvik.vm.heapstartsize=8m \
	dalvik.vm.heapgrowthlimit=96m \
	dalvik.vm.heapsize=256m \
	dalvik.vm.heaptargetutilization=0.75 \
	dalvik.vm.heapminfree=2m \
	dalvik.vm.heapmaxfree=8m \
	persist.radio.rem.enable=0 \
	drm.service.enabled=true \
	ro.sec.fle.encryption=true \
	ro.config.dha_cached_max=6 \
	ro.config.dha_empty_init=24 \
	ro.config.dha_empty_max=24 \
	ro.config.dha_lmk_scale=0.7 \
	ro.config.dha_th_rate=1.83 \
	ro.config.ldha_ext_enable=true

# Ril
PRODUCT_PACKAGES += \
	libxml2

# Terminal
PRODUCT_PACKAGES += Terminal

# USB
PRODUCT_PACKAGES += \
	com.android.future.usb.accessory

# Live Wallpaper
PRODUCT_PACKAGES += \
	LiveWallpapers \
	LiveWallpapersPicker \
	VisualizationWallpapers \
	librs_jni

# Need to redo file properly (include everything that is needed, and sort 
# out sections alphabetically) like with BoardConfig.mk

$(call inherit-product, build/target/product/full.mk)

# Get Proprietary Libraries and binaries
$(call inherit-product, vendor/samsung/xcover3lte/xcover3lte-vendor.mk)

