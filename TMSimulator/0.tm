* C-Minus Compilation to TM Code
* File: 0.tm
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
* -> constant
 13:   LDC 0, 0(0)	load const
 14:    ST 0, -4(5)	op: push left
* <- constant
 15:    LD 0, -4(5)	retrieve result
 16:    ST 0, -3(5)	store result in variable
* <- assign
* -> assign
* -> constant
 17:   LDC 0, 3(0)	load const
 18:    ST 0, -4(5)	op: push left
* <- constant
 19:    LD 0, -4(5)	retrieve result
 20:    ST 0, -2(5)	store result in variable
* <- assign
* -> while
* while: jump after body comes back here
* -> op
 21:    LD 0, -2(5)	load value in variable x
 22:    ST 0, -4(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
* -> constant
 23:   LDC 0, 1(0)	load const
 24:    ST 0, -5(5)	op: push left
* <- constant
 25:    LD 0, -4(5)	
 26:    LD 1, -5(5)	
 27:   SUB 0, 0, 1	op >
 28:   JGT 0, 2(7)	br if true
 29:   LDC 0, 0(0)	false case
 30:   LDA 7, 1(7)	unconditional jump
 31:   LDC 0, 1(0)	true case
 32:    ST 0, -4(5)	storing operation result
* <- op
* -----> while body start
* -> compound
* -> assign
* -> op
 35:    LD 0, -3(5)	load value in variable fac
 36:    ST 0, -5(5)	store variable value on stack
* -> id
* looking up id: fac
* <- id
* -> constant
 37:   LDC 0, 1(0)	load const
 38:    ST 0, -6(5)	op: push left
* <- constant
 39:    LD 0, -5(5)	
 40:    LD 1, -6(5)	
 41:   ADD 0, 0, 1	perform add operation
 42:    ST 0, -5(5)	storing operation result
* <- op
 43:    LD 0, -5(5)	retrieve result
 44:    ST 0, -3(5)	store result in variable
* <- assign
* -> assign
* -> op
 45:    LD 0, -2(5)	load value in variable x
 46:    ST 0, -5(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
* -> constant
 47:   LDC 0, 1(0)	load const
 48:    ST 0, -6(5)	op: push left
* <- constant
 49:    LD 0, -5(5)	
 50:    LD 1, -6(5)	
 51:   SUB 0, 0, 1	perform subtract operation
 52:    ST 0, -5(5)	storing operation result
* <- op
 53:    LD 0, -5(5)	retrieve result
 54:    ST 0, -2(5)	store result in variable
* <- assign
* <- compound
 55:   LDA 7, -35(7)	while: jmp back to test exp
* <----- while body end
 33:    LD 0, -4(5)	load result
 34:   JEQ 0, 21(7)	while: jmp to below while loop
* <- while
* <- compound
 56:    LD 7, -1(5)	load return address
* <- fundecl
 57:   LDA 7, -5(7)	jump body
 58:    ST 5, -2(5)	push ofp
 59:   LDA 5, -2(5)	push frame
 60:   LDA 0, 1(7)	load ac with ret ptr
 61:   LDA 7, -50(7)	jump to main loc
 62:    LD 5, 0(5)	pop frame
* End of execution.
 63:  HALT 0, 0, 0	
