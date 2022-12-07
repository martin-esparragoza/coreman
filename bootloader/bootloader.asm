; Loaded in by the MBR from the
; disk. This will be placed in
; memory AFTER the master boot
; record (0x7C00 + 512).

extern boot_disk

section .bootloader
    db "BOOTLOADER"
    mov ah, 0x0E
    mov al, 'B'
    int 0x10
    jmp $