; Author:
;     Marcel Sondaar
;     International Business Machines (public domain VGA fonts)
;
; License:
;     Public Domain

[BITS 16]
global font

section .bootloader_data
    font:
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+0000 (nul)
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+0001
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+0002
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+0003
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+0004
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+0005
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+0006
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+0007
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+0008
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+0009
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+000A
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+000B
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+000C
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+000D
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+000E
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+000F
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+0010
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+0011
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+0012
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+0013
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+0014
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+0015
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+0016
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+0017
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+0018
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+0019
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+001A
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+001B
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+001C
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+001D
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+001E
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+001F
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+0020 (space)
        db 0x18, 0x3C, 0x3C, 0x18, 0x18, 0x00, 0x18, 0x00   ; U+0021 (!)
        db 0x36, 0x36, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+0022 (")
        db 0x36, 0x36, 0x7F, 0x36, 0x7F, 0x36, 0x36, 0x00   ; U+0023 (#)
        db 0x0C, 0x3E, 0x03, 0x1E, 0x30, 0x1F, 0x0C, 0x00   ; U+0024 ($)
        db 0x00, 0x63, 0x33, 0x18, 0x0C, 0x66, 0x63, 0x00   ; U+0025 (%)
        db 0x1C, 0x36, 0x1C, 0x6E, 0x3B, 0x33, 0x6E, 0x00   ; U+0026 (&)
        db 0x06, 0x06, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+0027 (')
        db 0x18, 0x0C, 0x06, 0x06, 0x06, 0x0C, 0x18, 0x00   ; U+0028 (()
        db 0x06, 0x0C, 0x18, 0x18, 0x18, 0x0C, 0x06, 0x00   ; U+0029 ())
        db 0x00, 0x66, 0x3C, 0xFF, 0x3C, 0x66, 0x00, 0x00   ; U+002A (*)
        db 0x00, 0x0C, 0x0C, 0x3F, 0x0C, 0x0C, 0x00, 0x00   ; U+002B (+)
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x0C, 0x0C, 0x06   ; U+002C (,)
        db 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x00   ; U+002D (-)
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x0C, 0x0C, 0x00   ; U+002E (.)
        db 0x60, 0x30, 0x18, 0x0C, 0x06, 0x03, 0x01, 0x00   ; U+002F (/)
        db 0x3E, 0x63, 0x73, 0x7B, 0x6F, 0x67, 0x3E, 0x00   ; U+0030 (0)
        db 0x0C, 0x0E, 0x0C, 0x0C, 0x0C, 0x0C, 0x3F, 0x00   ; U+0031 (1)
        db 0x1E, 0x33, 0x30, 0x1C, 0x06, 0x33, 0x3F, 0x00   ; U+0032 (2)
        db 0x1E, 0x33, 0x30, 0x1C, 0x30, 0x33, 0x1E, 0x00   ; U+0033 (3)
        db 0x38, 0x3C, 0x36, 0x33, 0x7F, 0x30, 0x78, 0x00   ; U+0034 (4)
        db 0x3F, 0x03, 0x1F, 0x30, 0x30, 0x33, 0x1E, 0x00   ; U+0035 (5)
        db 0x1C, 0x06, 0x03, 0x1F, 0x33, 0x33, 0x1E, 0x00   ; U+0036 (6)
        db 0x3F, 0x33, 0x30, 0x18, 0x0C, 0x0C, 0x0C, 0x00   ; U+0037 (7)
        db 0x1E, 0x33, 0x33, 0x1E, 0x33, 0x33, 0x1E, 0x00   ; U+0038 (8)
        db 0x1E, 0x33, 0x33, 0x3E, 0x30, 0x18, 0x0E, 0x00   ; U+0039 (9)
        db 0x00, 0x0C, 0x0C, 0x00, 0x00, 0x0C, 0x0C, 0x00   ; U+003A (:)
        db 0x00, 0x0C, 0x0C, 0x00, 0x00, 0x0C, 0x0C, 0x06   ; U+003B (;)
        db 0x18, 0x0C, 0x06, 0x03, 0x06, 0x0C, 0x18, 0x00   ; U+003C (<)
        db 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00   ; U+003D (=)
        db 0x06, 0x0C, 0x18, 0x30, 0x18, 0x0C, 0x06, 0x00   ; U+003E (>)
        db 0x1E, 0x33, 0x30, 0x18, 0x0C, 0x00, 0x0C, 0x00   ; U+003F (?)
        db 0x3E, 0x63, 0x7B, 0x7B, 0x7B, 0x03, 0x1E, 0x00   ; U+0040 (@)
        db 0x0C, 0x1E, 0x33, 0x33, 0x3F, 0x33, 0x33, 0x00   ; U+0041 (A)
        db 0x3F, 0x66, 0x66, 0x3E, 0x66, 0x66, 0x3F, 0x00   ; U+0042 (B)
        db 0x3C, 0x66, 0x03, 0x03, 0x03, 0x66, 0x3C, 0x00   ; U+0043 (C)
        db 0x1F, 0x36, 0x66, 0x66, 0x66, 0x36, 0x1F, 0x00   ; U+0044 (D)
        db 0x7F, 0x46, 0x16, 0x1E, 0x16, 0x46, 0x7F, 0x00   ; U+0045 (E)
        db 0x7F, 0x46, 0x16, 0x1E, 0x16, 0x06, 0x0F, 0x00   ; U+0046 (F)
        db 0x3C, 0x66, 0x03, 0x03, 0x73, 0x66, 0x7C, 0x00   ; U+0047 (G)
        db 0x33, 0x33, 0x33, 0x3F, 0x33, 0x33, 0x33, 0x00   ; U+0048 (H)
        db 0x1E, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x1E, 0x00   ; U+0049 (I)
        db 0x78, 0x30, 0x30, 0x30, 0x33, 0x33, 0x1E, 0x00   ; U+004A (J)
        db 0x67, 0x66, 0x36, 0x1E, 0x36, 0x66, 0x67, 0x00   ; U+004B (K)
        db 0x0F, 0x06, 0x06, 0x06, 0x46, 0x66, 0x7F, 0x00   ; U+004C (L)
        db 0x63, 0x77, 0x7F, 0x7F, 0x6B, 0x63, 0x63, 0x00   ; U+004D (M)
        db 0x63, 0x67, 0x6F, 0x7B, 0x73, 0x63, 0x63, 0x00   ; U+004E (N)
        db 0x1C, 0x36, 0x63, 0x63, 0x63, 0x36, 0x1C, 0x00   ; U+004F (O)
        db 0x3F, 0x66, 0x66, 0x3E, 0x06, 0x06, 0x0F, 0x00   ; U+0050 (P)
        db 0x1E, 0x33, 0x33, 0x33, 0x3B, 0x1E, 0x38, 0x00   ; U+0051 (Q)
        db 0x3F, 0x66, 0x66, 0x3E, 0x36, 0x66, 0x67, 0x00   ; U+0052 (R)
        db 0x1E, 0x33, 0x07, 0x0E, 0x38, 0x33, 0x1E, 0x00   ; U+0053 (S)
        db 0x3F, 0x2D, 0x0C, 0x0C, 0x0C, 0x0C, 0x1E, 0x00   ; U+0054 (T)
        db 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x3F, 0x00   ; U+0055 (U)
        db 0x33, 0x33, 0x33, 0x33, 0x33, 0x1E, 0x0C, 0x00   ; U+0056 (V)
        db 0x63, 0x63, 0x63, 0x6B, 0x7F, 0x77, 0x63, 0x00   ; U+0057 (W)
        db 0x63, 0x63, 0x36, 0x1C, 0x1C, 0x36, 0x63, 0x00   ; U+0058 (X)
        db 0x33, 0x33, 0x33, 0x1E, 0x0C, 0x0C, 0x1E, 0x00   ; U+0059 (Y)
        db 0x7F, 0x63, 0x31, 0x18, 0x4C, 0x66, 0x7F, 0x00   ; U+005A (Z)
        db 0x1E, 0x06, 0x06, 0x06, 0x06, 0x06, 0x1E, 0x00   ; U+005B ([)
        db 0x03, 0x06, 0x0C, 0x18, 0x30, 0x60, 0x40, 0x00   ; U+005C (\)
        db 0x1E, 0x18, 0x18, 0x18, 0x18, 0x18, 0x1E, 0x00   ; U+005D (])
        db 0x08, 0x1C, 0x36, 0x63, 0x00, 0x00, 0x00, 0x00   ; U+005E (^)
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF   ; U+005F (_)
        db 0x0C, 0x0C, 0x18, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+0060 (`)
        db 0x00, 0x00, 0x1E, 0x30, 0x3E, 0x33, 0x6E, 0x00   ; U+0061 (a)
        db 0x07, 0x06, 0x06, 0x3E, 0x66, 0x66, 0x3B, 0x00   ; U+0062 (b)
        db 0x00, 0x00, 0x1E, 0x33, 0x03, 0x33, 0x1E, 0x00   ; U+0063 (c)
        db 0x38, 0x30, 0x30, 0x3e, 0x33, 0x33, 0x6E, 0x00   ; U+0064 (d)
        db 0x00, 0x00, 0x1E, 0x33, 0x3f, 0x03, 0x1E, 0x00   ; U+0065 (e)
        db 0x1C, 0x36, 0x06, 0x0f, 0x06, 0x06, 0x0F, 0x00   ; U+0066 (f)
        db 0x00, 0x00, 0x6E, 0x33, 0x33, 0x3E, 0x30, 0x1F   ; U+0067 (g)
        db 0x07, 0x06, 0x36, 0x6E, 0x66, 0x66, 0x67, 0x00   ; U+0068 (h)
        db 0x0C, 0x00, 0x0E, 0x0C, 0x0C, 0x0C, 0x1E, 0x00   ; U+0069 (i)
        db 0x30, 0x00, 0x30, 0x30, 0x30, 0x33, 0x33, 0x1E   ; U+006A (j)
        db 0x07, 0x06, 0x66, 0x36, 0x1E, 0x36, 0x67, 0x00   ; U+006B (k)
        db 0x0E, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x1E, 0x00   ; U+006C (l)
        db 0x00, 0x00, 0x33, 0x7F, 0x7F, 0x6B, 0x63, 0x00   ; U+006D (m)
        db 0x00, 0x00, 0x1F, 0x33, 0x33, 0x33, 0x33, 0x00   ; U+006E (n)
        db 0x00, 0x00, 0x1E, 0x33, 0x33, 0x33, 0x1E, 0x00   ; U+006F (o)
        db 0x00, 0x00, 0x3B, 0x66, 0x66, 0x3E, 0x06, 0x0F   ; U+0070 (p)
        db 0x00, 0x00, 0x6E, 0x33, 0x33, 0x3E, 0x30, 0x78   ; U+0071 (q)
        db 0x00, 0x00, 0x3B, 0x6E, 0x66, 0x06, 0x0F, 0x00   ; U+0072 (r)
        db 0x00, 0x00, 0x3E, 0x03, 0x1E, 0x30, 0x1F, 0x00   ; U+0073 (s)
        db 0x08, 0x0C, 0x3E, 0x0C, 0x0C, 0x2C, 0x18, 0x00   ; U+0074 (t)
        db 0x00, 0x00, 0x33, 0x33, 0x33, 0x33, 0x6E, 0x00   ; U+0075 (u)
        db 0x00, 0x00, 0x33, 0x33, 0x33, 0x1E, 0x0C, 0x00   ; U+0076 (v)
        db 0x00, 0x00, 0x63, 0x6B, 0x7F, 0x7F, 0x36, 0x00   ; U+0077 (w)
        db 0x00, 0x00, 0x63, 0x36, 0x1C, 0x36, 0x63, 0x00   ; U+0078 (x)
        db 0x00, 0x00, 0x33, 0x33, 0x33, 0x3E, 0x30, 0x1F   ; U+0079 (y)
        db 0x00, 0x00, 0x3F, 0x19, 0x0C, 0x26, 0x3F, 0x00   ; U+007A (z)
        db 0x38, 0x0C, 0x0C, 0x07, 0x0C, 0x0C, 0x38, 0x00   ; U+007B ({)
        db 0x18, 0x18, 0x18, 0x00, 0x18, 0x18, 0x18, 0x00   ; U+007C (|)
        db 0x07, 0x0C, 0x0C, 0x38, 0x0C, 0x0C, 0x07, 0x00   ; U+007D (})
        db 0x6E, 0x3B, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+007E (~)
        db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   ; U+007F