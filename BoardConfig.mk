# BoardConfig.mk
#
# Product-specific compile-time definitions
#

TARGET_BOOTLOADER_BOARD_NAME := xcover3lte
TARGET_BOARD_PLATFORM := mrvl
TARGET_SOC := pxa1908

# inherit from the proprietary version
-include vendor/samsung/xcover3lte/BoardConfigVendor.mk

# Target configuration (architecture/platform/board)
TARGET_ARCH := arm
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a7
TARGET_CPU_SMP := true
TARGET_NO_BOOTLOADER := true
ARCH_ARM_HAVE_TLS_REGISTER := true

# System image configuration
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_USES_MMCUTILS := true
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_HAS_NO_MISC_PARTITION := true
BOARD_HAS_NO_SELECT_BUTTON := true

BOARD_BOOTIMAGE_PARTITION_SIZE := 0x00380000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x00480000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 0x08c60000
BOARD_USERDATAIMAGE_PARTITION_SIZE := 0x105c0000
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_UMS_LUNFILE := "/sys/class/android_usb/android0/f_mass_storage/lun/file"

# Kernel image configuration
BOARD_KERNEL_CMDLINE := 
BOARD_KERNEL_BASE := 0x10000000
BOARD_KERNEL_PAGESIZE := 2048
TARGET_PREBUILT_KERNEL := device/samsung/xcover3lte/kernel
#TARGET_KERNEL_SOURCE := kernel/samsung/xcover3lte
#TARGET_KERNEL_CONFIG := pxa1088_xcover3lte_eur_defconfig
# Uncomment the above to and comment the prebuilt one when the
# custom_mkbootimg.mk accounts for uImage creation
BOARD_CUSTOM_MKBOOTIMG := device/samsung/xcover3lte/tools/pxa1088-mkbootimg

BOARD_CUSTOM_BOOTIMG_MK := device/samsung/xcover3lte/custom_mkbootimg.mk
BOARD_MKBOOTIMG_ARGS := --dt device/samsung/xcover3lte/dt.img --signature device/samsung/xcover3lte/boot.img-signature --unknown 0x3000000

# TWRP
TARGET_RECOVERY_FSTAB := device/samsung/xcover3lte/recovery.fstab
RECOVERY_VARIANT := twrp
TW_THEME := portrait_mdpi
RECOVERY_SDCARD_ON_DATA := true
RECOVERY_GRAPHICS_USE_LINELENGTH := true
TW_EXCLUDE_SUPERSU := true
#TW_EXCLUDE_MTP := true
TW_MTP_DEVICE := /dev/usb_mtp_gadget
TW_EXCLUDE_DEFAULT_USB_INIT := true
TARGET_RECOVERY_INITRC := device/samsung/xcover3ltexx/ramdisk/recovery/init.rc
RECOVERY_FSTAB_VERSION := 2
TW_NO_REBOOT_BOOTLOADER := true
TW_HAS_DOWNLOAD_MODE := true
TW_INCLUDE_CRYPTO := true
TW_BRIGHTNESS_PATH := "sys/devices/platform/ktd2801-bl.24/backlight/panel/brightness"
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 137
TW_EXTRA_LANGUAGES := true
HAVE_SELINUX := true

# Debug flags
TWRP_INCLUDE_LOGCAT := true

# Audio
BOARD_USES_ALSA_AUDIO := true
COMMON_GLOBAL_CFLAGS += -DMR0_AUDIO_BLOB -DRM1_AUDIO_BLOB

# Assert
TARGET_OTA_ASSERT_DEVICE := xcover,xcover3,xcover3lte

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_MRVL := true

# Camera

# Charging Mode
BOARD_CHARGING_MODE_BOOTING_LPM := true


# Display & Graphics
USE_OPENGL_RENDERER := true
ENABLE_WEBGL := true
COMMON_GLOBAL_FLAGS += -DSK_SUPPORT_LEGACY_SETCONFIG
BOARD_EGL_CFG := device/samsung/xcover3lte/configs/system/lib/egl/egl.cfg
BOARD_HAVE_PIXEL_FORMAT_INFO := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
BOARD_ENABLE_MULTI_DISPLAYS := true
BOARD_USE_VIVANTE_GRALLOC := true
HDMI_SUPPORT_3D := true

# Enable Marvell interface in SurfaceFlinger
MRVL_INTERFACE_ANIMATION := true
# Launch DMS in SurfaceFlinger process
MRVL_LAUNCH_DMS_IN_SURFACEFLINGER := true

# Flags
COMMON_GLOBAL_CFLAGS += -DMRVL_HARDWARE
COMMON_GLOBAL_CFLAGS += -DNEEDS_VECTORIMPL_SYMBOLS
COMMON_GLOBAL_CFLAGS += -DNO_SECURE_DISCARD

# Generic Config
MRVL_ION := true

# Init
TARGET_PROVIDES_INIT := true
TARGET_PROVIDES_INIT_TARGET_RC := true

# Malloc
MALLOC_IMPL := dlmalloc

# Multimedia defines
USE_CAMERA_STUB := true

# MRVL
BOARD_USES_MRVL_HARDWARE := true
BOARD_USES_MARVELL_HWC_ENHANCEMENT := true
COMMON_GLOBAL_CFLAGS += -DMARVELL_HWC_ENHANCEMENT

# NFC

# Radio

# Sensors

# Sec_touchscreen
INPUT_TOUCH_DRIVER := TOUCH_LT

# Webkit
ENABLE_WEBGL := true
BOARD_USE_SKIA_LCDTEXT := true
BOARD_NEEDS_CUTILS_LOG := true
BOARD_USES_HWCOMPOSER := true

# Wifi
BOARD_WLAN_VENDOR := MRVL
MRVL_WIRELESS_DAEMON_API := true
