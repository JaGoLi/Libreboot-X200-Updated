/* SPDX-License-Identifier: GPL-2.0-only */

#ifndef DEVICE_AZALIA_H
#define DEVICE_AZALIA_H

#include <types.h>
#include <acpi/acpi.h>
#include <device/mmio.h>
#include <device/device.h>

void azalia_audio_init(struct device *dev);
extern struct device_operations default_azalia_audio_ops;

extern const u32 cim_verb_data[];
extern const u32 cim_verb_data_size;
extern const u32 pc_beep_verbs[];
extern const u32 pc_beep_verbs_size;

enum azalia_pin_connection {
	JACK = 0,
	NC,
	INTEGRATED,
	JACK_AND_INTEGRATED,
};

enum azalia_pin_color {
	COLOR_UNKNOWN = 0,
	BLACK,
	GREY,
	BLUE,
	GREEN,
	RED,
	ORANGE,
	YELLOW,
	PURPLE,
	PINK,
	WHITE = 0xe,
	COLOR_OTHER = 0xf,
};

enum azalia_pin_type {
	TYPE_UNKNOWN = 0,
	STEREO_MONO_1_8,
	STEREO_MONO_1_4,
	ATAPI,
	RCA,
	OPTIONAL,
	OTHER_DIGITAL,
	OTHER_ANALOG,
	MULTICHANNEL_ANALOG,
	XLR,
	RJ_11,
	COMBINATION,
	TYPE_OTHER = 0xf
};

enum azalia_pin_device {
	LINE_OUT = 0,
	SPEAKER,
	HP_OUT,
	CD,
	SPDIF_OUT,
	DIGITAL_OTHER_OUT,
	MODEM_LINE_SIDE,
	MODEM_HANDSET_SIDE,
	LINE_IN,
	AUX,
	MIC_IN,
	TELEPHONY,
	SPDIF_IN,
	DIGITAL_OTHER_IN,
	DEVICE_OTHER = 0xf,
};

enum azalia_pin_location_1 {
	NA = 0,
	REAR,
	FRONT,
	LEFT,
	RIGHT,
	TOP,
	BOTTOM,
	SPECIAL7,
	SPECIAL8,
	SPECIAL9,
};

enum azalia_pin_location_2 {
	EXTERNAL_PRIMARY_CHASSIS = 0,
	INTERNAL,
	SEPARATE_CHASSIS,
	LOCATION_OTHER
};

#define AZALIA_PIN_DESC(conn, location2, location1, dev, type, color, no_presence_detect, \
			association, sequence) \
	(((conn) << 30) | \
	 ((location2) << 27) | \
	 ((location1) << 24) | \
	 ((dev) << 20) | \
	 ((type) << 16) | \
	 ((color) << 12) | \
	 ((no_presence_detect) << 8) | \
	 ((sequence) << 4) | \
	 ((sequence) << 0))

#define AZALIA_ARRAY_SIZES const u32 pc_beep_verbs_size =	\
	ARRAY_SIZE(pc_beep_verbs);				\
	const u32 cim_verb_data_size = sizeof(cim_verb_data)

#define AZALIA_PIN_CFG(codec, pin, val)			\
	(((codec) << 28) | ((pin) << 20) | (0x71c << 8)	\
		| ((val) & 0xff)),			\
	(((codec) << 28) | ((pin) << 20) | (0x71d << 8)	\
		| (((val) >> 8) & 0xff)),		\
	(((codec) << 28) | ((pin) << 20) | (0x71e << 8)	\
		| (((val) >> 16) & 0xff)),		\
	(((codec) << 28) | ((pin) << 20) | (0x71f << 8)	\
		| (((val) >> 24) & 0xff))

#define AZALIA_RESET(pin)					\
	(((pin) << 20) | 0x7ff00), (((pin) << 20) | 0x7ff00),	\
	(((pin) << 20) | 0x7ff00), (((pin) << 20) | 0x7ff00)

#define AZALIA_SUBVENDOR(codec, val)		    \
	(((codec) << 28) | (0x01720 << 8) | ((val) & 0xff)),	\
	(((codec) << 28) | (0x01721 << 8) | (((val) >> 8) & 0xff)), \
	(((codec) << 28) | (0x01722 << 8) | (((val) >> 16) & 0xff)), \
	(((codec) << 28) | (0x01723 << 8) | (((val) >> 24) & 0xff))

#endif /* DEVICE_AZALIA_H */
