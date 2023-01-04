; Loaded in by the MBR from the
; disk. This will be placed in
; memory AFTER the master boot
; record.
[BITS 16]
%include "macdef.inc"
%include "vdef.inc"
%include "font.inc"
%include "../config.inc"
%define TITLE_COLOR 34 ; Purple
%define TITLE_TOP_PADDING 4
%define DISK_LISTING_TEXT_COLOR 15
%define DISK_LISTING_SELECTED_COLOR 9
%define DISK_LISTING_TOP_PADDING 25
global bootable_partition.drivenum
extern printf
extern graphics13h_init
extern graphics13h_printf
extern set_fs_driver_ptrs

SECTION .bootloader
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
    mov si, 0 ; Flag if selected has been set yet
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
            ; Create bootable_partition struc
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

    ; Render the title
    %strcat .title_text_m "CoreMan bootloader v", VERSION
    strlit .title_text, .title_text_m
    mov dl, TITLE_COLOR
    mov dh, 248
    mov bx, (V_WIDTH / 2) - (.title_text_len * FONT_WIDTH) / 2 ; Centered
    mov cx, TITLE_TOP_PADDING
    mov si, .title_text
    push di
    call graphics13h_printf
    pop di

    call render_disk_listing

    .input_loop:
        xor ax, ax
        int 0x16

        cmp ah, 0x48 ; Up arrow
        je .process_up_arrow
        cmp ah, 0x50 ; Down arrow
        je .process_down_arrow
        cmp ah, 0x1C ; Enter
        je .process_enter
        jmp .input_loop_continue

        .process_up_arrow:
            cmp [selected_drive], WORD 0
            je .input_loop_continue
            dec WORD [selected_drive]
            jmp .input_loop_continue

        .process_down_arrow:
            push ax
            mov ax, [selected_drive]
            inc ax
            cmp ax, di
            pop ax
            jae .input_loop_continue
            inc WORD [selected_drive]
            jmp .input_loop_continue

        .process_enter:
            mov bp, sp
            mov cx, bootable_partition_size
            mov ax, [selected_drive]
            mul cx
            add bp, ax
            call set_fs_driver_ptrs

        .input_loop_continue:
        call render_disk_listing
        jmp .input_loop


    ; TODO Select a bootable partition
    ;   Identify its fs
    ;   Set appropriate driver pointers
    ;   Run it

    hlt

SECTION .bootloader_code
    ; Slightly scuffed but it needed to happen
    ; FIXME clean up
    render_disk_listing:
        mov bp, sp
        add bp, 2 ; Return address
        strlit disk_list_str, "Drive num: 0o%o"
        mov si, disk_list_str
        mov dl, DISK_LISTING_TEXT_COLOR
        mov cx, DISK_LISTING_TOP_PADDING
        mov bx, 0 ; bx does not move so it can be a counter
        .disk_list_loop:
            push di
            push si
            push bx
            push cx
    
            cmp bx, [selected_drive]
            je .set_selected
    
            mov dh, 0 ; Overwrite previous
            jmp .disk_list_loop_continue
    
            .set_selected:
                mov dh, DISK_LISTING_SELECTED_COLOR
    
            .disk_list_loop_continue:
            mov bx, (V_WIDTH / 2) - ((disk_list_str_len + 3) * FONT_WIDTH) / 2 ; + 3 because an octal takes up 5 in length
            mov ax, [bp + bootable_partition.drivenum]
            sub ax, 0x80
            push ax
            call graphics13h_printf
    
            pop cx
            pop bx
            pop si
            pop di
    
            add cx, FONT_HEIGHT
            add bp, bootable_partition_size
            inc bx
            cmp bx, di
            jb .disk_list_loop
        ret

SECTION .bootloader_data

SECTION .bootloader_bss
    selected_drive: resw 1
    struc bootable_partition
        .drivenum: resw 1
        .num_sectors: resd 1
        .lba: resd 1
    endstruc
    sector_buf: resb 512
    num_drives: resb 1