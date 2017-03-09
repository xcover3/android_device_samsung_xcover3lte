# Release name
PRODUCT_RELEASE_NAME := xcover3lte

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from our custom product configuration
$(call inherit-product, vendor/omni/config/common.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/xcover3lte/device.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := xcover3lte
PRODUCT_NAME := omni_xcover3lte
PRODUCT_BRAND := Samsung
PRODUCT_MODEL := SM-G388f
PRODUCT_MANUFACTURER := samsung
