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
* -> compound
* processing local var: x -2
* processing local var: fac -3
* -> assign
* -> call of function: input
 13:    ST 5, -6(5)	push ofp
 14:   LDA 5, -6(5)	push frame
 15:   LDA 0, 1(7)	load ac with ret ptr
 16:   LDA 7, -17(7)	jump to fun loc
 17:    LD 5, 0(5)	pop frame
* <- call
 18:    LD 0, -6(5)	retrieve result
 19:    ST 0, -2(5)	store result in variable
* <- assign
* -> assign
* -> constant
 20:   LDC 0, 1(0)	load const
 21:    ST 0, -6(5)	op: push left
* <- constant
 22:    LD 0, -6(5)	retrieve result
 23:    ST 0, -3(5)	store result in variable
* <- assign
* -> while
* while: jump after body comes back here
* -> op
 24:    LD 0, -2(5)	load value in variable x
 25:    ST 0, -4(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
* -> constant
 26:   LDC 0, 1(0)	load const
 27:    ST 0, -5(5)	op: push left
* <- constant
 28:    LD 0, -4(5)	
 29:    LD 1, -5(5)	
 30:   SUB 0, 0, 1	op >
 31:   JGT 0, 2(7)	br if true
 32:   LDC 0, 0(0)	false case
 33:   LDA 7, 1(7)	unconditional jump
 34:   LDC 0, 1(0)	true case
 35:    ST 0, -4(5)	storing operation result
* <- op
* -----> while body start
* -> compound
* -> assign
* -> op
 38:    LD 0, -3(5)	load value in variable fac
 39:    ST 0, -7(5)	store variable value on stack
* -> id
* looking up id: fac
* <- id
 40:    LD 0, -2(5)	load value in variable x
 41:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
 42:    LD 0, -7(5)	
 43:    LD 1, -8(5)	
 44:   MUL 0, 0, 1	perform multiply operation
 45:    ST 0, -7(5)	storing operation result
* <- op
 46:    LD 0, -7(5)	retrieve result
 47:    ST 0, -3(5)	store result in variable
* <- assign
* -> assign
* -> op
 48:    LD 0, -2(5)	load value in variable x
 49:    ST 0, -7(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
* -> constant
 50:   LDC 0, 1(0)	load const
 51:    ST 0, -8(5)	op: push left
* <- constant
 52:    LD 0, -7(5)	
 53:    LD 1, -8(5)	
 54:   SUB 0, 0, 1	perform subtract operation
 55:    ST 0, -7(5)	storing operation result
* <- op
 56:    LD 0, -7(5)	retrieve result
 57:    ST 0, -2(5)	store result in variable
* <- assign
* <- compound
 58:   LDA 7, -35(7)	while: jmp back to test exp
* <----- while body end
 36:    LD 0, -4(5)	load result
 37:   JEQ 0, 21(7)	while: jmp to below while loop
* <- while
* -> call of function: output
 59:    ST 5, -4(5)	push ofp
 60:   LDA 5, -4(5)	push frame
 61:   LDA 0, 1(7)	load ac with ret ptr
 62:   LDA 7, -63(7)	jump to fun loc
 63:    LD 5, 0(5)	pop frame
* <- call
* <- compound
 64:    LD 7, -1(5)	load return address
* <- fundecl
 65:   LDA 7, -5(7)	jump body
 66:    ST 5, -2(5)	push ofp
 67:   LDA 5, -2(5)	push frame
 68:   LDA 0, 1(7)	load ac with ret ptr
 69:   LDA 7, -58(7)	jump to main loc
 70:    LD 5, 0(5)	pop frame
* End of execution.
 71:  HALT 0, 0, 0	
