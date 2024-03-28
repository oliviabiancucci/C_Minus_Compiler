* C-Minus Compilation to TM Code
* File: 0.tm
* Standard prelude:
  0:    LD 6, 0(0)	load gp with maxaddress
  1:   LDA 5, 0(6)	copy to gp to fp
  2:    ST 0, 0(0)	clear location 0
* Jump around i/o routines here
* code for input routine
  4:    ST 0, -1(5)	store return
  5:    IN 0, 0(0)	input
  6:    LD 7, -1(5)	return to caller
* code for output routine
  7:    ST 0, -1(5)	store return
  8:    LD 0, -2(5)	load output value
  9:   OUT 0, 0(0)	output
 10:    LD 7, -1(5)	return to caller
  7:   LDA 7, 3(7)	jump around i/o code
* End of standard prelude.
* -> fundecl
* processing function: main
* jump around function body
 12:    ST 0, -1(5)	store return
* -> compound
* allocating global var: x
* ---------------------------------------------------------> EXPLIST
* -> assign
* <- assign
* <- compound
 13:    LD 7, -1(5)	load return address
* <- fundecl
 14:   LDA 7, 2(7)	jump body
 15:    ST 5, -1(5)	push ofp
 16:   LDA 5, -1(5)	push frame
 17:   LDA 0, 1(7)	load ac with ret ptr
 18:   LDA 7, -7(7)	jump to main loc
 19:    LD 5, 0(5)	pop frame
* End of execution.
 20:  HALT 0, 0, 0	
