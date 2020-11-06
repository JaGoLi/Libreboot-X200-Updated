/* SPDX-License-Identifier: GPL-2.0-only */

#ifndef _EC_HP_KBC1126_EC_H
#define _EC_HP_KBC1126_EC_H

#define KBC1100_PM1              1            /* PM1 */
#define SMSCSUPERIO_SP1          4            /* Com1 */
#define SMSCSUPERIO_SP2          5            /* Com2 */
#define KBC1100_KBC              7            /* Keyboard */
#define KBC1100_EC0              8            /* EC Channel 0 */
#define KBC1100_MAILBOX          9            /* Mail Box */
#define KBC1100_GPIO             0x0A         /* GPIO */
#define KBC1100_SPI              0x0B         /* Share flash interface */

#define KBC1100_EC1              0x0D         /* EC Channel 1 */
#define KBC1100_EC2              0x0E         /* EC Channel 2 */

/* early init */
void kbc1126_enter_conf(void);
void kbc1126_exit_conf(void);
void kbc1126_mailbox_init(void);
void kbc1126_kbc_init(void);
void kbc1126_ec_init(void);
void kbc1126_com1_init(void);
void kbc1126_pm1_init(void);
void kbc1126_disable4e(void);

#endif /* _EC_HP_KBC1126_EC_H */
