; Loaded in by the MBR from the
; disk. This will be placed in
; memory AFTER the master boot
; record.

[BITS 16]
%include "macdef.inc"
extern boot_disk
extern printf

section .bootloader
    ; Store number of drives
    mov ax, 0x40
    mov es, ax
    mov al, [es:0x75] ; [0x40:0x75] is the number of drives supported by 0x13 interrupt
    mov [num_drives], al
    xor ax, ax
    mov es, ax

    movzx ax, BYTE [num_drives]
    push ax
    strlitnl .printf_detected_drives, "Detected 0o%o drive(s)."
    mov si, .printf_detected_drives
    call printf

    mov di, 0 ; Will store # of bootable partitions
    mov dl, 0x80 - 1
    add dl, [num_drives] ; starts at 1
    .sector_loop:
        ; Read the 1st sector from memory
        mov ah, 0x02
        mov al, 1
        mov ch, 0
        mov cl, 1
        mov dh, 0
        ; dl already set
        mov bx, sector_buffer
        int 0x13

        mov ax, 0x01BE ; 
        .partition_loop:
            push di
            mov di, ax
            add di, sector_buffer
            mov bl, [di]
            pop di
            cmp bl, 0x80 ; Bootable partition
            jne .skip_processing

            ; Store the drive and partition position
            mov dh, 0
            push dx
            push ax
            inc di
            jmp .partition_loop_break

            .skip_processing:
            add ax, 16
            cmp ax, 0x01EE
            jle .partition_loop
        .partition_loop_break:

        dec dl
        cmp dl, 0x80
        jg .sector_loop

    push di
    strlitnl .printf_bootable_drives, "Found 0o%o bootable partitions(s)."
    mov si, .printf_bootable_drives
    call printf

    hlt

section .bootloader_data

section .bootloader_bss
    sector_buffer: resb 512
    num_drives: resb 1