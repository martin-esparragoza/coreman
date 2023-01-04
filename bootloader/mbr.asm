; Goal of the master boot record
; is to leave as soon as possible.
; The MBR will simply just clear
; registers and store nessicary
; information and after that it
; will do its best to jump to the
; bootloader. This file disables
; the running of interrupts. It's
; expected that the size of this
; file will not exceed 1 sector.
[BITS 16]
%macro strlit 2
[section .mbr_data]
    %1: db %2, 0
__SECT__
%endmacro
global printf
extern bootloader_sectors
extern bootloader_s

SECTION .mbr
    cli
    ; Clear registers
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov bp, ax
    mov sp, 0x7C00

    ; Drive we booted from is stored in dl register
    mov [boot_disk], dl

    ; Check if bios has LBA support
    mov ah, 0x41
    mov bx, 0x55AA
    mov dl, [boot_disk]
    int 0x13
    jnc .lba_extensions_installed

    push WORD __LINE__
    push WORD file_name
    strlit .err_no_lba, "error[%s:0o%o]: your BIOS does not have the LBA extensions installed."
    mov si, .err_no_lba
    call printf
    hlt

    .lba_extensions_installed:
    mov ah, 0x42
    mov dl, [boot_disk]
    mov si, lba_read_packet
    int 0x13
    jnc bootloader_s

    push WORD __LINE__
    push WORD file_name
    strlit .err_no_bootloder, "error[%s:0o%o]: could not load in the bootloader from disk."
    mov si, .err_no_bootloder
    call printf
    hlt

SECTION .mbr_code
    ; in
    ;   si: fstring
    ;   print arguments BACKWARDS on the stack
    ; out
    ;   CF: set on error
    ; clobbers
    ;   ax
    ;   si
    ;   di
    ;   dx
    ; how to use
    ;   fstring:
    ;       %o: 16 bit octal
    ;       %s: 16 bit address to start of string
    printf:
        push bp
        mov bp, sp

        ; 16 bit address
        mov di, 2
        mov ah, 0x0E
        .printf_loop:
            mov al, [si]

            ; We don't want to print a 0 character so we check it up front
            cmp al, 0
            je .printf_break

            cmp al, '%'
            jne .printf_continue
            ; Process a token
            ; We are not using a jump table here because we are limited to 512 total bytes
            ; al can be clobbered anyway because we dont want to print the % or the token after it
            mov al, [si + 1]

            ; Odd case where someone puts a % at the end of the string and it skips the 0 character
            cmp al, 0
            je .printf_break

            ; printf_continue is not going to run so we need to increment it ourselves
            ; Increment it by 2 so we can skip printing the token and the %
            add si, 2
            cmp al, 'o'
            je .printf_octal
            cmp al, 's'
            je .printf_string

            ; Error: No recognized token
            stc
            jmp .printf_break

            .printf_octal:
                add di, 2 ; 16 bits
                mov dx, [bp + di] ; Get our 16 bit integer that we want to print
                ror dx, 15 ; Reverse them (we need to go get the high order bits first)
                push cx
                mov cx, 5

                .printf_octal_loop:
                    mov al, dh
                    and al, 11100000b ; Get the high order bits
                    shr al, 5 ; Translate them down
                    add al, '0' ; To characters
                    int 0x10
                    shl dx, 3
                    dec cx
                    jnz .printf_octal_loop

                pop cx

                jmp .printf_loop

            .printf_string:
                add di, 2
                push si
                mov si, [bp + di]
                mov al, [si]
                .printf_string_loop:
                    int 0x10
                    inc si
                    mov al, [si]
                    cmp al, 0
                    ja .printf_string_loop
                pop si
                jmp .printf_loop

            .printf_continue:

            int 0x10
            inc si
            jmp .printf_loop
        .printf_break:
            pop bp
            pop ax ; Return address
            sub di, 2 ; We have removed the return address
            add sp, di
            jmp ax

section .mbr_bss
    boot_disk: resb 1
    struc t
        .a: resb 1
    endstruc
    struc lba_ext_read_packet
        .len: resb 1
        resb 1 ; Reserved. 0
        .num_sectors: resw 1
        .buf: resw 1 ; Transfer buffer (offset)
        .segment resw 1 ; Segment of transfer buffer
        .start_sector: resq 1
    endstruc


SECTION .mbr_data
    file_name: db __FILE__, 0
    lba_read_packet:
        istruc lba_ext_read_packet
            at lba_ext_read_packet.len, db lba_ext_read_packet_size
            db 0
            at lba_ext_read_packet.num_sectors, dw bootloader_sectors
            at lba_ext_read_packet.buf, dw bootloader_s
            at lba_ext_read_packet.segment, dw 0
            at lba_ext_read_packet.start_sector, dq 1 ; MBR counts as 1 buffer
        iend

SECTION .mbr_header
    db 0x55, 0xAA