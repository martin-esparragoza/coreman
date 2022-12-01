ASM = nasm
ASMFLAGS = -f elf$(shell getconf LONG_BIT) -w-other

LINK = ld
LINKFLAGS = --oformat=binary

MAKEDIRS = $(wildcard */.)
MAKEINCLUDE = rules.mk
export

.PHONY: all clean $(MAKEDIRS)

all: $(MAKEDIRS)

clean: $(MAKEDIRS)
	rm -rf $(OUT)
	rm -rf *.o

$(MAKEDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)