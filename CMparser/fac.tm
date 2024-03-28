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
* allocated local var: x -2
* allocated local var: fac -3
* -> assign
* ---------------------------------------------------------> VAREXP
 13:   LDA 0, -2(5)	load declaration address: x
* ---------------------------------------------------------> CALLEXP
 14:    LD 0, -3(5)	retrieve result
 15:    ST 0, 0(1)	store result in variable
* <- assign
* -> assign
* ---------------------------------------------------------> VAREXP
 16:   LDA 0, -3(5)	load declaration address: fac
* -> constant
 17:   LDC 1, 1(0)	load const
 18:    ST 1, -4(5)	op: push left
* <- constant
 19:    LD 0, -3(5)	retrieve result
 20:    ST 0, 0(1)	store result in variable
* <- assign
* -> while
* -> compound
* -> assign
* ---------------------------------------------------------> VAREXP
 21:   LDA 0, -3(5)	load declaration address: fac
* -> op
* ---------------------------------------------------------> VAREXP
 22:   LDA 0, -3(5)	load declaration address: fac
* ---------------------------------------------------------> VAREXP
 23:   LDA 0, -2(5)	load declaration address: x
 24:    LD 0, -4(5)	
 25:    LD 1, -5(5)	
 26:   MUL 0, 0, 1	perform multiply operation
 27:    ST 0, -4(5)	storing operation result
* <- op
 28:    LD 0, -3(5)	retrieve result
 29:    ST 0, 0(1)	store result in variable
* <- assign
* -> assign
* ---------------------------------------------------------> VAREXP
 30:   LDA 0, -2(5)	load declaration address: x
* -> op
* ---------------------------------------------------------> VAREXP
 31:   LDA 0, -2(5)	load declaration address: x
* -> constant
 32:   LDC 1, 1(0)	load const
 33:    ST 1, -5(5)	op: push left
* <- constant
 34:    LD 0, -4(5)	
 35:    LD 1, -5(5)	
 36:   SUB 0, 0, 1	perform subtract operation
 37:    ST 0, -4(5)	storing operation result
* <- op
 38:    LD 0, -3(5)	retrieve result
 39:    ST 0, 0(1)	store result in variable
* <- assign
* <- compound
* <- while
* ---------------------------------------------------------> CALLEXP
* <- compound
 40:    LD 7, -1(5)	load return address
* <- fundecl
 41:   LDA 7, 29(7)	jump body
 42:    ST 5, -2(5)	push ofp
 43:   LDA 5, -2(5)	push frame
 44:   LDA 0, 1(7)	load ac with ret ptr
 45:   LDA 7, -34(7)	jump to main loc
 46:    LD 5, 0(5)	pop frame
* End of execution.
 47:  HALT 0, 0, 0	
