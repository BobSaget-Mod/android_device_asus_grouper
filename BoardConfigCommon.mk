# Copyright (C) 2010 The Android Open Source Project
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
# This file sets variables that control the way modules are built
# thorughout the system. It should not be used to conditionally
# disable makefiles (the proper mechanism to control what gets
# included in a build is to use PRODUCT_PACKAGES in a product
# definition file).
#

# inherit from the proprietary version
# needed for BP-flashing updater extensions

# Default value, if not overridden else where.
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR ?= device/asus/grouper/bluetooth

TARGET_BOARD_PLATFORM := tegra3
TARGET_TEGRA_VERSION := t30

TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
ARCH_ARM_HAVE_TLS_REGISTER := true
ARCH_ARM_USE_NON_NEON_MEMCPY := true

TARGET_USERIMAGES_USE_EXT4 := true

BOARD_SYSTEMIMAGE_PARTITION_SIZE := 681574400
BOARD_USERDATAIMAGE_PARTITION_SIZE := 6567231488
BOARD_FLASH_BLOCK_SIZE := 4096

# Wifi related defines
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
WPA_SUPPLICANT_VERSION      := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_bcmdhd
BOARD_WLAN_DEVICE           := bcmdhd
#WIFI_DRIVER_MODULE_PATH     := "/system/lib/modules/bcm4329.ko"
WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/bcmdhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_STA     := "/vendor/firmware/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_AP      := "/vendor/firmware/fw_bcmdhd_apsta.bin"
WIFI_DRIVER_FW_PATH_P2P     := "/vendor/firmware/fw_bcmdhd_p2p.bin"

TARGET_BOOTLOADER_BOARD_NAME := grouper

BOARD_USES_GENERIC_AUDIO := false
BOARD_USES_ALSA_AUDIO := false

BOARD_USES_GENERIC_INVENSENSE := false

BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true

USE_OPENGL_RENDERER := true
BOARD_EGL_CFG := device/asus/grouper/egl.cfg

ifneq ($(HAVE_NVIDIA_PROP_SRC),false)
# needed for source compilation of nvidia libraries
-include vendor/nvidia/proprietary_src/build/definitions.mk
-include vendor/nvidia/build/definitions.mk
endif

# Avoid the generation of ldrcc instructions
NEED_WORKAROUND_CORTEX_A9_745320 := true

BOARD_USES_GROUPER_MODULES := true

# Extra CFLAGS
TARGET_EXTRA_CFLAGS :=	$(call-cc-option,-fsanitize=address) \
			$(call-cc-option,-fsanitize=thread) \
			$(call-cc-option,-march=armv7-a) \
			$(call-cc-option,-mfpu=neon) \
			$(call-cc-option,-mtune=cortex-a9)

# Extra CPPFLAGS
TARGET_EXTRA_CPPFLAGS :=	$(call-cpp-option,-fsanitize=address) \
				$(call-cpp-option,-fsanitize=thread) \
				$(call-cpp-option,-march=armv7-a) \
				$(call-cpp-option,-mfpu=neon) \
				$(call-cpp-option,-mtune=cortex-a9)

ifneq ($(USE_MORE_OPT_FLAGS),yes)
# Extra CFLAGS
TARGET_EXTRA_CFLAGS +=  $(call-cc-option,-fgcse-after-reload) \
			$(call-cc-option,-fipa-cp-clone) \
			$(call-cc-option,-fpredictive-commoning) \
			$(call-cc-option,-fsched-spec-load) \
			$(call-cc-option,-funswitch-loops) \
			$(call-cc-option,-fvect-cost-model)

# Extra CPPFLAGS
TARGET_EXTRA_CPPFLAGS +=	$(call-cpp-option,-fgcse-after-reload) \
				$(call-cpp-option,-fipa-cp-clone) \
				$(call-cpp-option,-fpredictive-commoning) \
				$(call-cpp-option,-fsched-spec-load) \
				$(call-cpp-option,-funswitch-loops) \
				$(call-cpp-option,-fvect-cost-model)
endif

ifeq ($(ENABLE_GRAPHITE),true)
# Graphite
TARGET_EXTRA_CFLAGS +=	$(call-cc-option,-fgraphite) \
			$(call-cc-option,-fgraphite-identity) \
			$(call-cc-option,-floop-block) \
			$(call-cc-option,-floop-flatten) \
			$(call-cc-option,-floop-interchange) \
			$(call-cc-option,-floop-strip-mine) \
			$(call-cc-option,-floop-parallelize-all) \
			$(call-cc-option,-ftree-loop-distribution) \
			$(call-cc-option,-ftree-loop-linear)

TARGET_EXTRA_CPPFLAGS +=	$(call-cpp-option,-fgraphite) \
				$(call-cpp-option,-fgraphite-identity) \
				$(call-cpp-option,-floop-block) \
				$(call-cpp-option,-floop-flatten) \
				$(call-cpp-option,-floop-interchange) \
				$(call-cpp-option,-floop-strip-mine) \
				$(call-cpp-option,-floop-parallelize-all) \
				$(call-cpp-option,-ftree-loop-distribution) \
				$(call-cpp-option,-ftree-loop-linear)
endif

# bionic 32 byte cache line to indicate to C
ARCH_ARM_HAVE_32_BYTE_CACHE_LINES := true

# Preload bootanimation zip into memory
TARGET_BOOTANIMATION_PRELOAD := true

# Bootanimation texture cache
TARGET_BOOTANIMATION_TEXTURE_CACHE := true

# Disable c++11 mode
DEBUG_NO_STDCXX11 := yes
