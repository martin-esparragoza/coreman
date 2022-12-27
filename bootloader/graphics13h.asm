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
    ;   bx
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
                push di
                mov di, cx
                push bx
                and bl, ah
                pop bx
                jz .draw_background

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