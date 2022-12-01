; TODO https://retrocomputing.stackexchange.com/questions/16575/detecting-the-number-of-disk-drives-installed

[BITS 16]
section .mbr
    cli
    ; Clear registers
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00 - 1 ; Stack expands upwards

    ; Drive we booted from is stored in dl register
    mov [boot_disk], dl
    mov [num_drives], 50

    mov ah, 0x0E
    mov al, 'B'
    int 0x10

    jmp $

section .mbr_bss
    boot_disk: resb
    num_drives: resb

section .mbr_header
    db 0x55, 0xAA