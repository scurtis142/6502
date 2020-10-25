;Compile instructions:
;vasm6502_oldstyle -Fbin -dotdir lcd.s

; $ means hexidecimal
; nothing means decimal
; # load immediate (addressing mode)
; no hash on a load mean load from address

; .org directive tells the assembler where the next statement will 
; be to the processor
; .word insert a 16bit value

PORTB = $c000
PORTA = $c001
DDRB = $c002
DDRA = $c003

E  = %10000000
RW = %01000000
RS = %00100000

 .org $e000

reset:

 ; Initialise the stack pointer to ff
 ldx #$ff
 txs

 lda #$ff   ; Set all pins on port B to output
 sta DDRB

 lda #%11100000   ; Set top 3 pins to output on port A
 sta DDRA

 ; Initialise the LCD Module
 lda  #%00111000  ; Set 8 bit mode, 2 line display and 5x8 font
 jsr lcd_instruction
 lda  #%00001110  ; Display on, cursor on, blink off
 jsr lcd_instruction
 lda  #%00000110  ; Increment and shift cursor but not entire display
 jsr lcd_instruction

 lda  #%00000001  ; Clear display
 jsr lcd_instruction

 lda #"H"
 jsr lcd_data
 lda #"e"
 jsr lcd_data
 lda #"l"
 jsr lcd_data
 lda #"l"
 jsr lcd_data
 lda #"o"
 jsr lcd_data
 lda #","
 jsr lcd_data
 lda #" "
 jsr lcd_data
 lda #"W"
 jsr lcd_data
 lda #"o"
 jsr lcd_data
 lda #"r"
 jsr lcd_data
 lda #"l"
 jsr lcd_data
 lda #"d"
 jsr lcd_data
 lda #"!"
 jsr lcd_data


loop:
 jmp loop

lcd_instruction:
 sta PORTB
 lda #0           ; Clear RS/RW/E bits
 sta PORTA
 lda #E           ; Set E bit to send instruction
 sta PORTA
 lda #0           ; Clear RS/RW/E bits
 sta PORTA
 rts

lcd_data:
 sta PORTB
 lda #RS          ; Clear RW/E bits; Set RS
 sta PORTA
 lda #(RS | E)    ; Set E & RS bits to send data
 sta PORTA
 lda #RS          ; Clear RW/E bits; Set RS
 sta PORTA
 rts

 .org $fffc
 .word reset
 .word $0000
