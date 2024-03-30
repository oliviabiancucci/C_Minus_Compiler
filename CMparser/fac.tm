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
* -> op
 13:    LD 0, -2(5)	load value in variable x
 14:    ST 0, -5(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
* -> call of function: input
 15:    ST 5, -6(5)	push ofp
 16:   LDA 5, -6(5)	push frame
 17:   LDA 0, 1(7)	load ac with ret ptr
 18:   LDA 7, -19(7)	jump to fun loc
 19:    LD 5, 0(5)	pop frame
* <- call
 20:    LD 0, -5(5)	op: load left
 21:    LD 1, -6(5)	op: load right
 22:    ST 1, 0(0)	
 23:    ST 1, -4(5)	assign: store value
* <- op
* -> op
 24:    LD 0, -3(5)	load value in variable fac
 25:    ST 0, -5(5)	store variable value on stack
* -> id
* looking up id: fac
* <- id
* -> constant
 26:   LDC 0, 1(0)	load const
 27:    ST 0, -6(5)	op: push left
* <- constant
 28:    LD 0, -5(5)	op: load left
 29:    LD 1, -6(5)	op: load right
 30:    ST 1, 0(0)	
 31:    ST 1, -4(5)	assign: store value
* <- op
* -> while
* while: jump after body comes back here
* -> op
 32:    LD 0, -2(5)	load value in variable x
 33:    ST 0, -4(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
* -> constant
 34:   LDC 0, 1(0)	load const
 35:    ST 0, -5(5)	op: push left
* <- constant
 36:    LD 0, -4(5)	
 37:    LD 1, -5(5)	
 38:   SUB 0, 0, 1	op >
 39:   JGT 0, 2(7)	br if true
 40:   LDC 0, 0(0)	false case
 41:   LDA 7, 1(7)	unconditional jump
 42:   LDC 0, 1(0)	true case
 43:    ST 0, -4(5)	storing operation result
* <- op
* -----> while body start
* -> compound statement
* -> op
 46:    LD 0, -3(5)	load value in variable fac
 47:    ST 0, -6(5)	store variable value on stack
* -> id
* looking up id: fac
* <- id
* -> op
 48:    LD 0, -3(5)	load value in variable fac
 49:    ST 0, -7(5)	store variable value on stack
* -> id
* looking up id: fac
* <- id
 50:    LD 0, -2(5)	load value in variable x
 51:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
 52:    LD 0, -7(5)	
 53:    LD 1, -8(5)	
 54:   MUL 0, 0, 1	perform multiply operation
 55:    ST 0, -7(5)	storing operation result
* <- op
 56:    LD 0, -6(5)	op: load left
 57:    LD 1, -7(5)	op: load right
 58:    ST 1, 0(0)	
 59:    ST 1, -5(5)	assign: store value
* <- op
* -> op
 60:    LD 0, -2(5)	load value in variable x
 61:    ST 0, -6(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
* -> op
 62:    LD 0, -2(5)	load value in variable x
 63:    ST 0, -7(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
* -> constant
 64:   LDC 0, 1(0)	load const
 65:    ST 0, -8(5)	op: push left
* <- constant
 66:    LD 0, -7(5)	
 67:    LD 1, -8(5)	
 68:   SUB 0, 0, 1	perform subtract operation
 69:    ST 0, -7(5)	storing operation result
* <- op
 70:    LD 0, -6(5)	op: load left
 71:    LD 1, -7(5)	op: load right
 72:    ST 1, 0(0)	
 73:    ST 1, -5(5)	assign: store value
* <- op
* <- compound statement
 74:   LDA 7, -43(7)	while: jmp back to test exp
* <----- while body end
 44:    LD 0, -4(5)	load result
 45:   JEQ 0, 29(7)	while: jmp to below while loop
* <- while
* -> call of function: output
 75:    ST 5, -4(5)	push ofp
 76:   LDA 5, -4(5)	push frame
 77:   LDA 0, 1(7)	load ac with ret ptr
 78:   LDA 7, -79(7)	jump to fun loc
 79:    LD 5, 0(5)	pop frame
* <- call
* <- compound statement
 80:    LD 7, -1(5)	load return address
* <- fundecl
 81:   LDA 7, -5(7)	jump body
 82:    ST 5, -2(5)	push ofp
 83:   LDA 5, -2(5)	push frame
 84:   LDA 0, 1(7)	load ac with ret ptr
 85:   LDA 7, -74(7)	jump to main loc
 86:    LD 5, 0(5)	pop frame
* End of execution.
 87:  HALT 0, 0, 0	
