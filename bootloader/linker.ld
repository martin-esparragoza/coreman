SECTIONS {
    /* BIOS loads us in at 0x7C00 */
    .mbr 0x7C00 : {
        mbr_s = .;
        *( .mbr );
        *( .mbr_code );
        *( .mbr_data );
        *( .bss );
    }
    . += 512 - mbr_size - mbr_header_size;
    .mbr_header : {
        *( mbr_header );
        mbr_e = .;
    }
    .bootloader : {
        bootloader_s = .;
        *( .bootloader );
        *( .bootloader_code );
        *( .bootloader_data );
    }

    . += 512 - bootloader_size - 1; /* -1 ??? */
    .bootloader_bss (NOLOAD) : {
        *( .bootloader_bss );
    } 
    bootloader_e = .;
}

mbr_size = SIZEOF( .mbr );
mbr_header_size = SIZEOF( .mbr_header );
bootloader_size = SIZEOF( .bootloader );
bootloader_sectors = (bootloader_size + (512 - 1)) / 512;