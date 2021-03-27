/* Copyright 2013 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */

/* Various utility for unit testing */

#ifndef __CROS_EC_TEST_UTIL_H
#define __CROS_EC_TEST_UTIL_H

#ifdef CONFIG_ZTEST

#include <ztest.h>

/*
 * We need these macros so that a test can be built for either Ztest or the
 * EC test framework.
 *
 * Ztest unit tests are void and do not return a value. In the EC framework,
 * if none of the assertions fail, the test is supposed to return EC_SUCCESS,
 * so just define that as empty and `return EC_SUCCESS;` will get pre-processed
 * into `return ;`
 */
#define EC_TEST_RETURN void
#define EC_SUCCESS

#else /* CONFIG_ZTEST */

#include "common.h"
#include "console.h"
#include "stack_trace.h"

/* This allows tests to be easily commented out in run_test for debugging */
#define test_static static __attribute__((unused))

#define RUN_TEST(n) \
	do { \
		ccprintf("Running %s...\n", #n); \
		cflush(); \
		before_test(); \
		if (n() == EC_SUCCESS) { \
			ccputs("OK\n"); \
		} else { \
			ccputs("Fail\n"); \
			__test_error_count++; \
		} \
		after_test(); \
	} while (0)

#define TEST_ASSERT(n) \
	do { \
		if (!(n)) { \
			ccprintf("%d: ASSERTION failed: %s\n", __LINE__, #n); \
			task_dump_trace(); \
			return EC_ERROR_UNKNOWN; \
		} \
	} while (0)

#if defined(__cplusplus) && !defined(__auto_type)
#define __auto_type auto
#endif

#define TEST_OPERATOR(a, b, op, fmt) \
	do { \
		__auto_type _a = (a);                                       \
		__auto_type _b = (b);                                       \
		if (!(_a op _b)) {                                          \
			ccprintf("%d: ASSERTION failed: %s " #op " %s\n",   \
				 __LINE__, #a, #b);                         \
			ccprintf("\t\tEVAL: " fmt " " #op " " fmt "\n",     \
				 _a, _b);                                   \
			task_dump_trace();                                  \
			return EC_ERROR_UNKNOWN;                            \
		} else  {                                                   \
			ccprintf("Pass: %s " #op " %s\n", #a, #b);        \
		}                                                           \
	} while (0)

#define TEST_EQ(a, b, fmt) TEST_OPERATOR(a, b, ==, fmt)
#define TEST_NE(a, b, fmt) TEST_OPERATOR(a, b, !=, fmt)
#define TEST_LT(a, b, fmt) TEST_OPERATOR(a, b, <, fmt)
#define TEST_LE(a, b, fmt) TEST_OPERATOR(a, b, <=, fmt)
#define TEST_GT(a, b, fmt) TEST_OPERATOR(a, b, >, fmt)
#define TEST_GE(a, b, fmt) TEST_OPERATOR(a, b, >=, fmt)
#define TEST_BITS_SET(a, bits) TEST_OPERATOR(a & (int)bits, (int)bits, ==, "%u")
#define TEST_BITS_CLEARED(a, bits) TEST_OPERATOR(a & (int)bits, 0, ==, "%u")
#define TEST_NEAR(a, b, epsilon, fmt) \
	TEST_OPERATOR(ABS((a) - (b)), epsilon, <, fmt)

#define __ABS(n) ((n) > 0 ? (n) : -(n))

#define TEST_ASSERT_ABS_LESS(n, t) TEST_OPERATOR(__ABS(n), t, <, "%d")

#define TEST_ASSERT_ARRAY_EQ(s, d, n) \
	do { \
		int __i; \
		for (__i = 0; __i < n; ++__i) \
			if ((s)[__i] != (d)[__i]) { \
				ccprintf("%d: ASSERT_ARRAY_EQ failed at " \
					 "index=%d: %d != %d\n", __LINE__, \
					 __i, (int)(s)[__i], (int)(d)[__i]); \
				task_dump_trace(); \
				return EC_ERROR_UNKNOWN; \
			} \
	} while (0)

#define TEST_ASSERT_MEMSET(d, c, n) \
	do { \
		int __i; \
		for (__i = 0; __i < n; ++__i) \
			if ((d)[__i] != (c)) { \
				ccprintf("%d: ASSERT_MEMSET failed at " \
					 "index=%d: %d != %d\n", __LINE__, \
					 __i, (int)(d)[__i], (c)); \
				task_dump_trace(); \
				return EC_ERROR_UNKNOWN; \
			} \
	} while (0)

#define TEST_CHECK(n) \
	do { \
		if (n) \
			return EC_SUCCESS; \
		else \
			return EC_ERROR_UNKNOWN; \
	} while (0)

/* Mutlistep test states */
enum test_state_t {
	TEST_STATE_STEP_1 = 0,
	TEST_STATE_STEP_2,
	TEST_STATE_STEP_3,
	TEST_STATE_STEP_4,
	TEST_STATE_STEP_5,
	TEST_STATE_STEP_6,
	TEST_STATE_STEP_7,
	TEST_STATE_STEP_8,
	TEST_STATE_STEP_9,
	TEST_STATE_PASSED,
	TEST_STATE_FAILED,
};
#define TEST_STATE_MASK(x) (1 << (x))

/* Hooks gcov_flush() for test coverage report generation */
void register_test_end_hook(void);

/*
 * Test initialization. This is called after all _pre_init() calls and before
 * all _init() calls.
 */
void test_init(void);

/** Called before each test. Used for initialization. */
void before_test(void);

/** Called after each test. Used to clean up. */
void after_test(void);

/* Test entry point */
void run_test(int argc, char **argv);

/* Test entry point for fuzzing tests. */
int test_fuzz_one_input(const uint8_t *data, unsigned int size);

/* Resets test error count */
void test_reset(void);

/* Reports test pass */
void test_pass(void);

/* Reports test failure */
void test_fail(void);

/* Prints test result, including number of failed tests */
void test_print_result(void);

/* Returns the number of failed tests */
int test_get_error_count(void);

/* Simulates host command sent from the host */
int test_send_host_command(int command, int version, const void *params,
			   int params_size, void *resp, int resp_size);

/* Optionally defined interrupt generator entry point */
void interrupt_generator(void);

/*
 * Trigger an interrupt. This function must only be called by interrupt
 * generator.
 */
void task_trigger_test_interrupt(void (*isr)(void));

/*
 * Special implementation of udelay() for interrupt generator. Calls
 * to udelay() from interrupt generator are delegated to this function
 * automatically.
 */
void interrupt_generator_udelay(unsigned us);

#ifdef EMU_BUILD
void wait_for_task_started(void);
void wait_for_task_started_nosleep(void);
#else
static inline void wait_for_task_started(void) { }
static inline void wait_for_task_started_nosleep(void) { }
#endif

uint32_t prng(uint32_t seed);

uint32_t prng_no_seed(void);

/* Number of failed tests */
extern int __test_error_count;

/* Simulates UART input */
void uart_inject_char(char *s, int sz);

#define UART_INJECT(s) uart_inject_char(s, strlen(s));

/* Simulates chipset power on */
void test_chipset_on(void);

/* Simulates chipset power off */
void test_chipset_off(void);

/* Start/stop capturing console output */
void test_capture_console(int enabled);

/* Get captured console output */
const char *test_get_captured_console(void);

/*
 * Flush emulator status. Must be called before emulator reboots or
 * exits.
 */
void emulator_flush(void);

/*
 * Entry point of multi-step test.
 *
 * Depending on current test state, this function runs the corresponding
 * test step. This function should be called in a dedicated task on every
 * reboot. Also, run_test() is responsible for starting the test by kicking
 * that task.
 */
void test_run_multistep(void);

/*
 * A function that runs the test step specified in 'state'. This function
 * should be defined by all multi-step tests.
 *
 * @param state     TEST_STATE_MASK(x) indicating the step to run.
 */
void test_run_step(uint32_t state);

/* Get the current test state */
uint32_t test_get_state(void);

/*
 * Multistep test clean up. If a multi-step test has this function defined,
 * it will be called on test end. (i.e. when test passes or fails.)
 */
void test_clean_up(void);

/* Set the next step and reboot */
void test_reboot_to_next_step(enum test_state_t step);

struct test_i2c_read_string_dev {
	/* I2C string read handler */
	int (*routine)(const int port, const uint16_t i2c_addr_flags,
		       int offset, uint8_t *data, int len);
};

struct test_i2c_xfer {
	/* I2C xfer handler */
	int (*routine)(const int port, const uint16_t i2c_addr_flags,
		       const uint8_t *out, int out_size,
		       uint8_t *in, int in_size, int flags);
};

struct test_i2c_write_dev {
	/* I2C write handler */
	int (*routine)(const int port, const uint16_t i2c_addr_flags,
		       int offset, int data);
};

/**
 * Register an I2C 8-bit read function.
 *
 * When this function is called, it should either perform the desired
 * mock functionality, or return EC_ERROR_INVAL to indicate it does
 * not respond to the specified port and peripheral address.
 *
 * @param routine     Function pointer, with the same prototype as i2c_xfer()
 */
#define DECLARE_TEST_I2C_XFER(routine)					\
	const struct test_i2c_xfer __no_sanitize_address		\
	__test_i2c_xfer_##routine					\
	__attribute__((section(".rodata.test_i2c.xfer")))		\
		= {routine}

/*
 * Detach an I2C device. Once detached, any read/write command regarding the
 * specified port and peripheral address returns error.
 *
 * @param port       The port that the detached device is connected to
 * @param addr_flags The address of the detached device
 * @return EC_SUCCESS if detached; EC_ERROR_OVERFLOW if too many devices are
 *         detached.
 */
int test_detach_i2c(const int port, const uint16_t addr_flags);

/*
 * Re-attach an I2C device.
 *
 * @param port       The port that the detached device is connected to
 * @param addr_flags The address of the detached device
 * @return EC_SUCCESS if re-attached; EC_ERROR_INVAL if the specified device
 *         is not a detached device.
 */
int test_attach_i2c(const int port, const uint16_t addr_flags);

/*
 * We need these macros so that a test can be built for either Ztest or the
 * EC test framework.
 *
 * EC unit tests return an EC_SUCCESS, or a failure code if one of the
 * asserts in the test fails.
 */
#define EC_TEST_RETURN int

/*
 * Map the Ztest assertions onto EC assertions. There are two significant
 * issues here.
 * 1. zassert macros have extra printf-style arguments that the EC macros
 * don't support, so we just have to drop that.
 * 2. Some EC macros have an extra `fmt` parameter because they make their
 * own printf-style string when the assertion fails. For some of them, we
 * can add the correct format (the zassert_equal_ptr), but others we just
 * don't know, so I'll just dump out the value in hex.
 */
#define zassert(cond, msg, ...) TEST_ASSERT(cond)
#define zassert_unreachable(msg, ...) TEST_ASSERT(0)
#define zassert_true(cond, msg, ...) TEST_ASSERT(cond)
#define zassert_false(cond, msg, ...) TEST_ASSERT(!(cond))
#define zassert_ok(cond, msg, ...) TEST_ASSERT(cond)
#define zassert_is_null(ptr, msg, ...) TEST_ASSERT((ptr) == NULL)
#define zassert_not_null(ptr, msg, ...) TEST_ASSERT((ptr) != NULL)
#define zassert_equal(a, b, msg, ...) TEST_EQ((a), (b), "0x%x")
#define zassert_not_equal(a, b, msg, ...) TEST_NE((a), (b), "0x%x")
#define zassert_equal_ptr(a, b, msg, ...) \
	TEST_EQ((void *)(a), (void *)(b), "0x%x")
#define zassert_within(a, b, d, msg, ...) TEST_NEAR((a), (b), (d), "0x%x")
#define zassert_mem_equal(buf, exp, size, msg, ...) \
	TEST_ASSERT_ARRAY_EQ(buf, exp, size)

#endif /* CONFIG_ZTEST */

#endif /* __CROS_EC_TEST_UTIL_H */
