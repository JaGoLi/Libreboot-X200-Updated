/* SPDX-License-Identifier: GPL-2.0-only */

#include <baseboard/variants.h>
#include <commonlib/helpers.h>

/* Pad configuration in ramstage*/
static const struct pad_config gpio_table[] = {
	/* ToDo: Fill gpio configurations */
};

/* Early pad configuration in bootblock */
static const struct pad_config early_gpio_table[] = {
	/* ToDo: Fill early gpio configurations */
};

const struct pad_config *variant_gpio_table(size_t *num)
{
	*num = ARRAY_SIZE(gpio_table);
	return gpio_table;
}

const struct pad_config *variant_early_gpio_table(size_t *num)
{
	*num = ARRAY_SIZE(early_gpio_table);
	return early_gpio_table;
}
