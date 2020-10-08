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
ASSEMBLER = ./6502-assembler
PROGNAME = hello
OPTIONS = -Fbin -dotdir
 
$(PROGNAME).hex: $(PROGNAME).s
	$(ASSEMBLER) $(OPTIONS) -o $(PROGNAME).hex $(PROGNAME).s
    
write:
	minipro -p $(ROM) -w $(PROGNAME).hex
       
showhex:
	hexdump -C $(PROGNAME).hex
          
clean:
	rm $(PROGNAME).hex