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
* ---------------------------------------------------------> VAREXP
  5:   LDA 0, -3(5)	load declaration address: y
* -> constant
  6:   LDC 1, 10(0)	load const
  7:    ST 1, -3(5)	op: push left
* <- constant
  8:    LD 1, -3(5)	retrieve result
  9:    ST 0, 0(1)	store result in variable
* <- assign
* -> assign
* ---------------------------------------------------------> VAREXP
 10:   LDA 0, -2(5)	load declaration address: x
* -> op
* -> constant
 11:   LDC 1, 5(0)	load const
 12:    ST 1, -3(5)	op: push left
* <- constant
* ---------------------------------------------------------> VAREXP
 13:   LDA 0, -3(5)	load declaration address: y
 14:    LD 0, -3(5)	
 15:    LD 1, -4(5)	
 16:   ADD 0, 0, 1	perform add operation
 17:    ST 0, -3(5)	storing operation result
* <- op
 18:    LD 1, -3(5)	retrieve result
 19:    ST 0, 0(1)	store result in variable
* <- assign
* <- compound
 20:    LD 7, -1(5)	load return address
* <- fundecl
 21:   LDA 7, 17(7)	jump body
 22:    ST 5, -2(5)	push ofp
 23:   LDA 5, -2(5)	push frame
 24:   LDA 0, 1(7)	load ac with ret ptr
 25:   LDA 7, -22(7)	jump to main loc
 26:    LD 5, 0(5)	pop frame
* End of execution.
 27:  HALT 0, 0, 0	
