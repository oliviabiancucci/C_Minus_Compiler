* C-Minus Compilation to TM Code
* File: 12.tm
* Standard prelude:
  0:    LD 6, 0(0)	load gp with maxaddress
  1:   LDA 5, 0(6)	copy to gp to fp
  2:    ST 0, 0(0)	clear location 0
* Jump around i/o routines here
* code for input routine
  4:    ST 0, -1(5)	store return
  5:    IN 0, 0, 0	input
  6:    LD 7, -1(5)	return to caller
* code for output routine
  7:    ST 0, -1(5)	store return
  8:    LD 0, -2(5)	load output value
  9:   OUT 0, 0, 0	output
 10:    LD 7, -1(5)	return to caller
  3:   LDA 7, 7(7)	jump around i/o code
* End of standard prelude.
* -> fundecl
* processing function: main
* jump around function body
 12:    ST 0, -1(5)	store return
* -> compound statement
* -> vardeclist
* -> vardecl
* processing local array: array -2
* <- vardecl
* -> vardecl
* processing local var: i -7
* <- vardecl
* <- vardeclist
* FO: -8 GO: 0
* -> assign
* -> constant
 13:   LDC 0, 5(0)	load const
 14:    ST 0, -8(5)	op: push left
* <- constant
* -> constant
 15:   LDC 0, 4(0)	load const
 16:    ST 0, -9(5)	op: push left
* <- constant
 17:    LD 0, -9(5)	assign: load result of array index calculation into register 0
 18:   JLT 0, 1(7)	check if the index is less than 0
 19:   LDA 7, 1(7)	unconditional jump
 20:  HALT 0, 0, 0	array index out of bounds
 21:   LDC 1, 5(0)	load array size
 22:   SUB 0, 0, 1	op >
 23:   JGT 0, 1(7)	br if true
 24:   LDA 7, 1(7)	unconditional jump
 25:  HALT 0, 0, 0	array index out of bounds
 26:    LD 0, -9(5)	assign: load result of array index calculation into register 0
 27:   LDA 1, -2(5)	load array base address into register 1
 28:   SUB 1, 1, 0	adds the base address to the index
 29:    LD 0, -8(5)	assign: load result of rhs into register 0
 30:    ST 0, 0(1)	assign: store value from register 0
* <- assign
* -> call of function: output
* -> varexpression
* -> constant
 31:   LDC 0, 4(0)	load const
 32:    ST 0, -10(5)	op: push left
* <- constant
 33:    LD 0, -10(5)	assign: load result of array index calculation into register 0
 34:   LDA 1, -2(5)	load array base address into register 1
 35:   SUB 1, 1, 0	adds the base address to the index
 36:    LD 0, 0(1)	load value in array array
 37:    ST 0, -10(5)	store variable value on stack
* <- varexpression
 38:    ST 5, -8(5)	push ofp
 39:   LDA 5, -8(5)	push frame
 40:   LDA 0, 1(7)	load ac with ret ptr
 41:   LDA 7, -35(7)	jump to fun loc
 42:    LD 5, 0(5)	pop frame
* <- call of functionoutput
* <- compound statement
 43:    LD 7, -1(5)	load return address
* <- fundecl
 11:   LDA 7, 32(7)	jump body
 44:    ST 5, 0(5)	push ofp
 45:   LDA 5, 0(5)	push frame
 46:   LDA 0, 1(7)	load ac with ret ptr
 47:   LDA 7, -36(7)	jump to main loc
 48:    LD 5, 0(5)	pop frame
* End of execution.
 49:  HALT 0, 0, 0	
