/* Copyright 2020 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * Kernel selection, loading, verification, and booting.
 */

#ifndef VBOOT_REFERENCE_2KERNEL_H_
#define VBOOT_REFERENCE_2KERNEL_H_

#include "2common.h"

/**
 * Handle a normal boot.
 *
 * @param ctx		Vboot context.
 * @return VB2_SUCCESS, or error code on error.
 */
vb2_error_t vb2_normal_boot(struct vb2_context *ctx);

#endif  /* VBOOT_REFERENCE_2KERNEL_H_ */
