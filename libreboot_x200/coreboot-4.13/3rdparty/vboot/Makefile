# Copyright 2013 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

# This Makefile normally builds in a 'build' subdir, but use
#
#    make BUILD=<dir>
#
# to put the output somewhere else.

##############################################################################
# Make variables come in two flavors, immediate or deferred.
#
#   Variable definitions are parsed like this:
#
#        IMMEDIATE = DEFERRED
#    or
#        IMMEDIATE := IMMEDIATE
#
#   Rules are parsed this way:
#
#        IMMEDIATE : IMMEDIATE
#           DEFERRED
#
# So you can assign variables in any order if they're only to be used in
# actions, but if you use a variable in either the target or prerequisite of a
# rule, the rule will be constructed using only the top-down, immediate value.
#
# So we'll try to define all the variables first. Then the rules.
#

##############################################################################
# Configuration variables come first.
#
# Our convention is that we only use := for variables that will never be
# changed or appended. They must be defined before being used anywhere.

# We should only run pwd once, not every time we refer to ${BUILD}.
SRCDIR := $(shell pwd)
export SRCDIR
BUILD = ${SRCDIR}/build
export BUILD

# Stuff for 'make install'
INSTALL = install
DESTDIR = /
LIBDIR ?= lib

# Default values
DEV_DEBUG_FORCE=

# Where exactly do the pieces go?
#  UB_DIR = utility binary directory
#  ULP_DIR = pkgconfig directory, usually /usr/lib/pkgconfig
#  UI_DIR = include directory for library headers
#  US_DIR = shared data directory (for static content like devkeys)
#  DF_DIR = utility defaults directory
#  VB_DIR = vboot binary directory for dev-mode-only scripts
UB_DIR=${DESTDIR}/usr/bin
UL_DIR=${DESTDIR}/usr/${LIBDIR}
ULP_DIR=${UL_DIR}/pkgconfig
UI_DIR=${DESTDIR}/usr/include/vboot
US_DIR=${DESTDIR}/usr/share/vboot
DF_DIR=${DESTDIR}/etc/default
VB_DIR=${US_DIR}/bin

# Where to install the (exportable) executables for testing?
TEST_INSTALL_DIR = ${BUILD}/install_for_test

# Set when installing into the SDK instead of building for a board sysroot.
SDK_BUILD ?=

# Verbose? Use V=1
ifeq (${V},)
Q := @
endif

# Quiet? Use QUIET=1
ifeq (${QUIET},)
PRINTF := printf
else
PRINTF := :
endif

# Architecture detection
_machname := $(shell uname -m)
HOST_ARCH ?= ${_machname}

# ARCH and/or FIRMWARE_ARCH are defined by the Chromium OS ebuild.
# Pick a valid target architecture if none is defined.
ifeq (${ARCH},)
  ARCH := ${HOST_ARCH}
endif

ifeq (${ARCH},armv7l)
  override ARCH := arm
else ifneq (,$(filter aarch64 arm64,${ARCH}))
  override ARCH := arm
else ifeq (${ARCH},i386)
  override ARCH := x86
else ifeq (${ARCH},i686)
  override ARCH := x86
else ifeq (${ARCH},amd64)
  override ARCH := x86_64
endif

ifneq ($(wildcard host/arch/${ARCH}/lib/crossystem_arch.c),)
	CROSSYSTEM_ARCH_C := host/arch/${ARCH}/lib/crossystem_arch.c
else
	CROSSYSTEM_ARCH_C := host/arch/stub/lib/crossystem_arch.c
endif

# FIRMWARE_ARCH is only defined by the Chromium OS ebuild if compiling
# for a firmware target (coreboot or depthcharge). It must map to the same
# consistent set of architectures as the host.
ifeq (${FIRMWARE_ARCH},i386)
  override FIRMWARE_ARCH := x86
else ifeq (${FIRMWARE_ARCH},amd64)
  override FIRMWARE_ARCH := x86_64
else ifeq (${FIRMWARE_ARCH},armv7)
  override FIRMWARE_ARCH := arm
endif

# Provide default CC and CFLAGS for firmware builds; if you have any -D flags,
# please add them after this point (e.g., -DVBOOT_DEBUG).
DEBUG_FLAGS := $(if ${DEBUG},-g -O0,-g -Os)
WERROR := -Werror
FIRMWARE_FLAGS := -nostdinc -ffreestanding -fno-builtin -fno-stack-protector
COMMON_FLAGS := -pipe ${WERROR} -Wall -Wstrict-prototypes -Wtype-limits \
	-Wundef -Wmissing-prototypes -Wno-trigraphs -Wredundant-decls -Wshadow \
	-Wwrite-strings -Wstrict-aliasing -Wdate-time -Wno-unknown-warning \
	-Wno-address-of-packed-member -ffunction-sections -fdata-sections \
	-Wimplicit-fallthrough -Wformat -Wno-format-security ${DEBUG_FLAGS}

# FIRMWARE_ARCH is defined if compiling for a firmware target
# (coreboot or depthcharge).
ifeq (${FIRMWARE_ARCH},arm)
CC ?= armv7a-cros-linux-gnueabihf-gcc
CFLAGS ?= -march=armv5 -fno-common -ffixed-r8 -mfloat-abi=hard -marm
	-mabi=aapcs-linux -mno-thumb-interwork ${FIRMWARE_FLAGS} ${COMMON_FLAGS}
else ifeq (${FIRMWARE_ARCH},x86)
CC ?= i686-pc-linux-gnu-gcc
# Drop -march=i386 to permit use of SSE instructions
CFLAGS ?= -fvisibility=hidden -fomit-frame-pointer \
	-fno-toplevel-reorder -fno-dwarf2-cfi-asm -mpreferred-stack-boundary=2 \
	${FIRMWARE_FLAGS} ${COMMON_FLAGS}
else ifeq (${FIRMWARE_ARCH},x86_64)
CFLAGS ?= ${FIRMWARE_FLAGS} ${COMMON_FLAGS} -fvisibility=hidden \
	-fomit-frame-pointer
else
# FIRMWARE_ARCH not defined; assuming local compile.
CC ?= gcc
CFLAGS += -DCHROMEOS_ENVIRONMENT ${COMMON_FLAGS}
endif

# Needs -Wl because LD is actually set to CC by default.
LDFLAGS += -Wl,--gc-sections

ifneq (${DEBUG},)
CFLAGS += -DVBOOT_DEBUG
endif

ifeq (${DISABLE_NDEBUG},)
CFLAGS += -DNDEBUG
endif

ifneq (${FORCE_LOGGING_ON},)
CFLAGS += -DFORCE_LOGGING_ON=${FORCE_LOGGING_ON}
endif

ifneq (${TPM2_MODE},)
CFLAGS += -DTPM2_MODE
endif

# Enable boot from external disk when switching to dev mode
ifneq ($(filter-out 0,${BOOT_EXTERNAL_ON_DEV}),)
CFLAGS += -DBOOT_EXTERNAL_ON_DEV=1
else
CFLAGS += -DBOOT_EXTERNAL_ON_DEV=0
endif

# Enable EC early firmware selection.
ifneq ($(filter-out 0,${EC_EFS}),)
CFLAGS += -DEC_EFS=1
else
CFLAGS += -DEC_EFS=0
endif

# Some tests need to be disabled when using mocked_secdata_tpm.
ifneq (${MOCK_TPM},)
CFLAGS += -DMOCK_TPM
endif

# DETACHABLE indicates whether the device is a detachable or not.
ifneq ($(filter-out 0,${DETACHABLE}),)
CFLAGS += -DDETACHABLE=1
else
CFLAGS += -DDETACHABLE=0
endif

# Enable the menu-based user interface.
ifneq ($(filter-out 0,${MENU_UI}),)
CFLAGS += -DMENU_UI=1
else
CFLAGS += -DMENU_UI=0
endif

# LEGACY_MENU_UI controls whether to enable legacy menu UI, which is used with
# devices that don't have a keyboard (detachables).
# Pass LEGACY_MENU_UI= (or =0) to make to disable feature.
ifneq ($(filter-out 0,${LEGACY_MENU_UI}),)
CFLAGS += -DLEGACY_MENU_UI=1
else
CFLAGS += -DLEGACY_MENU_UI=0
endif

# pass DIAGNOSTIC_UI= (or =0) to make to disable feature
ifneq ($(filter-out 0,${DIAGNOSTIC_UI}),)
CFLAGS += -DDIAGNOSTIC_UI=1
else
CFLAGS += -DDIAGNOSTIC_UI=0
endif

# Confirm physical presence using keyboard
ifneq ($(filter-out 0,${PHYSICAL_PRESENCE_KEYBOARD}),)
CFLAGS += -DPHYSICAL_PRESENCE_KEYBOARD=1
else
CFLAGS += -DPHYSICAL_PRESENCE_KEYBOARD=0
endif

# NOTE: We don't use these files but they are useful for other packages to
# query about required compiling/linking flags.
PC_IN_FILES = vboot_host.pc.in

# Create / use dependency files
CFLAGS += -MMD -MF $@.d

ifeq (${FIRMWARE_ARCH},)
# Creates position independent code for non firmware target.
CFLAGS += -fPIE
endif

# These are required to access large disks and files on 32-bit systems.
CFLAGS += -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64

# Code coverage
ifneq (${COV},)
  COV_FLAGS = -O0 --coverage -DCOVERAGE
  CFLAGS += ${COV_FLAGS}
  LDFLAGS += ${COV_FLAGS}
  COV_INFO = ${BUILD}/coverage.info
endif

ifdef HAVE_MACOS
  CFLAGS += -DHAVE_MACOS -Wno-deprecated-declarations
endif

# Musl doesn't have execinfo.h.
ifndef HAVE_MUSL
  CFLAGS += -DHAVE_EXECINFO_H
endif

# And a few more default utilities
LD = ${CC}
CXX ?= g++
PKG_CONFIG ?= pkg-config

# Static?
ifneq (${STATIC},)
LDFLAGS += -static
PKG_CONFIG += --static
endif

ifneq (${FUZZ_FLAGS},)
CFLAGS += ${FUZZ_FLAGS}
endif

# Optional Libraries
LIBZIP_VERSION := $(shell ${PKG_CONFIG} --modversion libzip 2>/dev/null)
HAVE_LIBZIP := $(if ${LIBZIP_VERSION},1)
ifneq (${HAVE_LIBZIP},)
  CFLAGS += -DHAVE_LIBZIP $(shell ${PKG_CONFIG} --cflags libzip)
  LIBZIP_LIBS := $(shell ${PKG_CONFIG} --libs libzip)
endif

# Determine QEMU architecture needed, if any
ifeq (${ARCH},${HOST_ARCH})
  # Same architecture; no need for QEMU
  QEMU_ARCH :=
else ifeq (${HOST_ARCH}-${ARCH},x86_64-x86)
  # 64-bit host can run 32-bit targets directly
  QEMU_ARCH :=
else
  QEMU_ARCH := ${ARCH}
endif

# The top of the chroot for qemu must be passed in via the SYSROOT environment
# variable.  In the Chromium OS chroot, this is done automatically by the
# ebuild.

ifeq (${QEMU_ARCH},)
  # Path to build output for running tests is same as for building
  BUILD_RUN = ${BUILD}
  SRC_RUN = ${SRCDIR}
else
  $(info Using qemu for testing.)
  # Path to build output for running tests is different in the chroot
  BUILD_RUN = $(subst ${SYSROOT},,${BUILD})
  SRC_RUN = $(subst ${SYSROOT},,${SRCDIR})

  QEMU_BIN = qemu-${QEMU_ARCH}
  QEMU_RUN = ${BUILD_RUN}/${QEMU_BIN}
  export QEMU_RUN

  RUNTEST = tests/test_using_qemu.sh
endif

export BUILD_RUN

##############################################################################
# The default target is here, to allow dependencies to be expressed below
# without accidentally changing the default target.

# Default target.
.PHONY: all
all: fwlib futil utillib hostlib cgpt tlcl \
	$(if ${SDK_BUILD},utils_sdk,utils_board) \
	$(if $(filter x86_64,${ARCH}),$(if $(filter clang,${CC}),fuzzers)) \
	$(if ${COV},coverage)

##############################################################################
# Now we need to describe everything we might want or need to build

# Everything wants these headers.
INCLUDES += \
	-Ifirmware/include \
	-Ifirmware/lib/include \
	-Ifirmware/lib/cgptlib/include \
	-Ifirmware/lib/cryptolib/include \
	-Ifirmware/lib/tpm_lite/include \
	-Ifirmware/2lib/include \
	-Ifirmware/lib20/include

# If we're not building for a specific target, just stub out things like the
# TPM commands and various external functions that are provided by the BIOS.
ifeq (${FIRMWARE_ARCH},)
INCLUDES += -Ihost/include -Ihost/lib/include
INCLUDES += -Ihost/lib21/include
endif

# Firmware library, used by the other firmware components (depthcharge,
# coreboot, etc.). It doesn't need exporting to some other place; they'll build
# this source tree locally and link to it directly.
FWLIB = ${BUILD}/vboot_fw.a

# Separate TPM lightweight command library (TLCL)
TLCL = ${BUILD}/tlcl.a

FWLIB_SRCS = \
	firmware/2lib/2api.c \
	firmware/2lib/2auxfw_sync.c \
	firmware/2lib/2common.c \
	firmware/2lib/2context.c \
	firmware/2lib/2crc8.c \
	firmware/2lib/2crypto.c \
	firmware/2lib/2ec_sync.c \
	firmware/2lib/2gbb.c \
	firmware/2lib/2hmac.c \
	firmware/2lib/2kernel.c \
	firmware/2lib/2misc.c \
	firmware/2lib/2nvstorage.c \
	firmware/2lib/2recovery_reasons.c \
	firmware/2lib/2rsa.c \
	firmware/2lib/2secdata_firmware.c \
	firmware/2lib/2secdata_fwmp.c \
	firmware/2lib/2secdata_kernel.c \
	firmware/2lib/2sha1.c \
	firmware/2lib/2sha256.c \
	firmware/2lib/2sha512.c \
	firmware/2lib/2sha_utility.c \
	firmware/2lib/2stub_hwcrypto.c \
	firmware/2lib/2tpm_bootmode.c \
	firmware/2lib/2ui.c \
	firmware/2lib/2ui_screens.c \
	firmware/lib/cgptlib/cgptlib.c \
	firmware/lib/cgptlib/cgptlib_internal.c \
	firmware/lib/cgptlib/crc32.c \
	firmware/lib/gpt_misc.c \
	firmware/lib/vboot_api_kernel.c \
	firmware/lib/vboot_audio.c \
	firmware/lib/vboot_kernel.c \
	firmware/lib/vboot_ui_legacy.c \
	firmware/lib/vboot_ui_legacy_clamshell.c \
	firmware/lib/vboot_ui_legacy_menu.c \
	firmware/lib/vboot_ui_legacy_wilco.c \
	firmware/lib20/api_kernel.c \
	firmware/lib20/kernel.c \
	firmware/lib20/misc.c \
	firmware/lib20/packed_key.c

# TPM lightweight command library
ifeq (${TPM2_MODE},)
TLCL_SRCS = \
	firmware/lib/tpm_lite/tlcl.c
else
# TODO(apronin): tests for TPM2 case?
TLCL_SRCS = \
	firmware/lib/tpm2_lite/tlcl.c \
	firmware/lib/tpm2_lite/marshaling.c
endif

# Support real TPM unless MOCK_TPM is set
ifneq (${MOCK_TPM},)
FWLIB_SRCS += \
	firmware/lib/tpm_lite/mocked_tlcl.c
endif

ifneq (${VENDOR_DATA_LENGTH},)
CFLAGS += -DVENDOR_DATA_LENGTH=${VENDOR_DATA_LENGTH}
else ifeq (${FIRMWARE_ARCH},)
CFLAGS += -DVENDOR_DATA_LENGTH=4
else
CFLAGS += -DVENDOR_DATA_LENGTH=0
endif

ifeq (${FIRMWARE_ARCH},)
# Include BIOS stubs in the firmware library when compiling for host
# TODO: split out other stub funcs too
FWLIB_SRCS += \
	firmware/stub/tpm_lite_stub.c \
	firmware/stub/vboot_api_stub.c \
	firmware/stub/vboot_api_stub_disk.c \
	firmware/stub/vboot_api_stub_init.c \
	firmware/stub/vboot_api_stub_stream.c \
	firmware/2lib/2stub.c
endif

FWLIB_OBJS = ${FWLIB_SRCS:%.c=${BUILD}/%.o}
TLCL_OBJS = ${TLCL_SRCS:%.c=${BUILD}/%.o}
ALL_OBJS += ${FWLIB_OBJS} ${TLCL_OBJS}

# Intermediate library for the vboot_reference utilities to link against.
UTILLIB = ${BUILD}/libvboot_util.a

UTILLIB_SRCS = \
	cgpt/cgpt_add.c \
	cgpt/cgpt_boot.c \
	cgpt/cgpt_common.c \
	cgpt/cgpt_create.c \
	cgpt/cgpt_edit.c \
	cgpt/cgpt_prioritize.c \
	cgpt/cgpt_repair.c \
	cgpt/cgpt_show.c \
	futility/dump_kernel_config_lib.c \
	$(CROSSYSTEM_ARCH_C) \
	host/lib/chromeos_config.c \
	host/lib/crossystem.c \
	host/lib/crypto.c \
	host/lib/file_keys.c \
	host/lib/flashrom.c \
	host/lib/fmap.c \
	host/lib/host_common.c \
	host/lib/host_key2.c \
	host/lib/host_keyblock.c \
	host/lib/host_misc.c \
	host/lib/host_signature.c \
	host/lib/host_signature2.c \
	host/lib/signature_digest.c \
	host/lib/subprocess.c \
	host/lib/util_misc.c \
	host/lib21/host_common.c \
	host/lib21/host_key.c \
	host/lib21/host_misc.c \
	host/lib21/host_signature.c

UTILLIB_OBJS = ${UTILLIB_SRCS:%.c=${BUILD}/%.o}
ALL_OBJS += ${UTILLIB_OBJS}

# Externally exported library for some target userspace apps to link with
# (cryptohome, updater, etc.)
HOSTLIB = ${BUILD}/libvboot_host.a

HOSTLIB_SRCS = \
	cgpt/cgpt_add.c \
	cgpt/cgpt_boot.c \
	cgpt/cgpt_common.c \
	cgpt/cgpt_create.c \
	cgpt/cgpt_edit.c \
	cgpt/cgpt_find.c \
	cgpt/cgpt_nor.c \
	cgpt/cgpt_prioritize.c \
	cgpt/cgpt_show.c \
	firmware/2lib/2common.c \
	firmware/2lib/2context.c \
	firmware/2lib/2crc8.c \
	firmware/2lib/2crypto.c \
	firmware/2lib/2hmac.c \
	firmware/2lib/2kernel.c \
	firmware/2lib/2nvstorage.c \
	firmware/2lib/2recovery_reasons.c \
	firmware/2lib/2rsa.c \
	firmware/2lib/2sha1.c \
	firmware/2lib/2sha256.c \
	firmware/2lib/2sha512.c \
	firmware/2lib/2sha_utility.c \
	firmware/2lib/2stub.c \
	firmware/2lib/2stub_hwcrypto.c \
	firmware/lib/cgptlib/cgptlib_internal.c \
	firmware/lib/cgptlib/crc32.c \
	firmware/lib/gpt_misc.c \
	firmware/stub/tpm_lite_stub.c \
	firmware/stub/vboot_api_stub.c \
	firmware/stub/vboot_api_stub_disk.c \
	firmware/stub/vboot_api_stub_init.c \
	futility/dump_kernel_config_lib.c \
	$(CROSSYSTEM_ARCH_C) \
	host/lib/chromeos_config.c \
	host/lib/crossystem.c \
	host/lib/crypto.c \
	host/lib/extract_vmlinuz.c \
	host/lib/flashrom.c \
	host/lib/fmap.c \
	host/lib/host_misc.c \
	host/lib/subprocess.c \
	host/lib21/host_misc.c \
	${TLCL_SRCS}

HOSTLIB_OBJS = ${HOSTLIB_SRCS:%.c=${BUILD}/%.o}
ALL_OBJS += ${HOSTLIB_OBJS}

# ----------------------------------------------------------------------------
# Now for the userspace binaries

CGPT = ${BUILD}/cgpt/cgpt

CGPT_SRCS = \
	cgpt/cgpt.c \
	cgpt/cgpt_add.c \
	cgpt/cgpt_boot.c \
	cgpt/cgpt_common.c \
	cgpt/cgpt_create.c \
	cgpt/cgpt_edit.c \
	cgpt/cgpt_find.c \
	cgpt/cgpt_legacy.c \
	cgpt/cgpt_nor.c \
	cgpt/cgpt_prioritize.c \
	cgpt/cgpt_repair.c \
	cgpt/cgpt_show.c \
	cgpt/cmd_add.c \
	cgpt/cmd_boot.c \
	cgpt/cmd_create.c \
	cgpt/cmd_edit.c \
	cgpt/cmd_find.c \
	cgpt/cmd_legacy.c \
	cgpt/cmd_prioritize.c \
	cgpt/cmd_repair.c \
	cgpt/cmd_show.c

CGPT_OBJS = ${CGPT_SRCS:%.c=${BUILD}/%.o}

ALL_OBJS += ${CGPT_OBJS}

CGPT_WRAPPER = ${BUILD}/cgpt/cgpt_wrapper

CGPT_WRAPPER_SRCS = \
	cgpt/cgpt_nor.c \
	cgpt/cgpt_wrapper.c

CGPT_WRAPPER_OBJS = ${CGPT_WRAPPER_SRCS:%.c=${BUILD}/%.o}

ALL_OBJS += ${CGPT_WRAPPER_OBJS}

# Utility defaults
UTIL_DEFAULTS = ${BUILD}/default/vboot_reference

# Scripts to install directly (not compiled)
UTIL_SCRIPTS_SDK = \
	utility/dev_make_keypair \
	utility/vbutil_what_keys
UTIL_SCRIPTS_BOARD = \
	utility/chromeos-tpm-recovery \
	utility/dev_debug_vboot \
	utility/enable_dev_usb_boot \
	utility/tpm-nvsize

UTIL_NAMES_SDK = \
	utility/load_kernel_test \
	utility/pad_digest_utility \
	utility/signature_digest_utility \
	utility/verify_data
UTIL_NAMES_BOARD = \
	utility/crossystem \
	utility/dumpRSAPublicKey \
	utility/tpmc

UTIL_BINS_SDK = $(addprefix ${BUILD}/,${UTIL_NAMES_SDK})
UTIL_BINS_BOARD = $(addprefix ${BUILD}/,${UTIL_NAMES_BOARD})
ALL_OBJS += $(addsuffix .o,${UTIL_BINS_SDK})
ALL_OBJS += $(addsuffix .o,${UTIL_BINS_BOARD})


# Signing scripts that are also useful on DUTs.
SIGNING_SCRIPTS_BOARD = \
	scripts/image_signing/resign_firmwarefd.sh \
	scripts/image_signing/make_dev_firmware.sh \
	scripts/image_signing/make_dev_ssd.sh \
	scripts/image_signing/gbb_flags_common.sh \
	scripts/image_signing/set_gbb_flags.sh \
	scripts/image_signing/get_gbb_flags.sh \
	scripts/image_signing/common_minimal.sh

# SDK installations just want everything.
SIGNING_SCRIPTS_SDK = $(wildcard scripts/image_signing/*.sh)

# Unified firmware utility.
FUTIL_BIN = ${BUILD}/futility/futility

# These are the executables that are now built in to futility. We'll create
# symlinks for these so the old names will still work.
FUTIL_SYMLINKS = \
	dump_fmap \
	dump_kernel_config \
	gbb_utility \
	vbutil_firmware \
	vbutil_kernel \
	vbutil_key \
	vbutil_keyblock

FUTIL_SRCS = \
	futility/futility.c \
	futility/cmd_create.c \
	futility/cmd_dump_fmap.c \
	futility/cmd_dump_kernel_config.c \
	futility/cmd_gbb_utility.c \
	futility/cmd_load_fmap.c \
	futility/cmd_pcr.c \
	futility/cmd_show.c \
	futility/cmd_sign.c \
	futility/cmd_update.c \
	futility/cmd_validate_rec_mrc.c \
	futility/cmd_vbutil_firmware.c \
	futility/cmd_vbutil_firmware.c \
	futility/cmd_vbutil_kernel.c \
	futility/cmd_vbutil_keyblock.c \
	futility/cmd_vbutil_key.c \
	futility/cmd_vbutil_key.c \
	futility/file_type_bios.c \
	futility/file_type.c \
	futility/file_type_rwsig.c \
	futility/file_type_usbpd1.c \
	futility/misc.c \
	futility/ryu_root_header.c \
	futility/updater.c \
	futility/updater_archive.c \
	futility/updater_quirks.c \
	futility/updater_utils.c \
	futility/vb1_helper.c \
	futility/vb2_helper.c

# List of commands built in futility.
FUTIL_CMD_LIST = ${BUILD}/gen/futility_cmds.c

FUTIL_OBJS = ${FUTIL_SRCS:%.c=${BUILD}/%.o} ${FUTIL_CMD_LIST:%.c=%.o}

${FUTIL_OBJS}: INCLUDES += -Ihost/lib21/include

ALL_OBJS += ${FUTIL_OBJS}


# Library of handy test functions.
TESTLIB = ${BUILD}/tests/test.a

TESTLIB_SRCS = \
	tests/test_common.c \
	tests/timer_utils.c \
	tests/crc32_test.c

TESTLIB_OBJS = ${TESTLIB_SRCS:%.c=${BUILD}/%.o}
TEST_OBJS += ${TESTLIB_OBJS}


# And some compiled tests.
TEST_NAMES = \
	tests/cgptlib_test \
	tests/chromeos_config_tests \
	tests/sha_benchmark \
	tests/subprocess_tests \
	tests/vboot_api_kernel4_tests \
	tests/vboot_api_kernel_tests \
	tests/vboot_kernel_tests \
	tests/vboot_ui_legacy_clamshell_beep_tests \
	tests/vboot_ui_legacy_clamshell_tests \
	tests/vboot_ui_legacy_menu_tests \
	tests/vboot_ui_legacy_tests \
	tests/verify_kernel

ifeq (${MOCK_TPM}${TPM2_MODE},)
# tlcl_tests only works when MOCK_TPM is disabled
# TODO(apronin): tests for TPM2 case?
TEST_NAMES += \
	tests/tlcl_tests
endif

TEST_FUTIL_NAMES = \
	tests/futility/binary_editor \
	tests/futility/test_file_types \
	tests/futility/test_not_really

TEST_NAMES += ${TEST_FUTIL_NAMES}

TEST2X_NAMES = \
	tests/vb2_api_tests \
	tests/vb2_auxfw_sync_tests \
	tests/vb2_common_tests \
	tests/vb2_common2_tests \
	tests/vb2_common3_tests \
	tests/vb2_crypto_tests \
	tests/vb2_ec_sync_tests \
	tests/vb2_gbb_tests \
	tests/vb2_host_flashrom_tests \
	tests/vb2_host_key_tests \
	tests/vb2_host_nvdata_flashrom_tests \
	tests/vb2_kernel_tests \
	tests/vb2_misc_tests \
	tests/vb2_nvstorage_tests \
	tests/vb2_rsa_utility_tests \
	tests/vb2_recovery_reasons_tests \
	tests/vb2_secdata_firmware_tests \
	tests/vb2_secdata_fwmp_tests \
	tests/vb2_secdata_kernel_tests \
	tests/vb2_sha_api_tests \
	tests/vb2_sha_tests \
	tests/vb2_ui_tests \
	tests/vb2_ui_action_tests \
	tests/vb2_ui_utility_tests \
	tests/hmac_test

TEST20_NAMES = \
	tests/vb20_api_kernel_tests \
	tests/vb20_verify_fw.c \
	tests/vb20_kernel_tests \
	tests/vb20_misc_tests \
	tests/vb20_rsa_padding_tests \
	tests/vb20_verify_fw

TEST21_NAMES = \
	tests/vb21_host_common2_tests \
	tests/vb21_host_common_tests \
	tests/vb21_host_key_tests \
	tests/vb21_host_misc_tests \
	tests/vb21_host_sig_tests

TEST_NAMES += ${TEST2X_NAMES} ${TEST20_NAMES} ${TEST21_NAMES}

# And a few more...
ifeq (${TPM2_MODE},)
TLCL_TEST_NAMES = \
	tests/tpm_lite/tpmtest_earlyextend \
	tests/tpm_lite/tpmtest_earlynvram \
	tests/tpm_lite/tpmtest_earlynvram2 \
	tests/tpm_lite/tpmtest_enable \
	tests/tpm_lite/tpmtest_fastenable \
	tests/tpm_lite/tpmtest_globallock \
	tests/tpm_lite/tpmtest_redefine_unowned \
	tests/tpm_lite/tpmtest_spaceperm \
	tests/tpm_lite/tpmtest_testsetup \
	tests/tpm_lite/tpmtest_timing \
	tests/tpm_lite/tpmtest_writelimit
else
# TODO(apronin): tests for TPM2 case?
TLCL_TEST_NAMES =
endif

TEST_NAMES += ${TLCL_TEST_NAMES}

# Finally
TEST_BINS = $(addprefix ${BUILD}/,${TEST_NAMES})
TEST_OBJS += $(addsuffix .o,${TEST_BINS})

TEST_FUTIL_BINS = $(addprefix ${BUILD}/,${TEST_FUTIL_NAMES})
TEST2X_BINS = $(addprefix ${BUILD}/,${TEST2X_NAMES})
TEST20_BINS = $(addprefix ${BUILD}/,${TEST20_NAMES})
TEST21_BINS = $(addprefix ${BUILD}/,${TEST21_NAMES})

# Directory containing test keys
TEST_KEYS = ${SRC_RUN}/tests/testkeys

# ----------------------------------------------------------------------------
# Fuzzing binaries

FUZZ_TEST_NAMES = \
	tests/cgpt_fuzzer \
	tests/vb2_keyblock_fuzzer \
	tests/vb2_preamble_fuzzer

FUZZ_TEST_BINS = $(addprefix ${BUILD}/,${FUZZ_TEST_NAMES})

##############################################################################
# Finally, some targets. High-level ones first.

# Create output directories if necessary.  Do this via explicit shell commands
# so it happens before trying to generate/include dependencies.
SUBDIRS := firmware host cgpt utility futility tests tests/tpm_lite
_dir_create := $(foreach d, \
	$(shell find ${SUBDIRS} -name '*.c' -exec  dirname {} \; | sort -u), \
	$(shell [ -d ${BUILD}/${d} ] || mkdir -p ${BUILD}/${d}))

.PHONY: clean
clean:
	${Q}/bin/rm -rf ${BUILD}

.PHONY: install
install: cgpt_install signing_install futil_install pc_files_install \
	lib_install $(if ${SDK_BUILD},utils_install_sdk,utils_install_board)

.PHONY: install_dev
install_dev: devkeys_install headers_install

.PHONY: install_mtd
install_mtd: install cgpt_wrapper_install

.PHONY: install_for_test
install_for_test: override DESTDIR = ${TEST_INSTALL_DIR}
install_for_test: test_setup
install_for_test: install utils_install_sdk utils_install_board

# Don't delete intermediate object files
.SECONDARY:

# ----------------------------------------------------------------------------
# Firmware library

# TPM-specific flags.  These depend on the particular TPM we're targeting for.
# They are needed here only for compiling parts of the firmware code into
# user-level tests.

# TPM_BLOCKING_CONTINUESELFTEST is defined if TPM_ContinueSelfTest blocks until
# the self test has completed.

${TLCL_OBJS}: CFLAGS += -DTPM_BLOCKING_CONTINUESELFTEST

# TPM_MANUAL_SELFTEST is defined if the self test must be started manually
# (with a call to TPM_ContinueSelfTest) instead of starting automatically at
# power on.
#
# We sincerely hope that TPM_BLOCKING_CONTINUESELFTEST and TPM_MANUAL_SELFTEST
# are not both defined at the same time.  (See comment in code.)

# CFLAGS += -DTPM_MANUAL_SELFTEST

# NOTE: UNROLL_LOOPS *only* affects SHA256, *not* SHA512. This seems to have
# been a conscious decision at some point (see b/35501356) but whether it still
# holds up in all situations on all architectures today might need to be
# reevaluated. For now, since we currently always use SHA256 for (non-recovery)
# kernel bodies and don't unroll loops for firmware verification, it's not very
# relevant in practice. To unroll SHA512, UNROLL_LOOPS_SHA512 would need to be
# defined.
ifneq ($(filter-out 0,$(UNROLL_LOOPS)),)
$(info vboot SHA256 built with unrolled loops (faster, larger code size))
CFLAGS += -DUNROLL_LOOPS
else
$(info vboot SHA256 built with tight loops (slower, smaller code size))
endif

.PHONY: fwlib
fwlib: $(if ${FIRMWARE_ARCH},${FWLIB},)

${FWLIB}: ${FWLIB_OBJS}
	@${PRINTF} "    RM            $(subst ${BUILD}/,,$@)\n"
	${Q}rm -f $@
	@${PRINTF} "    AR            $(subst ${BUILD}/,,$@)\n"
	${Q}ar qc $@ $^

.PHONY: tlcl
tlcl: ${TLCL}

${TLCL}: ${TLCL_OBJS}
	@${PRINTF} "    RM            $(subst ${BUILD}/,,$@)\n"
	${Q}rm -f $@
	@${PRINTF} "    AR            $(subst ${BUILD}/,,$@)\n"
	${Q}ar qc $@ $^

# ----------------------------------------------------------------------------
# Host library(s)

.PHONY: utillib
utillib: ${UTILLIB}

# TODO: better way to make .a than duplicating this recipe each time?
${UTILLIB}: ${UTILLIB_OBJS} ${FWLIB_OBJS} ${TLCL_OBJS}
	@${PRINTF} "    RM            $(subst ${BUILD}/,,$@)\n"
	${Q}rm -f $@
	@${PRINTF} "    AR            $(subst ${BUILD}/,,$@)\n"
	${Q}ar qc $@ $^

.PHONY: hostlib
hostlib: ${HOSTLIB}

# TODO: better way to make .a than duplicating this recipe each time?
${HOSTLIB}: ${HOSTLIB_OBJS}
	@${PRINTF} "    RM            $(subst ${BUILD}/,,$@)\n"
	${Q}rm -f $@
	@${PRINTF} "    AR            $(subst ${BUILD}/,,$@)\n"
	${Q}ar qc $@ $^

.PHONY: headers_install
headers_install:
	@${PRINTF} "    INSTALL       HEADERS\n"
	${Q}mkdir -p ${UI_DIR}
	${Q}${INSTALL} -t ${UI_DIR} -m644 \
		host/include/* \
		firmware/2lib/include/2crypto.h \
		firmware/2lib/include/2recovery_reasons.h \
		firmware/2lib/include/2sysincludes.h \
		firmware/include/gpt.h \
		firmware/include/tlcl.h \
		firmware/include/tss_constants.h \
		firmware/include/tpm1_tss_constants.h \
		firmware/include/tpm2_tss_constants.h

.PHONY: lib_install
lib_install: ${HOSTLIB}
	@${PRINTF} "    INSTALL       HOSTLIB\n"
	${Q}mkdir -p ${UL_DIR}
	${Q}${INSTALL} -t ${UL_DIR} -m644 $^

.PHONY: devkeys_install
devkeys_install:
	@${PRINTF} "    INSTALL       DEVKEYS\n"
	${Q}mkdir -p ${US_DIR}/devkeys
	${Q}${INSTALL} -t ${US_DIR}/devkeys -m644 \
		`find tests/devkeys -type f -maxdepth 1`

# ----------------------------------------------------------------------------
# CGPT library and utility

.PHONY: cgpt_wrapper
cgpt_wrapper: ${CGPT_WRAPPER}

${CGPT_WRAPPER}: ${CGPT_WRAPPER_OBJS} ${UTILLIB}
	@$(PRINTF) "    LD            $(subst ${BUILD}/,,$@)\n"
	${Q}${LD} -o ${CGPT_WRAPPER} ${LDFLAGS} $^ ${LDLIBS}

.PHONY: cgpt
cgpt: ${CGPT} ${CGPT_WRAPPER}

# on FreeBSD: install misc/e2fsprogs-libuuid from ports,
# or e2fsprogs-libuuid from its binary package system.
${CGPT}: LDLIBS += -luuid

${CGPT}: ${CGPT_OBJS} ${UTILLIB}
	@${PRINTF} "    LDcgpt        $(subst ${BUILD}/,,$@)\n"
	${Q}${LD} -o ${CGPT} ${LDFLAGS} $^ ${LDLIBS}

.PHONY: cgpt_install
cgpt_install: ${CGPT}
	@${PRINTF} "    INSTALL       CGPT\n"
	${Q}mkdir -p ${UB_DIR}
	${Q}${INSTALL} -t ${UB_DIR} $^

.PHONY: cgpt_wrapper_install
cgpt_wrapper_install: cgpt_install ${CGPT_WRAPPER}
	@$(PRINTF) "    INSTALL       cgpt_wrapper\n"
	${Q}${INSTALL} -t ${UB_DIR} ${CGPT_WRAPPER}
	${Q}mv ${UB_DIR}/$(notdir ${CGPT}) \
		${UB_DIR}/$(notdir ${CGPT}).bin
	${Q}mv ${UB_DIR}/$(notdir ${CGPT_WRAPPER}) \
		${UB_DIR}/$(notdir ${CGPT})

# ----------------------------------------------------------------------------
# Utilities

# These have their own headers too.
${BUILD}/utility/%: INCLUDES += -Iutility/include

${UTIL_BINS_SDK}: ${UTILLIB}
${UTIL_BINS_SDK}: LIBS = ${UTILLIB}
${UTIL_BINS_BOARD}: ${UTILLIB}
${UTIL_BINS_BOARD}: LIBS = ${UTILLIB}

.PHONY: utils_sdk
utils_sdk: ${UTIL_BINS_SDK} ${UTIL_SCRIPTS_SDK}
	${Q}cp -f ${UTIL_SCRIPTS_SDK} ${BUILD}/utility
	${Q}chmod a+rx $(patsubst %,${BUILD}/%,${UTIL_SCRIPTS_SDK})

.PHONY: utils_board
utils_board: ${UTIL_BINS_BOARD} ${UTIL_SCRIPTS_BOARD}
	${Q}cp -f ${UTIL_SCRIPTS_BOARD} ${BUILD}/utility
	${Q}chmod a+rx $(patsubst %,${BUILD}/%,${UTIL_SCRIPTS_BOARD})

.PHONY: utils_install_sdk
utils_install_sdk: utils_sdk
	@${PRINTF} "    INSTALL       UTILS\n"
	${Q}mkdir -p ${UB_DIR}
	${Q}${INSTALL} -t ${UB_DIR} ${UTIL_BINS_SDK} ${UTIL_SCRIPTS_SDK}

.PHONY: utils_install_board
utils_install_board: utils_board ${UTIL_DEFAULTS}
	@${PRINTF} "    INSTALL       UTILS\n"
	${Q}mkdir -p ${UB_DIR}
	${Q}${INSTALL} -t ${UB_DIR} ${UTIL_BINS_BOARD} ${UTIL_SCRIPTS_BOARD}
	${Q}mkdir -p ${DF_DIR}
	${Q}${INSTALL} -t ${DF_DIR} -m 'u=rw,go=r,a-s' ${UTIL_DEFAULTS}

# And some signing stuff for the target
.PHONY: signing_install
signing_install: $(if ${SDK_BUILD},\
		   ${SIGNING_SCRIPTS_SDK},${SIGNING_SCRIPTS_BOARD})
	@${PRINTF} "    INSTALL       SIGNING\n"
	${Q}mkdir -p ${VB_DIR}
	${Q}${INSTALL} -t ${VB_DIR} $^

# ----------------------------------------------------------------------------
# Firmware Utility

.PHONY: futil
futil: ${FUTIL_BIN}

# FUTIL_LIBS is shared by FUTIL_BIN and TEST_FUTIL_BINS.
FUTIL_LIBS = ${CRYPTO_LIBS} ${LIBZIP_LIBS}

${FUTIL_BIN}: LDLIBS += ${FUTIL_LIBS}
${FUTIL_BIN}: ${FUTIL_OBJS} ${UTILLIB} ${FWLIB}
	@${PRINTF} "    LD            $(subst ${BUILD}/,,$@)\n"
	${Q}${LD} -o $@ ${LDFLAGS} $^ ${LDLIBS}

.PHONY: futil_install
futil_install: ${FUTIL_BIN}
	@${PRINTF} "    INSTALL       futility\n"
	${Q}mkdir -p ${UB_DIR}
	${Q}${INSTALL} -t ${UB_DIR} ${FUTIL_BIN}
	${Q}for prog in ${FUTIL_SYMLINKS}; do \
		ln -sf futility "${UB_DIR}/$$prog"; done

# ----------------------------------------------------------------------------
# Utility to generate TLCL structure definition header file.

${BUILD}/utility/tlcl_generator: CFLAGS += -fpack-struct

STRUCTURES_TMP=${BUILD}/tlcl_structures.tmp
STRUCTURES_SRC=firmware/lib/tpm_lite/include/tlcl_structures.h

.PHONY: update_tlcl_structures
update_tlcl_structures: ${BUILD}/utility/tlcl_generator
	@${PRINTF} "    Rebuilding TLCL structures\n"
	${Q}${BUILD}/utility/tlcl_generator > ${STRUCTURES_TMP}
	${Q}cmp -s ${STRUCTURES_TMP} ${STRUCTURES_SRC} || \
		( echo "%% Updating structures.h %%" && \
		  cp ${STRUCTURES_TMP} ${STRUCTURES_SRC} )

# ----------------------------------------------------------------------------
# Tests

.PHONY: tests
tests: ${TEST_BINS}

${TEST_BINS}: ${UTILLIB} ${TESTLIB}
${TEST_BINS}: INCLUDES += -Itests
${TEST_BINS}: LIBS = ${TESTLIB} ${UTILLIB}

# Futility tests need almost everything that futility needs.
${TEST_FUTIL_BINS}: ${FUTIL_OBJS} ${UTILLIB}
${TEST_FUTIL_BINS}: INCLUDES += -Ifutility
${TEST_FUTIL_BINS}: OBJS += ${FUTIL_OBJS} ${UTILLIB}
${TEST_FUTIL_BINS}: LDLIBS += ${FUTIL_LIBS}

${TEST2X_BINS}: ${FWLIB}
${TEST2X_BINS}: LIBS += ${FWLIB}

${TEST20_BINS}: ${FWLIB}
${TEST20_BINS}: LIBS += ${FWLIB}
${TEST20_BINS}: LDLIBS += ${CRYPTO_LIBS}

${TESTLIB}: ${TESTLIB_OBJS}
	@${PRINTF} "    RM            $(subst ${BUILD}/,,$@)\n"
	${Q}rm -f $@
	@${PRINTF} "    AR            $(subst ${BUILD}/,,$@)\n"
	${Q}ar qc $@ $^

# ----------------------------------------------------------------------------
# Fuzzers

.PHONY: fuzzers
fuzzers: ${FUZZ_TEST_BINS}

${FUZZ_TEST_BINS}: ${FWLIB}
${FUZZ_TEST_BINS}: LIBS = ${FWLIB}
${FUZZ_TEST_BINS}: LDFLAGS += -fsanitize=fuzzer

# ----------------------------------------------------------------------------
# Generic build rules. LIBS and OBJS can be overridden to tweak the generic
# rules for specific targets.

${BUILD}/%: ${BUILD}/%.o ${OBJS} ${LIBS}
	@${PRINTF} "    LD            $(subst ${BUILD}/,,$@)\n"
	${Q}${LD} -o $@ ${LDFLAGS} $< ${OBJS} ${LIBS} ${LDLIBS}

${BUILD}/%.o: %.c
	@${PRINTF} "    CC            $(subst ${BUILD}/,,$@)\n"
	${Q}${CC} ${CFLAGS} ${INCLUDES} -c -o $@ $<

${BUILD}/%.o: ${BUILD}/%.c
	@${PRINTF} "    CC            $(subst ${BUILD}/,,$@)\n"
	${Q}${CC} ${CFLAGS} ${INCLUDES} -c -o $@ $<

# ----------------------------------------------------------------------------
# Here are the special tweaks to the generic rules.

# Always create the defaults file, since it depends on input variables
.PHONY: ${UTIL_DEFAULTS}
${UTIL_DEFAULTS}:
	@${PRINTF} "    CREATE        $(subst ${BUILD}/,,$@)\n"
	${Q}rm -f $@
	${Q}mkdir -p $(dir $@)
	${Q}echo '# Generated file. Do not edit.' > $@.tmp
	${Q}echo "DEV_DEBUG_FORCE=${DEV_DEBUG_FORCE}" >> $@.tmp
	${Q}mv -f $@.tmp $@

# Some utilities need external crypto functions
CRYPTO_LIBS := $(shell ${PKG_CONFIG} --libs libcrypto)
ifeq ($(shell uname -s), FreeBSD)
CRYPTO_LIBS += -lcrypto
endif

${BUILD}/utility/dumpRSAPublicKey: LDLIBS += ${CRYPTO_LIBS}
${BUILD}/utility/pad_digest_utility: LDLIBS += ${CRYPTO_LIBS}
${BUILD}/utility/signature_digest_utility: LDLIBS += ${CRYPTO_LIBS}
${BUILD}/utility/verify_data: LDLIBS += ${CRYPTO_LIBS}

${BUILD}/tests/vb2_host_key_tests: LDLIBS += ${CRYPTO_LIBS}
${BUILD}/tests/vb2_common2_tests: LDLIBS += ${CRYPTO_LIBS}
${BUILD}/tests/vb2_common3_tests: LDLIBS += ${CRYPTO_LIBS}
${BUILD}/tests/verify_kernel: LDLIBS += ${CRYPTO_LIBS}
${BUILD}/tests/hmac_test: LDLIBS += ${CRYPTO_LIBS}

${TEST21_BINS}: LDLIBS += ${CRYPTO_LIBS}

# Allow multiple definitions, so tests can mock functions from other libraries
${BUILD}/tests/%: LDFLAGS += -Xlinker --allow-multiple-definition
${BUILD}/tests/%: LDLIBS += -lrt -luuid
${BUILD}/tests/%: LIBS += ${TESTLIB}

ifeq (${TPM2_MODE},)
# TODO(apronin): tests for TPM2 case?
TLCL_TEST_BINS = $(addprefix ${BUILD}/,${TLCL_TEST_NAMES})
${TLCL_TEST_BINS}: OBJS += ${BUILD}/tests/tpm_lite/tlcl_tests.o
${TLCL_TEST_BINS}: ${BUILD}/tests/tpm_lite/tlcl_tests.o
TEST_OBJS += ${BUILD}/tests/tpm_lite/tlcl_tests.o
endif

# ----------------------------------------------------------------------------
# Here are the special rules that don't fit in the generic rules.

# Generates the list of commands defined in futility by running grep in the
# source files looking for the DECLARE_FUTIL_COMMAND() macro usage.
${FUTIL_CMD_LIST}: ${FUTIL_SRCS}
	@${PRINTF} "    GEN           $(subst ${BUILD}/,,$@)\n"
	${Q}rm -f $@ $@_t $@_commands
	${Q}mkdir -p ${BUILD}/gen
	${Q}grep -hoRE '^DECLARE_FUTIL_COMMAND\([^,]+' $^ \
		| sed 's/DECLARE_FUTIL_COMMAND(\(.*\)/_CMD(\1)/' \
		| sort >>$@_commands
	${Q}./scripts/getversion.sh >> $@_t
	${Q}echo '#define _CMD(NAME) extern const struct' \
		'futil_cmd_t __cmd_##NAME;' >> $@_t
	${Q}cat $@_commands >> $@_t
	${Q}echo '#undef _CMD' >> $@_t
	${Q}echo '#define _CMD(NAME) &__cmd_##NAME,' >> $@_t
	${Q}echo 'const struct futil_cmd_t *const futil_cmds[] = {' >> $@_t
	${Q}cat $@_commands >> $@_t
	${Q}echo '0};  /* null-terminated */' >> $@_t
	${Q}echo '#undef _CMD' >> $@_t
	${Q}mv $@_t $@
	${Q}rm -f $@_commands

##############################################################################
# Targets that exist just to run tests

.PHONY: test_setup
test_setup:: cgpt utils_sdk utils_board futil tests

# Qemu setup for cross-compiled tests.  Need to copy qemu binary into the
# sysroot.
ifneq (${QEMU_ARCH},)
test_setup:: qemu_install

.PHONY: qemu_install
qemu_install:
ifeq (${SYSROOT},)
	$(error SYSROOT must be set to the top of the target-specific root \
when cross-compiling for qemu-based tests to run properly.)
endif
	@${PRINTF} "    Copying qemu binary.\n"
	${Q}cp -fu /usr/bin/${QEMU_BIN} ${BUILD}/${QEMU_BIN}
	${Q}chmod a+rx ${BUILD}/${QEMU_BIN}
endif

# Generate test keys
.PHONY: genkeys
genkeys: install_for_test
	tests/gen_test_keys.sh

# Generate test cases
.PHONY: gentestcases
gentestcases: install_for_test
	tests/gen_test_cases.sh

# Generate test cases for fuzzing
.PHONY: genfuzztestcases
genfuzztestcases: install_for_test
	tests/gen_fuzz_test_cases.sh

.PHONY: runcgpttests
runcgpttests: install_for_test
	${RUNTEST} ${BUILD_RUN}/tests/cgptlib_test

.PHONY: runtestscripts
runtestscripts: install_for_test genfuzztestcases
	scripts/image_signing/sign_android_unittests.sh
	tests/load_kernel_tests.sh
	tests/run_cgpt_tests.sh ${BUILD_RUN}/cgpt/cgpt
	tests/run_cgpt_tests.sh ${BUILD_RUN}/cgpt/cgpt -D 358400
	tests/run_preamble_tests.sh
	tests/run_vbutil_kernel_arg_tests.sh
	tests/run_vbutil_tests.sh
	tests/vb2_rsa_tests.sh
	tests/vb2_firmware_tests.sh

.PHONY: runmisctests
runmisctests: install_for_test
	${RUNTEST} ${BUILD_RUN}/tests/subprocess_tests
ifeq (${MOCK_TPM}${TPM2_MODE},)
# tlcl_tests only works when MOCK_TPM is disabled
	${RUNTEST} ${BUILD_RUN}/tests/tlcl_tests
endif
	${RUNTEST} ${BUILD_RUN}/tests/vboot_api_kernel4_tests
	${RUNTEST} ${BUILD_RUN}/tests/vboot_api_kernel_tests
	${RUNTEST} ${BUILD_RUN}/tests/vboot_kernel_tests
	${RUNTEST} ${BUILD_RUN}/tests/vboot_ui_legacy_clamshell_beep_tests
	${RUNTEST} ${BUILD_RUN}/tests/vboot_ui_legacy_clamshell_tests
	${RUNTEST} ${BUILD_RUN}/tests/vboot_ui_legacy_menu_tests
	${RUNTEST} ${BUILD_RUN}/tests/vboot_ui_legacy_tests

.PHONY: run2tests
run2tests: install_for_test
	${RUNTEST} ${BUILD_RUN}/tests/vb2_api_tests
	${RUNTEST} ${BUILD_RUN}/tests/vb2_auxfw_sync_tests
	${RUNTEST} ${BUILD_RUN}/tests/vb2_common_tests
	${RUNTEST} ${BUILD_RUN}/tests/vb2_common2_tests ${TEST_KEYS}
	${RUNTEST} ${BUILD_RUN}/tests/vb2_common3_tests ${TEST_KEYS}
	${RUNTEST} ${BUILD_RUN}/tests/vb2_crypto_tests
	${RUNTEST} ${BUILD_RUN}/tests/vb2_ec_sync_tests
	${RUNTEST} ${BUILD_RUN}/tests/vb2_gbb_tests
	${RUNTEST} ${BUILD_RUN}/tests/vb2_host_key_tests
	${RUNTEST} ${BUILD_RUN}/tests/vb2_kernel_tests
	${RUNTEST} ${BUILD_RUN}/tests/vb2_misc_tests
	${RUNTEST} ${BUILD_RUN}/tests/vb2_nvstorage_tests
	${RUNTEST} ${BUILD_RUN}/tests/vb2_rsa_utility_tests
	${RUNTEST} ${BUILD_RUN}/tests/vb2_secdata_firmware_tests
	${RUNTEST} ${BUILD_RUN}/tests/vb2_secdata_fwmp_tests
	${RUNTEST} ${BUILD_RUN}/tests/vb2_secdata_kernel_tests
	${RUNTEST} ${BUILD_RUN}/tests/vb2_sha_api_tests
	${RUNTEST} ${BUILD_RUN}/tests/vb2_sha_tests
	${RUNTEST} ${BUILD_RUN}/tests/vb2_ui_tests
	${RUNTEST} ${BUILD_RUN}/tests/vb2_ui_action_tests
	${RUNTEST} ${BUILD_RUN}/tests/vb2_ui_utility_tests
	${RUNTEST} ${BUILD_RUN}/tests/vb20_api_kernel_tests
	${RUNTEST} ${BUILD_RUN}/tests/vb20_kernel_tests
	${RUNTEST} ${BUILD_RUN}/tests/vb20_misc_tests
	${RUNTEST} ${BUILD_RUN}/tests/vb21_host_common_tests
	${RUNTEST} ${BUILD_RUN}/tests/vb21_host_common2_tests ${TEST_KEYS}
	${RUNTEST} ${BUILD_RUN}/tests/vb21_host_key_tests ${TEST_KEYS} ${BUILD}
	${RUNTEST} ${BUILD_RUN}/tests/vb21_host_misc_tests ${BUILD}
	${RUNTEST} ${BUILD_RUN}/tests/vb21_host_sig_tests ${TEST_KEYS}
	${RUNTEST} ${BUILD_RUN}/tests/hmac_test

.PHONY: runfutiltests
runfutiltests: install_for_test
	tests/futility/run_test_scripts.sh
	${RUNTEST} ${BUILD_RUN}/tests/futility/test_file_types
	${RUNTEST} ${BUILD_RUN}/tests/futility/test_not_really

# Test all permutations of encryption keys, instead of just the ones we use.
# Not run by automated build.
.PHONY: runlongtests
runlongtests: install_for_test genkeys genfuzztestcases
	${RUNTEST} ${BUILD_RUN}/tests/vb2_common2_tests ${TEST_KEYS} --all
	${RUNTEST} ${BUILD_RUN}/tests/vb2_common3_tests ${TEST_KEYS} --all
	${RUNTEST} ${BUILD_RUN}/tests/vb21_host_common2_tests ${TEST_KEYS} --all
	tests/run_preamble_tests.sh --all
	tests/run_vbutil_tests.sh --all

.PHONY: rununittests
rununittests: runcgpttests runmisctests run2tests

# Print a big green success message at the end of all tests. If you don't see
# that, you know there was an error somewhere further up.
.PHONY: runtests
runtests: rununittests runtestscripts runfutiltests
	${Q}echo -e "\nruntests: \E[32;1mALL TESTS PASSED SUCCESSFULLY!\E[0;m\n"

# Code coverage
.PHONY: coverage_init
coverage_init: install_for_test
	rm -f ${COV_INFO}*
	lcov -c -i -d . -b . -o ${COV_INFO}.initial

.PHONY: coverage_html
coverage_html:
	lcov -c -d . -b . -o ${COV_INFO}.tests
	lcov -a ${COV_INFO}.initial -a ${COV_INFO}.tests -o ${COV_INFO}.total
	lcov -r ${COV_INFO}.total '/usr/*' -o ${COV_INFO}.local
	genhtml ${COV_INFO}.local -o ${BUILD}/coverage
# Generate addtional coverage stats just for firmware subdir, because the stats
# for the whole project don't include subdirectory summaries. This will print
# the summary for just the firmware sources.
	lcov -r ${COV_INFO}.local '*/stub/*' -o ${COV_INFO}.nostub
	lcov -e ${COV_INFO}.nostub '${SRCDIR}/firmware/*' \
		-o ${COV_INFO}.firmware

.PHONY: coverage
ifeq (${COV},)
coverage:
	$(error Build coverage like this: make clean && COV=1 make coverage)
else
coverage: coverage_init runtests coverage_html
endif

# Include generated dependencies
ALL_DEPS += ${ALL_OBJS:%.o=%.o.d}
TEST_DEPS += ${TEST_OBJS:%.o=%.o.d}
-include ${ALL_DEPS}
-include ${TEST_DEPS}

# We want to use only relative paths in cscope.files, especially since the
# paths inside and outside the chroot are different.
SRCDIRPAT=$(subst /,\/,${SRCDIR}/)

# Note: vboot 2.0 is deprecated, so don't index those files
${BUILD}/cscope.files: all install_for_test
	${Q}rm -f $@
	${Q}cat ${ALL_DEPS} | tr -d ':\\' | tr ' ' '\012' | \
		grep -v /lib20/ | \
		sed -e "s/${SRCDIRPAT}//" | \
		egrep '\.[chS]$$' | sort | uniq > $@

cmd_etags = etags -o ${BUILD}/TAGS $(shell cat ${BUILD}/cscope.files)
cmd_ctags = ctags -o ${BUILD}/tags $(shell cat ${BUILD}/cscope.files)
run_if_prog = $(if $(shell which $(1) 2>/dev/null),$(2),)

.PHONY: tags TAGS xrefs
tags TAGS xrefs: ${BUILD}/cscope.files
	${Q}\rm -f ${BUILD}/tags ${BUILD}/TAGS
	${Q}$(call run_if_prog,etags,${cmd_etags})
	${Q}$(call run_if_prog,ctags,${cmd_ctags})

PC_FILES = ${PC_IN_FILES:%.pc.in=${BUILD}/%.pc}
${PC_FILES}: ${PC_IN_FILES}
	${Q}sed \
		-e 's:@LDLIBS@:${LDLIBS}:' \
		-e 's:@LIBDIR@:${LIBDIR}:' \
		$< > $@

.PHONY: pc_files_install
pc_files_install: ${PC_FILES}
	${Q}mkdir -p ${ULP_DIR}
	${Q}${INSTALL} -D -m 0644 $< ${ULP_DIR}/$(notdir $<)
