; Loaded in by the MBR from the
; disk. This will be placed in
; memory AFTER the master boot
; record.
[BITS 16]
%include "macdef.inc"
%include "../config.inc"
extern printf
extern graphics13h_init
extern graphics13h_printf

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
        mov bx, sector_buf
        int 0x13

        mov ax, 0x01BE
        .partition_loop:
            push di
            mov di, ax
            add di, sector_buf
            mov bl, [di]
            pop di
            cmp bl, 0x80 ; Bootable partition
            jne .skip_processing

            ; Store the drive and partition position
            mov dh, 0
            ; Creeate bootable_partition struc
            push DWORD [sector_buf + 8] ; Starting LBA value
            push DWORD [sector_buf + 12] ; Number of sectors
            push dx ; Drive number
            inc di
            jmp .partition_loop_break

            .skip_processing:
            add ax, 16
            cmp ax, 0x01EE
            jbe .partition_loop
        .partition_loop_break:

        dec dl
        cmp dl, 0x80
        ja .sector_loop

    push di ; di is going to get clobbered
    push di
    strlitnl .printf_bootable_drives, "Found 0o%o bootable partition(s)."
    mov si, .printf_bootable_drives
    call printf
    pop di

    ; Our stack now contains di number of bootable_partition structures

    push bp
    push es
    call graphics13h_init
    pop es
    pop bp

    %strcat .title_text_m "CoreMan bootloader v", VERSION
    strlit .title_text, .title_text_m
    strlit .test_printf, "Octal: 0o%o. Str: %s"
    mov dl, 20
    mov dh, 7
    mov bx, 0
    mov cx, 0
    mov si, .title_text
    push di
    call graphics13h_printf
    pop di

    ; TODO Select a bootable partition
    ;   Identify its fs
    ;   Set appropriate driver pointers
    ;   Run it

    hlt

section .bootloader_data

section .bootloader_bss
    struc bootable_partition
        .drivenum: resw 1
        .num_sectors: resd 1
        .lba: resd 1
    endstruc
    sector_buf: resb 512
    num_drives: resb 1