* C-Minus Compilation to TM Code
* File: gcd.tm
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
* allocated local var: y 0
* -> fundecl
* processing function: gcd
* jump around function body
 12:    ST 0, -1(5)	store return
* -> compound
* -> if
* <- if
* <- compound
 13:    LD 7, -1(5)	load return address
* <- fundecl
 14:   LDA 7, 2(7)	jump body
* -> fundecl
* processing function: main
* jump around function body
 16:    ST 0, -1(5)	store return
* -> compound
* allocated local var: x -2
* -> assign
* ---------------------------------------------------------> VAREXP
 17:   LDA 0, -2(5)	load declaration address: x
* ---------------------------------------------------------> CALLEXP
 18:    LD 0, -3(5)	retrieve result
 19:    ST 0, 0(1)	store result in variable
* <- assign
* -> assign
* ---------------------------------------------------------> VAREXP
 20:   LDA 0, 0(5)	load declaration address: y
* -> constant
 21:   LDC 1, 10(0)	load const
 22:    ST 1, -4(5)	op: push left
* <- constant
 23:    LD 0, -3(5)	retrieve result
 24:    ST 0, 0(1)	store result in variable
* <- assign
* ---------------------------------------------------------> CALLEXP
* <- compound
 25:    LD 7, -1(5)	load return address
* <- fundecl
 26:   LDA 7, 10(7)	jump body
 27:    ST 5, -1(5)	push ofp
 28:   LDA 5, -1(5)	push frame
 29:   LDA 0, 1(7)	load ac with ret ptr
 30:   LDA 7, -15(7)	jump to main loc
 31:    LD 5, 0(5)	pop frame
* End of execution.
 32:  HALT 0, 0, 0	
