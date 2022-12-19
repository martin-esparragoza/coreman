%macro strlit 2
section .bootloader_data
    %1: db %2, 0
section .bootloader
%endmacro
%macro strlitnl 2 ; Define string literal with newline at end
section .bootloader_data
    %1: db %2, 0xD, 0xA, 0
section .bootloader
%endmacro