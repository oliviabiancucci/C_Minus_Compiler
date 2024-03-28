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
  6:    ST 0, -3(5)	store declaration address
* -> constant
  7:   LDC 1, 10(0)	load const
  8:    ST 1, -4(5)	op: push left
* <- constant
  9:    LD 1, -4(5)	retrieve result
 10:    ST 0, 0(1)	store result in variable
* <- assign
* -> assign
* ---------------------------------------------------------> VAREXP
 11:   LDA 0, -2(5)	load declaration address: x
 12:    ST 0, -3(5)	store declaration address
* -> op
* -> constant
 13:   LDC 1, 5(0)	load const
 14:    ST 1, -4(5)	op: push left
* <- constant
* ---------------------------------------------------------> VAREXP
 15:   LDA 0, -3(5)	load declaration address: y
 16:    ST 0, -5(5)	store declaration address
 17:    LD 0, -4(5)	
 18:    LD 1, -5(5)	
 19:   ADD 0, 0, 1	perform add operation
 20:    ST 0, -4(5)	storing operation result
* <- op
 21:    LD 1, -4(5)	retrieve result
 22:    ST 0, 0(1)	store result in variable
* <- assign
* <- compound
 23:    LD 7, -1(5)	load return address
* <- fundecl
 24:   LDA 7, 20(7)	jump body
 25:    ST 5, -2(5)	push ofp
 26:   LDA 5, -2(5)	push frame
 27:   LDA 0, 1(7)	load ac with ret ptr
 28:   LDA 7, -25(7)	jump to main loc
 29:    LD 5, 0(5)	pop frame
* End of execution.
 30:  HALT 0, 0, 0	
