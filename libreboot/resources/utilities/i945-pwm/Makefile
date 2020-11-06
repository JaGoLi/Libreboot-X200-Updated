CFLAGS ?= -O2 -Wall -W -ggdb

i945-pwm: i945-pwm.c
	$(CC) -std=gnu99 $(CFLAGS) $(LDFLAGS) -o $@ $< -lpci -lz
	
clean:
	rm -f i945-pwm
