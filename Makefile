#
# Makefile for programming AT28C-series ROM for the 6502 processor
#
# Author: 	Simon Curtis
# Email:		scurtis142@gmail.com
#
# Assemble with 'make', write hexfile to ROM programmer with 'make write'.
#
# Configuration:
#
# ROM       -> name of ROM chip to program (see 'minipro -l' for a list)
# ASSEMBLER -> name of assembler program
# PROGNAME	-> program to assemble
# OPTIONS	-> options for assembler
#
 
ROM = AT28C64B
ASSEMBLER = vasm6502_oldstyle
PROGNAME = lcd
OPTIONS = -Fbin -dotdir
 
$(PROGNAME).hex: $(PROGNAME).s
	$(ASSEMBLER) $(OPTIONS) -o $(PROGNAME).hex $(PROGNAME).s
    
.PHONY: write
write:
	minipro -p $(ROM) -w $(PROGNAME).hex
       
.PHONY: showhex
showhex:
	hexdump -C $(PROGNAME).hex
          
.PHONY: clean
clean:
	rm *.hex
