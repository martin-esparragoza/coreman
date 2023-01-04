; Pointers to functions to be called.
[BITS 16]
%include "macdef.inc"
global set_fs_driver_ptrs
extern bootable_partition.drivenum

SECTION .bootloader_code
    ; in
    ;   bp: location of bootable_partition
    set_fs_driver_ptrs:
        hlt