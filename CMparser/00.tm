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
* processing local var: y -3
* -> op
 13:   LDC 0, 1(0)	true condition
 14:    ST 0, -4(5)	
 15:    LD 0, -4(5)	op: load left
 16:    ST 0, -2(5)	assign: store value
* <- op
* -> op
* -> op
 17:    LD 0, -2(5)	load value in variable x
 18:    ST 0, -5(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
 19:    LD 0, -4(5)	
 20:    LD 1, -5(5)	
 21:   LDC 0, 0(0)	
 23:   LDC 0, 1(0)	
 22:   LDA 7, 1(7)	
  0:   JEQ 0, 22(7)	
 24:    ST 0, -4(5)	storing operation result
* <- op
 25:    LD 0, -4(5)	op: load left
 26:    ST 0, -3(5)	assign: store value
* <- op
* <- compound statement
 27:    LD 7, -1(5)	load return address
* <- fundecl
 11:   LDA 7, 16(7)	jump body
 28:    ST 5, -2(5)	push ofp
 29:   LDA 5, -2(5)	push frame
 30:   LDA 0, 1(7)	load ac with ret ptr
 31:   LDA 7, -20(7)	jump to main loc
 32:    LD 5, 0(5)	pop frame
* End of execution.
 33:  HALT 0, 0, 0	
