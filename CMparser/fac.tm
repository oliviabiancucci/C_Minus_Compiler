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
* -> id
* looking up id: x
 13:   LDA 0, -4(5)	load id address
* <- id
 14:    ST 0, -4(5)	op: push left
* -> call of function: input
 15:    ST 5, -4(5)	push ofp
 16:   LDA 5, -4(5)	push frame
 17:   LDA 0, 1(7)	load ac with ret ptr
 18:   LDA 7, -19(7)	jump to fun loc
 19:    LD 5, 0(5)	pop frame
* <- call
 20:    LD 0, -4(5)	op: load left
 21:    ST 0, -2(5)	assign: store value
* <- op
* -> op
* -> id
* looking up id: fac
 22:   LDA 0, -4(5)	load id address
* <- id
 23:    ST 0, -4(5)	op: push left
* -> constant
 24:   LDC 0, 1(0)	load const
* <- constant
 25:    LD 0, -4(5)	op: load left
 26:    ST 0, -3(5)	assign: store value
* <- op
* -> while
* while: jump after body comes back here
* -> op
* -> id
* looking up id: x
 27:    LD 0, -4(5)	load id value
* <- id
* -> constant
 28:   LDC 0, 1(0)	load const
* <- constant
 29:    LD 0, -4(5)	
 30:    LD 1, -5(5)	
 31:   SUB 0, 0, 1	op >
 32:   JGT 0, 2(7)	br if true
 33:   LDC 0, 0(0)	false case
 34:   LDA 7, 1(7)	unconditional jump
 35:   LDC 0, 1(0)	true case
* <- op
* -----> while body start
* -> compound statement
* -> op
* -> id
* looking up id: fac
 38:   LDA 0, -5(5)	load id address
* <- id
 39:    ST 0, -5(5)	op: push left
* -> op
* -> id
* looking up id: fac
 40:    LD 0, -5(5)	load id value
* <- id
* -> id
* looking up id: x
 41:    LD 0, -6(5)	load id value
* <- id
 42:    LD 0, -5(5)	
 43:    LD 1, -6(5)	
 44:   MUL 0, 0, 1	op *
* <- op
 45:    LD 0, -5(5)	op: load left
 46:    ST 0, -3(5)	assign: store value
* <- op
* -> op
* -> id
* looking up id: x
 47:   LDA 0, -5(5)	load id address
* <- id
 48:    ST 0, -5(5)	op: push left
* -> op
* -> id
* looking up id: x
 49:    LD 0, -5(5)	load id value
* <- id
* -> constant
 50:   LDC 0, 1(0)	load const
* <- constant
 51:    LD 0, -5(5)	
 52:    LD 1, -6(5)	
 53:   SUB 0, 0, 1	op -
* <- op
 54:    LD 0, -5(5)	op: load left
 55:    ST 0, -2(5)	assign: store value
* <- op
* <- compound statement
 56:   LDA 7, -30(7)	while: jmp back to test exp
* <----- while body end
 36:    LD 0, -4(5)	load result
 37:   JEQ 0, 19(7)	while: jmp to below while loop
* <- while
* -> call of function: output
 57:    ST 5, -4(5)	push ofp
 58:   LDA 5, -4(5)	push frame
 59:   LDA 0, 1(7)	load ac with ret ptr
 60:   LDA 7, -61(7)	jump to fun loc
 61:    LD 5, 0(5)	pop frame
* <- call
* <- compound statement
 62:    LD 7, -1(5)	load return address
* <- fundecl
 63:   LDA 7, -5(7)	jump body
 64:    ST 5, -5(5)	push ofp
 65:   LDA 5, -5(5)	push frame
 66:   LDA 0, 1(7)	load ac with ret ptr
 67:   LDA 7, -56(7)	jump to main loc
 68:    LD 5, 0(5)	pop frame
* End of execution.
 69:  HALT 0, 0, 0	
