* C-Minus Compilation to TM Code
* File: 0.tm
* Standard prelude:
  0:    LD 6, 0(0)	load gp with maxaddress
  1:   LDA 5, 0(6)	copy to gp to fp
  2:    ST 0, 0(0)	clear location 0
* Jump around i/o routines here
* End of standard prelude.
* -> fundecl
* processing function: main
* jump around function body
  4:    ST 0, -1(5)	store return
* -> compound
* allocated local var: x -2
* allocated local var: y -3
* -> assign
* -> constant
  5:   LDC 1, 10(0)	load const
  6:    ST 1, -3(5)	op: push left
* <- constant
* ---------------------------------------------------------> VAREXP
  7:   LDA 0, -3(5)	load declaration address: y
  8:    ST 0, 0(1)	store result in variable
* <- assign
* -> assign
* -> op
* -> constant
  9:   LDC 1, 5(0)	load const
 10:  
* <- constant
* ---------------------------------------------------------> VAREXP
 11:   LDA 0, -3(5)	load declaration address: y
 12:    LD 0, -3(5)	
 13:    LD 1, -4(5)	
 14:   ADD 0, 0, 1	perform add operation
 15:    ST 0, -3(5)	storing operation result
* <- op
* ---------------------------------------------------------> VAREXP
 16:   LDA 0, -2(5)	load declaration address: x
 17:    ST 0, 0(1)	store result in variable
* <- assign
* <- compound
 18:    LD 7, -1(5)	load return address
* <- fundecl
 19:   LDA 7, 15(7)	jump body
 20:    ST 5, -2(5)	push ofp
 21:   LDA 5, -2(5)	push frame
 22:   LDA 0, 1(7)	load ac with ret ptr
 23:   LDA 7, -20(7)	jump to main loc
 24:    LD 5, 0(5)	pop frame
* End of execution.
 25:  HALT 0, 0, 0	
