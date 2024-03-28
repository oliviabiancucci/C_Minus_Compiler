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
* <- op4
 25:    LD 0, -4(5)	retrieve result
 26:    ST 0, -2(5)	store result in variable
* <- assign
* <- compound
 27:    LD 7, -1(5)	load return address
* <- fundecl
 28:   LDA 7, 16(7)	jump body
 29:    ST 5, -2(5)	push ofp
 30:   LDA 5, -2(5)	push frame
 31:   LDA 0, 1(7)	load ac with ret ptr
 32:   LDA 7, -21(7)	jump to main loc
 33:    LD 5, 0(5)	pop frame
* End of execution.
 34:  HALT 0, 0, 0	
