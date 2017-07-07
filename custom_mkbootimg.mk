LOCAL_PATH := $(call my-dir)

include hardware/marvell/pxa1088-mkbootimg/Android.mk

#-------------------------------------------#
# Generate uBoot from the kernel (Image.gz) #
#-------------------------------------------#
IMAGE_GZ := $(KERNEL_OUT)/arch/$(KERNEL_ARCH)/boot/Image.gz

$(INSTALLED_UBOOT_TARGET): $(MKIMAGE)
	$(MKIMAGE) $(BOARD_UBOOT_ARGS) -d $(IMAGE_GZ) $@
	@echo ----- Made uBoot -------- $@

#-------------------------------------------#
#	      Generate Boot.img	  	    #
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

