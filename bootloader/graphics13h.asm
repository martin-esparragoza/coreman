; "Driver" for graphics mode 13h.
; Esentially its just a few
; utility functions.
[BITS 16]
%include "font.inc"
%define V_WIDTH 320
%define V_HEIGHT 200
%define V_SEG 0xA000
global graphics13h_init
global graphics13h_put_char
global graphics13h_printf
extern font

section .bootloader_code
    ; in
    ;   es
    ; out
    ; clobbers
    ;   ax
    ;   bh
    ;   es
    ;   ds
    ;   bp
    ;   cx
    ;   dl
    ;   di
    graphics13h_init:
        ; Change graphics mode
        mov ah, 0x00
        mov al, 0x13
        int 0x10
        ; TODO check if supported graphics mode

        ret

    ; in
    ;   al: char
    ;   dl: text color (248+ for transparent)
    ;   dh: background color
    ;   bx: x
    ;   cx: y
    ; out
    ; clobbers
    ;   ax
    ;   bx
    ;   cx
    ;   es
    graphics13h_put_char:
        push ax
        mov ax, V_SEG
        mov es, ax
        pop ax

        ; cx is the position in the framebuffer
        push ax
        push bx
        mov ax, cx
        mov bx, V_WIDTH
        push dx
        mul bx
        pop dx
        pop bx
        mov cx, ax
        pop ax
        add cx, bx

        ; bx is the position in the font
        mov bx, FONT_HEIGHT
        mul bl
        mov bx, ax
        add bx, font
        
        mov ax, 8 ; Counter
        .column_loop:
            push bx
            push di
            mov di, bx
            mov bl, [di]
            pop di
        
            push ax
            mov ah, 1 ; Mask
            .row_loop:
                ; For indexing
                push di
                mov di, cx
                push bx
                and bl, ah
                pop bx
                jz .draw_background

                ; Check for transparency
                cmp dl, 248
                jae .row_loop_e
                mov [es:di], dl
                jmp .row_loop_e

                .draw_background:
                    cmp dh, 248
                    jae .row_loop_e
                    mov [es:di], dh

                .row_loop_e:
                pop di
                inc cx
                shl ah, 1
                jnz .row_loop
            pop ax

            pop bx
            inc bx
            add cx, V_WIDTH - FONT_WIDTH
            dec ax
            jnz .column_loop
        ret

    
    ; in
    ;   si: fstring
    ;   dl: text color (248+ for transparent)
    ;   dh: background color
    ;   bx: x
    ;   cx: y
    ;   print arguments BACKWARDS on the stack
    ; out
    ;   CF: set on error
    ; clobbers
    ;   si
    ;   ax
    ;   bx
    ;   cx
    ;   di
    ; how to use
    ;   fstring:
    ;       %o: 16 bit octal
    ;       %s: 16 bit address to start of strin
    graphics13h_printf:
        push bp
        mov bp, sp

        mov di, 2 ; bp is 2 bytes
        .character_loop:
            mov al, [si]

            cmp al, '%'
            jne .print_char
            ; Token recognized
            inc si
            cmp [si], BYTE 'o'
            je .token_octal
            cmp [si], BYTE 's'
            je .token_string
            ; No token found. Return error
            stc
            pop bp
            ret

            .token_octal:
                add di, 2
                mov ax, [bp + di]
                ror ax, 15
                
                push si
                mov si, 5
                .octal_loop:
                    ; Octal is goofy. Heres some annoying twiddling to read from highest to lowest
                    push ax
                    mov al, ah
                    and al, 11100000b
                    shr al, 5 ; Translate it back
                    add al, '0'

                    push es
                    push bx
                    push cx
                    call graphics13h_put_char
                    pop cx
                    pop bx
                    pop es
                    add bx, FONT_WIDTH

                    pop ax ; From the bit twiddling

                    shl ax, 3
                    dec si
                    jnz .octal_loop

                pop si
                jmp .continue

            .token_string:
                add di, 2
                push si
                mov si, [bp + di]

                .string_loop:
                    mov al, [si]

                    push es
                    push bx
                    push cx
                    call graphics13h_put_char
                    pop cx
                    pop bx
                    pop es
                    add bx, FONT_WIDTH

                    inc si
                    cmp [si], BYTE 0
                    jne .string_loop

                pop si
                jmp .continue
           
                    

            .print_char:
            push es
            push bx
            push cx
            call graphics13h_put_char
            pop cx
            pop bx
            pop es
            add bx, FONT_WIDTH
            
            .continue:
            inc si
            cmp [si], BYTE 0
            jne .character_loop

    pop bp
    pop ax ; Return address
    sub di, 2 ; Return address removed (bp has been applied at the start of the subroutine)
    add sp, di
    jmp ax