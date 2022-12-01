SECTIONS {
    /* BIOS loads us in at 0x7C00 */
    .mbr 0x7C00 : {
        mbr_s = .;
        *( .mbr );
        *( .mbr_bss );
    }
    . += 512 - mbr_size - mbr_header_size;
    .mbr_header : {
        *( mbr_header );
        mbr_e = .;
    }
}

mbr_size = SIZEOF( .mbr );
mbr_header_size = SIZEOF( .mbr_header );