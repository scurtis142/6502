;Compile instructions:
;vasm6502_oldstyle -Fbin -dotdir hello.s

; $ means hexidecimal
; nothing means decimal
; # load immediate (addressing mode)
; no hash on a load mean load from address

; .org directive tells the assembler where the next statement will 
; be to the processor
; .word insert a 16bit value

 .org $e000

reset:
 lda #$ff
 sta $c002

 lda #$50
 sta $c000

loop:
 ror
 sta $c000

 jmp loop

 .org $fffc
 .word reset
 .word $0000
