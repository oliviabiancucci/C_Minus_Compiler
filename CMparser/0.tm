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
* ---------------------------------------------------------> VAREXP
 13:   LDA 0, -3(5)	load declaration address: y
* -> constant
 14:   LDC 1, 10(0)	load const
 15:    ST 1, -3(5)	op: push left
* <- constant
 16:    LD 0, -3(5)	retrieve result
 17:    ST 0, 0(1)	store result in variable
* <- assign
* -> assign
* ---------------------------------------------------------> VAREXP
 18:   LDA 0, -2(5)	load declaration address: x
* -> op
* -> constant
 19:   LDC 1, 5(0)	load const
 20:    ST 1, -3(5)	op: push left
* <- constant
* ---------------------------------------------------------> VAREXP
 21:   LDA 0, -3(5)	load declaration address: y
 22:    LD 0, -3(5)	
 23:    LD 1, -4(5)	
 24:   ADD 0, 0, 1	perform add operation
 25:    ST 0, -3(5)	storing operation result
* <- op
 26:    LD 0, -3(5)	retrieve result
 27:    ST 0, 0(1)	store result in variable
* <- assign
* <- compound
 28:    LD 7, -1(5)	load return address
* <- fundecl
 29:   LDA 7, 17(7)	jump body
 30:    ST 5, -2(5)	push ofp
 31:   LDA 5, -2(5)	push frame
 32:   LDA 0, 1(7)	load ac with ret ptr
 33:   LDA 7, -22(7)	jump to main loc
 34:    LD 5, 0(5)	pop frame
* End of execution.
 35:  HALT 0, 0, 0	
