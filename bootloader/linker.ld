SECTIONS {
    /* BIOS loads us in at 0x7C00 */
    .mbr 0x7C00 : {
        mbr_s = .;
        *( .mbr );
        *( .mbr_data );
        /* bss here */
    }
    . += 512 - mbr_size - mbr_header_size;
    .mbr_header : {
        *( mbr_header );
        mbr_e = .;
    }
    .bootloader : {
        bootloader_s = .;
        *( .bootloader );
        bootloader_e = .;
    }
    . += 512 - bootloader_size - 1; /* -1 ??? */
}

mbr_size = SIZEOF( .mbr );
mbr_header_size = SIZEOF( .mbr_header );
bootloader_size = SIZEOF( .bootloader );
bootloader_sectors = (bootloader_size + (512 - 1)) / 512;