#! /usr/bin/python3

# Top 3 bits of 6502 address space are used to enable ROM
# Therefore, subtrace 0xE000 from 6502 address to get AT28C address
# e.g. FFFC - E000 = 1FFC

code = bytearray([
   0xa9, 0xff,          # load value of 0xff into 'A' register
   0x8d, 0x02, 0xc0,    # store the value in the 'A' register to location $c002

   0xa9, 0x55,          # lda #$55
   0x8d, 0x00, 0xc0,    # store the value in the 'A' register to location $c000

   0xa9, 0xaa,          # lda #$aa
   0x8d, 0x00, 0xc0,    # store the value in the 'A' register to location $c000

   0x4c, 0x05, 0xe0,    # jmp e005
   ])

rom = code + bytearray([0xea] * (8192 - len(code)))

# Set program counter to start of AT28C
# Lowest AT28C address is 0xE000
rom[0x1ffc] = 0x00
rom[0x1ffd] = 0xe0

with open("rom.hex", "wb") as out_file:
   out_file.write(rom);
