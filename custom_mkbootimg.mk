LOCAL_PATH := $(call my-dir)

#include device/samsung/xcover3lte/tools/Android.mk
#Currently generating ^ errors, use prebuilt ones.

#-------------------------------------------#
# 	Generate device tree image (dt.img) 	#
#-------------------------------------------#
ifeq ($(strip $(BOARD_CUSTOM_BOOTIMG_MK)),)
ifeq ($(strip $(BOARD_KERNEL_SEPARATED_DT)),true)
ifneq ($(strip $(BOARD_KERNEL_PREBUILT_DT)),true)

ifeq ($(strip $(TARGET_CUSTOM_DTBTOOL)),)
DTBTOOL_NAME := dtbToolCM
else
DTBTOOL_NAME := $(TARGET_CUSTOM_DTBTOOL)
endif

DTBTOOL := $(HOST_OUT_EXECUTABLES)/$(DTBTOOL_NAME)$(HOST_EXECUTABLE_SUFFIX)

INSTALLED_DTIMAGE_TARGET := $(PRODUCT_OUT)/dt.img

ifeq ($(strip $(TARGET_CUSTOM_DTBTOOL)),)
# dtbToolCM will search subdirectories
possible_dtb_dirs = $(KERNEL_OUT)/arch/$(KERNEL_ARCH)/boot/
else
# Most specific paths must come first in possible_dtb_dirs
possible_dtb_dirs = $(KERNEL_OUT)/arch/$(KERNEL_ARCH)/boot/dts/ $(KERNEL_OUT)/arch/$(KERNEL_ARCH)/boot/
endif

define build-dtimage-target
	$(call pretty,"Target dt image: $@")
	$(hide) for dir in $(possible_dtb_dirs); do \
		if [ -d "$$dir" ]; then \
			dtb_dir="$$dir"; \
			break; \
		fi; \
	done; \
	$(DTBTOOL) $(BOARD_DTBTOOL_ARGS) -o $@ -s $(BOARD_KERNEL_PAGESIZE) -p $(KERNEL_OUT)/scripts/dtc/ "$$dtb_dir";
	$(hide) chmod a+r $@
endef

$(INSTALLED_DTIMAGE_TARGET): $(DTBTOOL) $(INSTALLED_KERNEL_TARGET) -o $@
	$(build-dtimage-target)
	@echo "Made DT image: $@"

.PHONY: dtimage
dtimage: $(INSTALLED_DTIMAGE_TARGET)
else
$(INSTALLED_DTIMAGE_TARGET):$(TARGET_PREBUILT_DT)

.PHONY: dtimage
dtimage: $(INSTALLED_DTIMAGE_TARGET)
endif
endif
endif

#-------------------------------------------#
# Generate uBoot from the kernel (Image.gz) #
#-------------------------------------------#
IMAGE_GZ := $(KERNEL_OUT)/arch/$(KERNEL_ARCH)/boot/Image.gz

$(INSTALLED_UBOOT_TARGET): $(MKIMAGE)
	$(MKIMAGE) $(BOARD_UBOOT_ARGS) -d $(IMAGE_GZ) $@
	@echo ----- Made uBoot -------- $@

#-------------------------------------------#
#		 	Generate Boot.img			 	#
#-------------------------------------------#

$(INSTALLED_BOOTIMG_TARGET): $(MKBOOTIMG) $(MKBOOTFS) $(MINIGZIP) \
		$(boot_uncompressed_ramdisk) \
		$(boot_kernel)
	$(call pretty,"Target boot image: $@")
	$(MKBOOTFS) $(TARGET_BOOT_ROOT_OUT) > $(boot_uncompressed_ramdisk)
	$(MINIGZIP) < $(boot_uncompressed_ramdisk) > $(boot_ramdisk)
	@echo -e ${CL_CYN}"----- Making boot image ------"${CL_RST}
	@echo -e "$(BOARD_CUSTOM_MKBOOTIMG) $(INTERNAL_BOOTIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) -d $(INSTALLED_DTIMAGE_TARGET) --output $@"
	$(hide) $(BOARD_CUSTOM_MKBOOTIMG) $(INTERNAL_RECOVERYIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) -d $(INSTALLED_DTIMAGE_TARGET) --output $@

	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE),raw)
	@echo -e ${CL_CYN}"Made boot image: $@"${CL_RST}

#-------------------------------------------#
#		 	Generate recovery.img		 	#
#-------------------------------------------#

$(INSTALLED_RECOVERYIMAGE_TARGET): $(MKBOOTIMG) $(MKBOOTFS) $(MINIGZIP) \
		$(recovery_uncompressed_ramdisk) \
		$(recovery_kernel)
	mv $(TARGET_RECOVERY_ROOT_OUT)/sbin/adbd $(TARGET_RECOVERY_ROOT_OUT)/sbin/adbe
	$(MKBOOTFS) $(TARGET_RECOVERY_ROOT_OUT) > $(recovery_uncompressed_ramdisk)
	$(MINIGZIP) < $(recovery_uncompressed_ramdisk) > $(recovery_ramdisk)
	@echo -e ${CL_CYN}"----- Making recovery image ------"${CL_RST}
	@echo -e "$(BOARD_CUSTOM_MKBOOTIMG) $(INTERNAL_RECOVERYIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) -d $(INSTALLED_DTIMAGE_TARGET) --output $@"
	$(hide) $(BOARD_CUSTOM_MKBOOTIMG) $(INTERNAL_RECOVERYIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) -d $(INSTALLED_DTIMAGE_TARGET) --output $@

	$(hide) $(call assert-max-image-size,$@,$(BOARD_RECOVERYIMAGE_PARTITION_SIZE),raw)
	@echo -e ${CL_CYN}"Made recovery image: $@"${CL_RST}

