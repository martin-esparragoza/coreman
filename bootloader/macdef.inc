[BITS 16]
%macro strlit 2
[section .bootloader_data]
    %1: db %2, 0
    %strlen %1_len %2
__SECT__
%endmacro
%macro strlitnl 2 ; Define string literal with newline at end
[section .bootloader_data]
    %1: db %2, 0xD, 0xA, 0
    %strlen %1_len %2
__SECT__
%endmacro