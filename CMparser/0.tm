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
* allocated local var: x -2
* allocated local var: y -3
* -> assign
* -> constant
 13:   LDC 0, 10(0)	load const
 14:    ST 0, -4(5)	op: push left
* <- constant
 15:    LD 0, -4(5)	retrieve result
 16:    ST 0, -3(5)	store result in variable
* <- assign
* -> assign
* -> op
* -> constant
 17:   LDC 0, 5(0)	load const
 18:    ST 0, -4(5)	op: push left
* <- constant
 19:    LD 0, -3(5)	load value in variable y
 20:    ST 0, -5(5)	store variable value on stack
* -> id
* looking up id: y
* <- id
 21:    LD 0, -4(5)	
 22:    LD 1, -5(5)	
 23:   ADD 0, 0, 1	perform add operation
 24:    ST 0, -4(5)	storing operation result
* <- op
 25:    LD 0, -4(5)	retrieve result
 26:    ST 0, -2(5)	store result in variable
* <- assign
* -> if
* -> op
 27:    LD 0, -3(5)	load value in variable y
 28:    ST 0, -2(5)	store variable value on stack
* -> id
* looking up id: y
* <- id
* -> constant
 29:   LDC 0, 10(0)	load const
 30:    ST 0, -3(5)	op: push left
* <- constant
 31:    LD 0, -2(5)	
 32:    LD 1, -3(5)	
 33:    ST 0, -2(5)	storing operation result
* <- op
* -> compound
* <- compound
* if: jump to end belongs here
 34:   JEQ 7, 0(7)	if: jmp to else
* if: jump to else belongs here
* ---------------------------------------------------------> NILEXP
* <- if
* <- compound
 35:    LD 7, -1(5)	load return address
* <- fundecl
 36:   LDA 7, 24(7)	jump body
 37:    ST 5, -2(5)	push ofp
 38:   LDA 5, -2(5)	push frame
 39:   LDA 0, 1(7)	load ac with ret ptr
 40:   LDA 7, -29(7)	jump to main loc
 41:    LD 5, 0(5)	pop frame
* End of execution.
 42:  HALT 0, 0, 0	
