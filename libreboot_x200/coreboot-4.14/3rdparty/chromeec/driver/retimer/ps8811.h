/* Copyright 2020 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * PS8811 retimer.
 */

#ifndef __CROS_EC_USB_RETIMER_PS8811_H
#define __CROS_EC_USB_RETIMER_PS8811_H

/*
 * PS8811 uses 7-bit I2C addresses 0x28 to 0x29 (ADDR=LL).
 * Page 0 = 0x28, Page 1 = 0x29.
 * PS8811 uses 7-bit I2C addresses 0x2A to 0x2B (ADDR=LH).
 * Page 0 = 0x2A, Page 1 = 0x2B.
 * PS8811 uses 7-bit I2C addresses 0x70 to 0x71 (ADDR=HL).
 * Page 0 = 0x70, Page 1 = 0x71.
 * PS8811 uses 7-bit I2C addresses 0x72 to 0x73 (ADDR=HH).
 * Page 0 = 0x72, Page 1 = 0x73.
 */
#define PS8811_I2C_ADDR_FLAGS0	0x28
#define PS8811_I2C_ADDR_FLAGS1	0x2A
#define PS8811_I2C_ADDR_FLAGS2	0x70
#define PS8811_I2C_ADDR_FLAGS3	0x72

/*
 * PAGE 1 Register Definitions
 */
#define PS8811_REG_PAGE1	0x01

#define PS8811_REG1_USB_BEQ_LEVEL	0x05
#define PS8811_BEQ_PIN_LEVEL_UP_9DB		0x00
#define PS8811_BEQ_PIN_LEVEL_UP_10_5DB		0x01
#define PS8811_BEQ_PIN_LEVEL_UP_12DB		0x02
#define PS8811_BEQ_PIN_LEVEL_UP_13DB		0x03
#define PS8811_BEQ_PIN_LEVEL_UP_16DB		0x04
#define PS8811_BEQ_PIN_LEVEL_UP_17DB		0x05
#define PS8811_BEQ_PIN_LEVEL_UP_18DB		0x06
#define PS8811_BEQ_PIN_LEVEL_UP_19DB		0x07
#define PS8811_BEQ_PIN_LEVEL_UP_20DB		0x08
#define PS8811_BEQ_PIN_LEVEL_UP_21DB		0x09
#define PS8811_BEQ_PIN_LEVEL_UP_23DB		0x0A
#define PS8811_BEQ_I2C_LEVEL_UP_9DB		0x00
#define PS8811_BEQ_I2C_LEVEL_UP_10_5DB		0x10
#define PS8811_BEQ_I2C_LEVEL_UP_12DB		0x20
#define PS8811_BEQ_I2C_LEVEL_UP_13DB		0x30
#define PS8811_BEQ_I2C_LEVEL_UP_16DB		0x40
#define PS8811_BEQ_I2C_LEVEL_UP_17DB		0x50
#define PS8811_BEQ_I2C_LEVEL_UP_18DB		0x60
#define PS8811_BEQ_I2C_LEVEL_UP_19DB		0x70
#define PS8811_BEQ_I2C_LEVEL_UP_20DB		0x80
#define PS8811_BEQ_I2C_LEVEL_UP_21DB		0x90
#define PS8811_BEQ_I2C_LEVEL_UP_23DB		0xA0

#define PS8811_REG1_USB_BEQ_CONFIG	0x06
#define PS8811_BEQ_CONFIG_REG_ENABLE		BIT(0)


#endif /* __CROS_EC_USB_RETIMER_PS8802_H */
