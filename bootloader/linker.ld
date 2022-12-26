SECTIONS {
    /* BIOS loads us in at 0x7C00 */
    .mbr 0x7C00 : {
        mbr_s = .;
        *( .mbr );
        *( .mbr_code );
        *( .mbr_data );
    }
    . += 512 - mbr_size - mbr_header_size;
    .mbr_header : {
        *( mbr_header );
        mbr_e = .;
    }
    .mbr_bss (NOLOAD) : {
        *( .mbr_bss );
    }
    .bootloader : {
        bootloader_s = .;
        *( .bootloader );
        *( .bootloader_code );
        *( .bootloader_data );
        . = ALIGN(512);
        bootloader_e = .;
    }

    .bootloader_bss (NOLOAD) : {
        *( .bootloader_bss );
    }

}

mbr_size = SIZEOF( .mbr );
mbr_header_size = SIZEOF( .mbr_header );
bootloader_sectors = (SIZEOF( .bootloader ) + (512 - 1)) / 512;