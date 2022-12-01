# Object file needs to be made
%.o: %.asm
	$(ASM) $(ASMFLAGS) $< -o $@

# Linker needs to generate a binary
.SECONDEXPANSION:
%.bin: linker.ld $$(shell find . -maxdepth 1 -name "*.o") # Can't use a wildcard, it has to be at runtime.
	$(LINK) $(LINKFLAGS) -T linker.ld -o $@ $(filter-out linker.ld,$^)