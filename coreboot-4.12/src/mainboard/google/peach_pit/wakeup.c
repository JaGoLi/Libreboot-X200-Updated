/* SPDX-License-Identifier: GPL-2.0-only */

#include <soc/gpio.h>
#include <soc/wakeup.h>

int wakeup_need_reset(void)
{
	/* The "wake up" event is not reliable (known as "bad wakeup") and needs
	 * reset if the TPM reset mask GPIO value is high. */
	return gpio_get_value(GPIO_X06);
}
