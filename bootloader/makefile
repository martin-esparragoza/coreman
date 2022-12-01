include ../$(MAKEINCLUDE)

.PHONY: all clean

all: bootloader.bin

bootloader.bin: $(patsubst %.asm,%.o,$(wildcard *.asm)) 

clean:
	rm -rf *.o
	rm -rf *.bin