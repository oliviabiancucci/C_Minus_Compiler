* C-Minus Compilation to TM Code
* File: 1.tm
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
* processing local var: x -2
* <- vardecl
* -> vardecl
* processing local var: y -3
* <- vardecl
* <- vardeclist
* FO: -4 GO: 0
* -> assign
* -> call of function: input
 13:    ST 5, -4(5)	push ofp
 14:   LDA 5, -4(5)	push frame
 15:   LDA 0, 1(7)	load ac with ret ptr
 16:   LDA 7, -13(7)	jump to fun loc
 17:    LD 5, 0(5)	pop frame
 18:    ST 0, -4(5)	store result on the stack
* <- call of functioninput
 19:    LD 0, -4(5)	assign: load left
 20:    ST 0, -2(5)	assign: store value
* <- assign
* -> assign
* -> constant
 21:   LDC 0, 0(0)	load const
 22:    ST 0, -4(5)	op: push left
* <- constant
 23:    LD 0, -4(5)	assign: load left
 24:    ST 0, -3(5)	assign: store value
* <- assign
* -> while
* while: jump after body comes back here
* -> op
 25:    LD 0, -3(5)	load value in variable y
 26:    ST 0, -4(5)	store variable value on stack
* -> id
* looking up id: y
* <- id
 27:    LD 0, -2(5)	load value in variable x
 28:    ST 0, -5(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
 29:    LD 0, -4(5)	
 30:    LD 1, -5(5)	
 31:   SUB 0, 0, 1	op <
 32:   JLT 0, 2(7)	br if true
 33:   LDC 0, 0(0)	false case
 34:   LDA 7, 1(7)	unconditional jump
 35:   LDC 0, 1(0)	true case
 36:    ST 0, -4(5)	storing operation result
* <- op
* -----> while body start
* -> compound statement
* -> assign
* -> op
 39:    LD 0, -3(5)	load value in variable y
 40:    ST 0, -5(5)	store variable value on stack
* -> id
* looking up id: y
* <- id
* -> constant
 41:   LDC 0, 3(0)	load const
 42:    ST 0, -6(5)	op: push left
* <- constant
 43:    LD 0, -5(5)	
 44:    LD 1, -6(5)	
 45:   ADD 0, 0, 1	op +
 46:    ST 0, -5(5)	storing operation result
* <- op
 47:    LD 0, -5(5)	assign: load left
 48:    ST 0, -3(5)	assign: store value
* <- assign
* <- compound statement
 49:   LDA 7, -25(7)	while: jmp back to test exp
* <----- while body end
 37:    LD 0, -4(5)	load result
 38:   JEQ 0, 11(7)	while: jmp to below while loop
* <- while
* -> call of function: output
 50:    LD 0, -3(5)	load value in variable y
 51:    ST 0, -6(5)	store variable value on stack
* -> id
* looking up id: y
* <- id
 52:    ST 5, -4(5)	push ofp
 53:   LDA 5, -4(5)	push frame
 54:   LDA 0, 1(7)	load ac with ret ptr
 55:   LDA 7, -49(7)	jump to fun loc
 56:    LD 5, 0(5)	pop frame
* <- call of functionoutput
* <- compound statement
 57:    LD 7, -1(5)	load return address
* <- fundecl
 11:   LDA 7, 46(7)	jump body
 58:    ST 5, 0(5)	push ofp
 59:   LDA 5, 0(5)	push frame
 60:   LDA 0, 1(7)	load ac with ret ptr
 61:   LDA 7, -50(7)	jump to main loc
 62:    LD 5, 0(5)	pop frame
* End of execution.
 63:  HALT 0, 0, 0	
