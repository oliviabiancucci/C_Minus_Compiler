* C-Minus Compilation to TM Code
* File: fac.tm
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
* processing local var: x -2
* processing local var: fac -3
* -> assign
* -> call of function: input
 13:    ST 5, -4(5)	push ofp
 14:   LDA 5, -4(5)	push frame
 15:   LDA 0, 1(7)	load ac with ret ptr
 16:   LDA 7, -13(7)	jump to fun loc
 17:    LD 5, 0(5)	pop frame
* <- call
 18:    ST 0, -2(5)	assign: store value
* <- assign
* -> assign
* -> constant
 19:   LDC 0, 1(0)	load const
 20:    ST 0, -4(5)	op: push left
* <- constant
 21:    LD 0, -4(5)	assign: load left
 22:    ST 0, -3(5)	assign: store value
* <- assign
* -> while
* while: jump after body comes back here
* -> op
 23:    LD 0, -2(5)	load value in variable x
 24:    ST 0, -4(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
* -> constant
 25:   LDC 0, 1(0)	load const
 26:    ST 0, -5(5)	op: push left
* <- constant
 27:    LD 0, -4(5)	
 28:    LD 1, -5(5)	
 29:   SUB 0, 0, 1	op >
 30:   JGT 0, 2(7)	br if true
 31:   LDC 0, 0(0)	false case
 32:   LDA 7, 1(7)	unconditional jump
 33:   LDC 0, 1(0)	true case
 34:    ST 0, -4(5)	storing operation result
* <- op
* -----> while body start
* -> compound statement
* -> assign
* -> op
 37:    LD 0, -3(5)	load value in variable fac
 38:    ST 0, -5(5)	store variable value on stack
* -> id
* looking up id: fac
* <- id
 39:    LD 0, -2(5)	load value in variable x
 40:    ST 0, -6(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
 41:    LD 0, -5(5)	
 42:    LD 1, -6(5)	
 43:   MUL 0, 0, 1	op *
 44:    ST 0, -5(5)	storing operation result
* <- op
 45:    LD 0, -5(5)	assign: load left
 46:    ST 0, -3(5)	assign: store value
* <- assign
* -> assign
* -> op
 47:    LD 0, -2(5)	load value in variable x
 48:    ST 0, -5(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
* -> constant
 49:   LDC 0, 1(0)	load const
 50:    ST 0, -6(5)	op: push left
* <- constant
 51:    LD 0, -5(5)	
 52:    LD 1, -6(5)	
 53:   SUB 0, 0, 1	op -
 54:    ST 0, -5(5)	storing operation result
* <- op
 55:    LD 0, -5(5)	assign: load left
 56:    ST 0, -2(5)	assign: store value
* <- assign
* <- compound statement
 57:   LDA 7, -35(7)	while: jmp back to test exp
* <----- while body end
 35:    LD 0, -4(5)	load result
 36:   JEQ 0, 21(7)	while: jmp to below while loop
* <- while
* -> call of function: output
 58:    LD 0, -3(5)	load value in variable fac
 59:    ST 0, -6(5)	store variable value on stack
* -> id
* looking up id: fac
* <- id
 60:    ST 5, -4(5)	push ofp
 61:   LDA 5, -4(5)	push frame
 62:   LDA 0, 1(7)	load ac with ret ptr
 63:   LDA 7, -57(7)	jump to fun loc
 64:    LD 5, 0(5)	pop frame
* <- call
* <- compound statement
 65:    LD 7, -1(5)	load return address
* <- fundecl
 11:   LDA 7, 54(7)	jump body
 66:    ST 5, -2(5)	push ofp
 67:   LDA 5, -2(5)	push frame
 68:   LDA 0, 1(7)	load ac with ret ptr
 69:   LDA 7, -58(7)	jump to main loc
 70:    LD 5, 0(5)	pop frame
* End of execution.
 71:  HALT 0, 0, 0	
