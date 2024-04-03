* C-Minus Compilation to TM Code
* File: 11.tm
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
* processing local var: i -12
* <- vardecl
* <- vardeclist
* FO: -13 GO: 0
* -> assign
* -> constant
 13:   LDC 0, 0(0)	load const
 14:    ST 0, -13(5)	op: push left
* <- constant
 15:    LD 0, -13(5)	assign: load left
 16:    ST 0, -12(5)	assign: store value from register 0
* <- assign
* -> while
* while: jump after body comes back here
* -> op
* -> varexpression
 17:    LD 0, -12(5)	load value in variable i
 18:    ST 0, -13(5)	store variable value on stack
* <- varexpression
* -> constant
 19:   LDC 0, 10(0)	load const
 20:    ST 0, -14(5)	op: push left
* <- constant
 21:    LD 0, -13(5)	
 22:    LD 1, -14(5)	
 23:   SUB 0, 0, 1	op <
 24:   JLT 0, 2(7)	br if true
 25:   LDC 0, 0(0)	false case
 26:   LDA 7, 1(7)	unconditional jump
 27:   LDC 0, 1(0)	true case
 28:    ST 0, -13(5)	storing operation result
* <- op
* -----> while body start
* -> compound statement
* -> assign
* -> op
* -> varexpression
 31:    LD 0, -12(5)	load value in variable i
 32:    ST 0, -14(5)	store variable value on stack
* <- varexpression
* -> constant
 33:   LDC 0, 20(0)	load const
 34:    ST 0, -15(5)	op: push left
* <- constant
 35:    LD 0, -14(5)	
 36:    LD 1, -15(5)	
 37:   ADD 0, 0, 1	op +
 38:    ST 0, -14(5)	storing operation result
* <- op
* -> varexpression
 39:    LD 0, -12(5)	load value in variable i
 40:    ST 0, -15(5)	store variable value on stack
* <- varexpression
 41:    LD 0, -15(5)	assign: load result of array index calculation into register 0
 42:   LDA 1, -2(5)	load array base address into register 1
 43:   SUB 1, 1, 0	adds the base address to the index
 44:    LD 0, -14(5)	assign: load result of rhs into register 0
 45:    ST 0, 0(1)	assign: store value from register 0
* <- assign
* -> assign
* -> op
* -> varexpression
 46:    LD 0, -12(5)	load value in variable i
 47:    ST 0, -14(5)	store variable value on stack
* <- varexpression
* -> constant
 48:   LDC 0, 1(0)	load const
 49:    ST 0, -15(5)	op: push left
* <- constant
 50:    LD 0, -14(5)	
 51:    LD 1, -15(5)	
 52:   ADD 0, 0, 1	op +
 53:    ST 0, -14(5)	storing operation result
* <- op
 54:    LD 0, -14(5)	assign: load left
 55:    ST 0, -12(5)	assign: store value from register 0
* <- assign
* <- compound statement
 56:   LDA 7, -40(7)	while: jmp back to test exp
* <----- while body end
 29:    LD 0, -13(5)	load result
 30:   JEQ 0, 26(7)	while: jmp to below while loop
* <- while
* -> call of function: output
* -> varexpression
* -> constant
 57:   LDC 0, 5(0)	load const
 58:    ST 0, -15(5)	op: push left
* <- constant
 59:    LD 0, -15(5)	assign: load result of array index calculation into register 0
 60:   LDA 1, -2(5)	load array base address into register 1
 61:   SUB 1, 1, 0	adds the base address to the index
 62:    LD 0, 0(1)	load value in array array
 63:    ST 0, -15(5)	store variable value on stack
* <- varexpression
 64:    ST 5, -13(5)	push ofp
 65:   LDA 5, -13(5)	push frame
 66:   LDA 0, 1(7)	load ac with ret ptr
 67:   LDA 7, -61(7)	jump to fun loc
 68:    LD 5, 0(5)	pop frame
* <- call of functionoutput
* <- compound statement
 69:    LD 7, -1(5)	load return address
* <- fundecl
 11:   LDA 7, 58(7)	jump body
 70:    ST 5, 0(5)	push ofp
 71:   LDA 5, 0(5)	push frame
 72:   LDA 0, 1(7)	load ac with ret ptr
 73:   LDA 7, -62(7)	jump to main loc
 74:    LD 5, 0(5)	pop frame
* End of execution.
 75:  HALT 0, 0, 0	
