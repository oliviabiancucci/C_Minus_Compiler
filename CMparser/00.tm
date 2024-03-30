* C-Minus Compilation to TM Code
* File: 00.tm
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
* -> op
* -> constant
 13:   LDC 0, 3(0)	load const
 14:    ST 0, -3(5)	op: push left
* <- constant
 15:    LD 0, -3(5)	retrieve result
 16:    ST 0, -2(5)	store result in variable
* <- op
* -> if
* -> op
 17:    LD 0, -2(5)	load value in variable x
 18:    ST 0, -3(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
* -> constant
 19:   LDC 0, 2(0)	load const
 20:    ST 0, -4(5)	op: push left
* <- constant
 21:    LD 0, -3(5)	
 22:    LD 1, -4(5)	
 23:    ST 0, -3(5)	storing operation result
* <- op
* -> compound statement
* -> op
* -> op
 26:    LD 0, -2(5)	load value in variable x
 27:    ST 0, -4(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
* -> constant
 28:   LDC 0, 1(0)	load const
 29:    ST 0, -5(5)	op: push left
* <- constant
 30:    LD 0, -4(5)	
 31:    LD 1, -5(5)	
 32:   SUB 0, 0, 1	perform subtract operation
 33:    ST 0, -4(5)	storing operation result
* <- op
 34:    LD 0, -4(5)	retrieve result
 35:    ST 0, -2(5)	store result in variable
* <- op
* <- compound statement
* if: jump to else belongs here
* -> compound statement
* -> op
* -> constant
 37:   LDC 0, 0(0)	load const
 38:    ST 0, -3(5)	op: push left
* <- constant
 39:    LD 0, -3(5)	retrieve result
 40:    ST 0, -2(5)	store result in variable
* <- op
* <- compound statement
 36:   LDA 7, 4(7)	if: jmp to end
 24:    LD 0, -3(5)	load result
 25:   JEQ 0, 10(7)	if: jmp to else
* <- if
* <- compound statement
 41:    LD 7, -1(5)	load return address
* <- fundecl
 42:   LDA 7, -5(7)	jump body
 43:    ST 5, -5(5)	push ofp
 44:   LDA 5, -5(5)	push frame
 45:   LDA 0, 1(7)	load ac with ret ptr
 46:   LDA 7, -35(7)	jump to main loc
 47:    LD 5, 0(5)	pop frame
* End of execution.
 48:  HALT 0, 0, 0	
