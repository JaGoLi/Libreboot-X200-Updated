#ifndef GPIO_NAMES_GPIO_GROUPS_H
#define GPIO_NAMES_GPIO_GROUPS_H

struct gpio_group {
	const char *display;
	size_t pad_count;
	size_t func_count;
	const char *const *pad_names; /* indexed by 'pad * func_count + func' */
};

struct gpio_community {
	const char *name;
	uint8_t pcr_port_id;
	size_t group_count;
	const struct gpio_group *const *groups;
};

#endif
