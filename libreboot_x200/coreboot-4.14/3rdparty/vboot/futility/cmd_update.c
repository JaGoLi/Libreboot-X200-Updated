/* Copyright 2018 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * The command line tool to invoke firmware updater.
 */

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>

#include "futility.h"
#include "updater.h"

enum {
	OPT_DUMMY = 0x100,

	OPT_CCD,
	OPT_EMULATE,
	OPT_FACTORY,
	OPT_FAST,
	OPT_FORCE,
	OPT_GBB_FLAGS,
	OPT_HOST_ONLY,
	OPT_MANIFEST,
	OPT_MODEL,
	OPT_OUTPUT_DIR,
	OPT_PD_IMAGE,
	OPT_QUIRKS,
	OPT_QUIRKS_LIST,
	OPT_REPACK,
	OPT_SERVO,
	OPT_SERVO_NORESET,
	OPT_SERVO_PORT,
	OPT_SIGNATURE,
	OPT_SYS_PROPS,
	OPT_UNPACK,
	OPT_WRITE_PROTECTION,
};

/* Command line options */
static struct option const long_opts[] = {
	/* name  has_arg *flag val */
	{"help", 0, NULL, 'h'},
	{"debug", 0, NULL, 'd'},
	{"verbose", 0, NULL, 'v'},

	{"image", 1, NULL, 'i'},
	{"ec_image", 1, NULL, 'e'},
	{"try", 0, NULL, 't'},
	{"archive", 1, NULL, 'a'},
	{"programmer", 1, NULL, 'p'},
	{"mode", 1, NULL, 'm'},

	{"ccd", 0, NULL, OPT_CCD},
	{"servo", 0, NULL, OPT_SERVO},
	{"servo_noreset", 0, NULL, OPT_SERVO_NORESET},
	{"servo_port", 1, NULL, OPT_SERVO_PORT},
	{"emulate", 1, NULL, OPT_EMULATE},
	{"factory", 0, NULL, OPT_FACTORY},
	{"fast", 0, NULL, OPT_FAST},
	{"force", 0, NULL, OPT_FORCE},
	{"gbb_flags", 1, NULL, OPT_GBB_FLAGS},
	{"host_only", 0, NULL, OPT_HOST_ONLY},
	{"list-quirks", 0, NULL, OPT_QUIRKS_LIST},
	{"manifest", 0, NULL, OPT_MANIFEST},
	{"model", 1, NULL, OPT_MODEL},
	{"output_dir", 1, NULL, OPT_OUTPUT_DIR},
	{"pd_image", 1, NULL, OPT_PD_IMAGE},
	{"quirks", 1, NULL, OPT_QUIRKS},
	{"repack", 1, NULL, OPT_REPACK},
	{"signature_id", 1, NULL, OPT_SIGNATURE},
	{"sys_props", 1, NULL, OPT_SYS_PROPS},
	{"unpack", 1, NULL, OPT_UNPACK},
	{"wp", 1, NULL, OPT_WRITE_PROTECTION},

	/* TODO(hungte) Remove following deprecated options. */
	{"noupdate_ec", 0, NULL, OPT_HOST_ONLY},
	{"noupdate_pd", 0, NULL, OPT_HOST_ONLY},
	{"nocheck_keys", 0, NULL, OPT_FORCE},
	{"update_main", 0, NULL, OPT_DUMMY},
	{"update_ec", 0, NULL, OPT_DUMMY},
	{"update_pd", 0, NULL, OPT_DUMMY},
	{"check_keys", 0, NULL, OPT_DUMMY},

	{NULL, 0, NULL, 0},
};

static const char * const short_opts = "hdvi:e:ta:m:p:";

static void print_help(int argc, char *argv[])
{
	printf("\n"
		"Usage:  " MYNAME " %s [OPTIONS]\n"
		"\n"
		"Updates firmware in one of the following modes (default to recovery):\n"
		"  autoupdate:\tUpdate RW[A|B], or recovery if RO changed.\n"
		"  recovery:  \tUpdate RW[A&B], (RO, RO:GBB[keys] - if RO changed)\n"
		"  factory:   \tUpdate RW[A&B],  RO, RO:GBB[keys,flags]\n"
		"\n"
		"Note: firmware sections with PRESERVE flags like VPD and\n"
		"      HWID in GBB are always preserved.\n"
		"      GBB flags are preserved in autoupdate and recovery modes.\n"
		"\n"
		"OPTIONS:\n"
		"\n"
		"-i, --image=FILE    \tAP (host) firmware image (image.bin)\n"
		"-e, --ec_image=FILE \tEC firmware image (i.e, ec.bin)\n"
		"    --pd_image=FILE \tPD firmware image (i.e, pd.bin)\n"
		"-t, --try           \tTry A/B update on reboot if possible\n"
		"-a, --archive=PATH  \tRead resources from archive\n"
		"    --manifest      \tPrint out a JSON manifest and exit\n"
		"    --repack=DIR    \tUpdates archive from DIR\n"
		"    --unpack=DIR    \tExtracts archive to DIR\n"
		"-p, --programmer=PRG\tChange AP (host) flashrom programmer\n"
		"    --fast          \tReduce read cycles and do not verify\n"
		"    --quirks=LIST   \tSpecify the quirks to apply\n"
		"    --list-quirks   \tPrint all available quirks\n"
		"-m, --mode=MODE     \tRun updater in specified mode\n"
		"\n"
		"Legacy and compatibility options:\n"
		"    --factory       \tAlias for --mode=factory\n"
		"    --force         \tForce update (skip checking contents)\n"
		"    --output_dir=DIR\tSpecify the target for --mode=output\n"
		"\n"
		"Debugging and testing options:\n"
		"    --wp=1|0        \tSpecify write protection status\n"
		"    --host_only     \tUpdate only AP (host) firmware\n"
		"    --emulate=FILE  \tEmulate system firmware using file\n"
		"    --model=MODEL   \tOverride system model for images\n"
		"    --gbb_flags=FLAG\tOverride new GBB flags\n"
		"    --ccd           \tDo fast,force,wp=0,p=raiden_debug_spi\n"
		"    --servo         \tFlash using Servo (v2, v4, micro, ...)\n"
		"    --servo_noreset \tLike servo but with 'custom_rst=true'\n"
		"    --servo_port=PRT\tOverride servod port, implies --servo\n"
		"    --signature_id=S\tOverride signature ID for key files\n"
		"    --sys_props=LIST\tList of system properties to override\n"
		"-d, --debug         \tPrint debugging messages\n"
		"-v, --verbose       \tPrint verbose messages\n"
		"",
		argv[0]);
}

static char *add_servo_noreset(char *programmer)
{
	char *ret;

	if (strstr(programmer, "raiden_debug_spi:target=AP") == NULL) {
		ERROR("servo_noreset only works for AP flashing over CCD.\n");
		free(programmer);

		return NULL;
	}

	ASPRINTF(&ret, "%s,custom_rst=true", programmer);
	free(programmer);

	return ret;
}

static int do_update(int argc, char *argv[])
{
	struct updater_config *cfg;
	struct updater_config_arguments args = {0};
	int i, errorcnt = 0, do_update = 1;
	int detect_servo = 0, do_servo_cpu_fw_spi = 0, servo_noreset = 0;
	char *servo_programmer = NULL;
	char *endptr;

	cfg = updater_new_config();
	assert(cfg);

	opterr = 0;
	while ((i = getopt_long(argc, argv, short_opts, long_opts, 0)) != -1) {
		switch (i) {
		case 'h':
			print_help(argc, argv);
			updater_delete_config(cfg);
			return !!errorcnt;
		case 'd':
			debugging_enabled = 1;
			args.verbosity++;
			break;
		case 'v':
			args.verbosity++;
			break;
		case 'i':
			args.image = optarg;
			break;
		case 'e':
			args.ec_image = optarg;
			break;
		case 't':
			args.try_update = 1;
			break;
		case 'a':
			args.archive = optarg;
			break;
		case 'm':
			args.mode = optarg;
			break;
		case 'p':
			args.programmer = optarg;
			break;

		case OPT_PD_IMAGE:
			args.pd_image = optarg;
			break;
		case OPT_REPACK:
			args.repack = optarg;
			break;
		case OPT_UNPACK:
			args.unpack = optarg;
			break;
		case OPT_QUIRKS:
			args.quirks = optarg;
			break;
		case OPT_QUIRKS_LIST:
			updater_list_config_quirks(cfg);
			updater_delete_config(cfg);
			return 0;
		case OPT_OUTPUT_DIR:
			args.output_dir = optarg;
			break;
		case OPT_MODEL:
			args.model = optarg;
			break;
		case OPT_SIGNATURE:
			args.signature_id = optarg;
			break;
		case OPT_WRITE_PROTECTION:
			args.write_protection = optarg;
			break;
		case OPT_EMULATE:
			args.emulation = optarg;
			break;
		case OPT_SYS_PROPS:
			args.sys_props = optarg;
			break;
		case OPT_MANIFEST:
			args.do_manifest = 1;
			break;
		case OPT_FACTORY:
			args.is_factory = 1;
			break;
		case OPT_HOST_ONLY:
			args.host_only = 1;
			break;
		case OPT_FORCE:
			args.force_update = 1;
			break;
		case OPT_FAST:
			args.fast_update = 1;
			break;
		case OPT_GBB_FLAGS:
			args.gbb_flags = strtoul(optarg, &endptr, 0);
			if (*endptr) {
				ERROR("Invalid flags: %s\n", optarg);
				errorcnt++;
			} else {
				args.override_gbb_flags = 1;
			}
			break;
		case OPT_CCD:
			args.fast_update = 1;
			args.force_update = 1;
			args.write_protection = "0";
			args.programmer = "raiden_debug_spi:target=AP";
			break;
		case OPT_SERVO:
			args.fast_update = 1;
			args.force_update = 1;
			args.write_protection = "0";
			args.host_only = 1;
			detect_servo = 1;
			break;
		case OPT_SERVO_NORESET:
			args.fast_update = 1;
			args.force_update = 1;
			args.write_protection = "0";
			args.host_only = 1;
			detect_servo = 1;
			servo_noreset = 1;
			break;
		case OPT_SERVO_PORT:
			setenv(ENV_SERVOD_PORT, optarg, 1);
			args.fast_update = 1;
			args.force_update = 1;
			args.write_protection = "0";
			args.host_only = 1;
			detect_servo = 1;
			break;

		case OPT_DUMMY:
			break;

		case '?':
			errorcnt++;
			if (optopt)
				ERROR("Unrecognized option: -%c\n", optopt);
			else if (argv[optind - 1])
				ERROR("Unrecognized option (possibly '%s')\n",
				      argv[optind - 1]);
			else
				ERROR("Unrecognized option.\n");
			break;
		default:
			errorcnt++;
			ERROR("Failed parsing options.\n");
		}
	}
	if (optind < argc) {
		errorcnt++;
		ERROR("Unexpected arguments.\n");
	}

	if (!errorcnt && detect_servo) {
		servo_programmer = host_detect_servo(&do_servo_cpu_fw_spi);

		if (servo_programmer && servo_noreset)
			servo_programmer = add_servo_noreset(servo_programmer);

		if (!servo_programmer)
			errorcnt++;
		else if (!args.programmer)
			args.programmer = servo_programmer;
	}
	/*
	 * Some boards may need to fetch firmware before starting to
	 * update (i.e., in updater_setup_config) so we want to turn on
	 * cpu_fw_spi mode now.
	 */
	if (do_servo_cpu_fw_spi)
		free(host_shell("dut-control cpu_fw_spi:on"));

	if (!errorcnt)
		errorcnt += updater_setup_config(cfg, &args, &do_update);
	if (!errorcnt && do_update) {
		int r;
		STATUS("Starting firmware updater.\n");
		r = update_firmware(cfg);
		if (r != UPDATE_ERR_DONE) {
			r = VB2_MIN(r, UPDATE_ERR_UNKNOWN);
			ERROR("%s\n", updater_error_messages[r]);
			errorcnt++;
		}
		/* Use stdout for the final result. */
		printf(">> %s: Firmware updater %s.\n",
			errorcnt ? "FAILED": "DONE",
			errorcnt ? "aborted" : "exits successfully");
	}

	if (do_servo_cpu_fw_spi)
		free(host_shell("dut-control cpu_fw_spi:off"));
	free(servo_programmer);

	updater_delete_config(cfg);
	return !!errorcnt;
}

DECLARE_FUTIL_COMMAND(update, do_update, VBOOT_VERSION_ALL,
		      "Update system firmware");
