/* Copyright 2019 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * This header is for APIs that are only used by test code.
 */

#ifndef VBOOT_REFERENCE_TEST_API_H_
#define VBOOT_REFERENCE_TEST_API_H_

/****************************************************************************
 * vboot_api_kernel.c */

struct LoadKernelParams;
struct LoadKernelParams *VbApiKernelGetParams(void);

#endif  /* VBOOT_REFERENCE_TEST_API_H_ */
