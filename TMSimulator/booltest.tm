* C-Minus Compilation to TM Code
* File: booltest.tm
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
* processing local var: fac -3
* <- vardecl
* -> vardecl
* processing local var: test -4
* <- vardecl
* <- vardeclist
* FO: -5 GO: 0
* -> assign
* -> call of function: input
 13:    ST 5, -5(5)	push ofp
 14:   LDA 5, -5(5)	push frame
 15:   LDA 0, 1(7)	load ac with ret ptr
 16:   LDA 7, -13(7)	jump to fun loc
 17:    LD 5, 0(5)	pop frame
 18:    ST 0, -5(5)	store result on the stack
* <- call of functioninput
 19:    LD 0, -5(5)	assign: load left
 20:    ST 0, -2(5)	assign: store value from register 0
* <- assign
* -> assign
* -> constant
 21:   LDC 0, 1(0)	load const
 22:    ST 0, -5(5)	op: push left
* <- constant
 23:    LD 0, -5(5)	assign: load left
 24:    ST 0, -3(5)	assign: store value from register 0
* <- assign
* -> assign
* -> op
* -> varexpression
 25:    LD 0, -2(5)	load value in variable x
 26:    ST 0, -5(5)	store variable value on stack
* <- varexpression
* -> constant
 27:   LDC 0, 1(0)	load const
 28:    ST 0, -6(5)	op: push left
* <- constant
 29:    LD 0, -5(5)	
 30:    LD 1, -6(5)	
 31:   SUB 0, 0, 1	op >
 32:   JGT 0, 2(7)	br if true
 33:   LDC 0, 0(0)	false case
 34:   LDA 7, 1(7)	unconditional jump
 35:   LDC 0, 1(0)	true case
 36:    ST 0, -5(5)	storing operation result
* <- op
 37:    LD 0, -5(5)	assign: load left
 38:    ST 0, -4(5)	assign: store value from register 0
* <- assign
* -> while
* while: jump after body comes back here
* -> varexpression
 39:    LD 0, -4(5)	load value in variable test
 40:    ST 0, -5(5)	store variable value on stack
* <- varexpression
* -----> while body start
* -> compound statement
* -> assign
* -> op
* -> varexpression
 43:    LD 0, -3(5)	load value in variable fac
 44:    ST 0, -6(5)	store variable value on stack
* <- varexpression
* -> varexpression
 45:    LD 0, -2(5)	load value in variable x
 46:    ST 0, -7(5)	store variable value on stack
* <- varexpression
 47:    LD 0, -6(5)	
 48:    LD 1, -7(5)	
 49:   MUL 0, 0, 1	op *
 50:    ST 0, -6(5)	storing operation result
* <- op
 51:    LD 0, -6(5)	assign: load left
 52:    ST 0, -3(5)	assign: store value from register 0
* <- assign
* -> assign
* -> op
* -> varexpression
 53:    LD 0, -2(5)	load value in variable x
 54:    ST 0, -6(5)	store variable value on stack
* <- varexpression
* -> constant
 55:   LDC 0, 1(0)	load const
 56:    ST 0, -7(5)	op: push left
* <- constant
 57:    LD 0, -6(5)	
 58:    LD 1, -7(5)	
 59:   SUB 0, 0, 1	op -
 60:    ST 0, -6(5)	storing operation result
* <- op
 61:    LD 0, -6(5)	assign: load left
 62:    ST 0, -2(5)	assign: store value from register 0
* <- assign
* -> assign
* -> op
* -> varexpression
 63:    LD 0, -2(5)	load value in variable x
 64:    ST 0, -6(5)	store variable value on stack
* <- varexpression
* -> constant
 65:   LDC 0, 1(0)	load const
 66:    ST 0, -7(5)	op: push left
* <- constant
 67:    LD 0, -6(5)	
 68:    LD 1, -7(5)	
 69:   SUB 0, 0, 1	op >
 70:   JGT 0, 2(7)	br if true
 71:   LDC 0, 0(0)	false case
 72:   LDA 7, 1(7)	unconditional jump
 73:   LDC 0, 1(0)	true case
 74:    ST 0, -6(5)	storing operation result
* <- op
 75:    LD 0, -6(5)	assign: load left
 76:    ST 0, -4(5)	assign: store value from register 0
* <- assign
* <- compound statement
 77:   LDA 7, -39(7)	while: jmp back to test exp
* <----- while body end
 41:    LD 0, -5(5)	load result
 42:   JEQ 0, 35(7)	while: jmp to below while loop
* <- while
* -> call of function: output
* -> varexpression
 78:    LD 0, -3(5)	load value in variable fac
 79:    ST 0, -7(5)	store variable value on stack
* <- varexpression
 80:    ST 5, -5(5)	push ofp
 81:   LDA 5, -5(5)	push frame
 82:   LDA 0, 1(7)	load ac with ret ptr
 83:   LDA 7, -77(7)	jump to fun loc
 84:    LD 5, 0(5)	pop frame
* <- call of functionoutput
* <- compound statement
 85:    LD 7, -1(5)	load return address
* <- fundecl
 11:   LDA 7, 74(7)	jump body
 86:    ST 5, 0(5)	push ofp
 87:   LDA 5, 0(5)	push frame
 88:   LDA 0, 1(7)	load ac with ret ptr
 89:   LDA 7, -78(7)	jump to main loc
 90:    LD 5, 0(5)	pop frame
* End of execution.
 91:  HALT 0, 0, 0	
