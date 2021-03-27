/* SPDX-License-Identifier: GPL-2.0-only */

#ifndef SOUTHBRIDGE_INTEL_RTC_H
#define SOUTHBRIDGE_INTEL_RTC_H

/* Return non-zero when RTC failure happened. */
int rtc_failure(void);
void sb_rtc_init(void);

#endif
