# Release name
PRODUCT_RELEASE_NAME := xcover3lte

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/xcover3lte/device_xcover3lte.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := xcover3lte
PRODUCT_NAME := cm_xcover3lte
PRODUCT_BRAND := samsung
PRODUCT_MODEL := xcover3lte
PRODUCT_MANUFACTURER := samsung
