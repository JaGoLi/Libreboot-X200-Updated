/* Copyright (c) 2014 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * Stub API implementations which should be implemented by the caller.
 */

#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>

#include "2api.h"
#include "2sysincludes.h"

__attribute__((weak))
void vb2ex_printf(const char *func, const char *fmt, ...)
{
#ifdef VBOOT_DEBUG
	va_list ap;
	va_start(ap, fmt);
	if (func)
		fprintf(stderr, "%s: ", func);
	vfprintf(stderr, fmt, ap);
	va_end(ap);
#endif
}

__attribute__((weak))
vb2_error_t vb2ex_tpm_clear_owner(struct vb2_context *ctx)
{
	fprintf(stderr, "%s: function not implemented\n", __func__);
	return VB2_ERROR_EX_UNIMPLEMENTED;
}

__attribute__((weak))
vb2_error_t vb2ex_read_resource(struct vb2_context *ctx,
				enum vb2_resource_index index, uint32_t offset,
				void *buf, uint32_t size)
{
	fprintf(stderr, "%s: function not implemented\n", __func__);
	return VB2_ERROR_EX_UNIMPLEMENTED;
}

__attribute__((weak))
vb2_error_t vb2ex_tpm_set_mode(enum vb2_tpm_mode mode_val)
{
	fprintf(stderr, "%s: function not implemented\n", __func__);
	return VB2_ERROR_EX_UNIMPLEMENTED;
}

__attribute__((weak))
vb2_error_t vb2ex_auxfw_check(enum vb2_auxfw_update_severity *severity)
{
	*severity = VB2_AUXFW_NO_UPDATE;
	return VB2_SUCCESS;
}

__attribute__((weak))
vb2_error_t vb2ex_auxfw_update(void)
{
	return VB2_SUCCESS;
}

__attribute__((weak))
vb2_error_t vb2ex_auxfw_finalize(struct vb2_context *ctx)
{
	return VB2_SUCCESS;
}

__attribute__((weak))
void vb2ex_abort(void)
{
	/* Stub simply exits. */
	abort();
}

__attribute__((weak))
const char *vb2ex_get_debug_info(struct vb2_context *ctx)
{
	return NULL;
}

__attribute__((weak))
const char *vb2ex_get_firmware_log(int reset)
{
	return NULL;
}

__attribute__((weak))
uint32_t vb2ex_prepare_log_screen(enum vb2_screen screen, uint32_t locale_id,
				  const char *str)
{
	return 1;
}

__attribute__((weak))
const char *vb2ex_get_diagnostic_storage(void)
{
	return "mock";
}

__attribute__((weak))
vb2_error_t vb2ex_diag_memory_quick_test(int reset, const char **out)
{
	*out = "mock";
	return VB2_SUCCESS;
}

__attribute__((weak))
vb2_error_t vb2ex_diag_memory_full_test(int reset, const char **out)
{
	*out = "mock";
	return VB2_SUCCESS;
}
