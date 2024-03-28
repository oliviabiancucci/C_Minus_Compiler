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
* -> assign
* -> constant
 13:   LDC 0, 0(0)	load const
 14:    ST 0, -4(5)	op: push left
* <- constant
 15:    LD 0, -4(5)	retrieve result
 16:    ST 0, -2(5)	store result in variable
* <- assign
* -> if
* -> op
 17:    LD 0, -2(5)	load value in variable x
 18:    ST 0, -2(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
* -> constant
 19:   LDC 0, 0(0)	load const
 20:    ST 0, -3(5)	op: push left
* <- constant
 21:    LD 0, -2(5)	
 22:    LD 1, -3(5)	
 23:    ST 0, -2(5)	storing operation result
* <- op
* -> compound
* -> assign
* -> constant
 26:   LDC 0, 5(0)	load const
 27:    ST 0, -5(5)	op: push left
* <- constant
 28:    LD 0, -5(5)	retrieve result
 29:    ST 0, -2(5)	store result in variable
* <- assign
* <- compound
* if: jump to else belongs here
* ---------------------------------------------------------> NILEXP
 30:   LDA 7, 0(7)	if: jmp to end
 24:    LD 0, -2(5)	load result
 25:   JEQ 0, 4(7)	if: jmp to else
* <- if
* <- compound
 31:    LD 7, -1(5)	load return address
* <- fundecl
 32:   LDA 7, 20(7)	jump body
 33:    ST 5, -1(5)	push ofp
 34:   LDA 5, -1(5)	push frame
 35:   LDA 0, 1(7)	load ac with ret ptr
 36:   LDA 7, -25(7)	jump to main loc
 37:    LD 5, 0(5)	pop frame
* End of execution.
 38:  HALT 0, 0, 0	
