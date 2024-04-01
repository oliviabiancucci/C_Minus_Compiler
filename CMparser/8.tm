* C-Minus Compilation to TM Code
* File: 8.tm
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
* processing local array: x -2
* -> assign
* -> constant
 13:   LDC 0, 0(0)	load const
 14:    ST 0, -7(5)	op: push left
* <- constant
 15:    LD 0, -7(5)	load value in array x
 16:    ST 0, -2(5)	store variable value on stack
* <- assign
* -> assign
* -> constant
 17:   LDC 0, 1(0)	load const
 18:    ST 0, -7(5)	op: push left
* <- constant
 19:    LD 0, -7(5)	load value in array x
 20:    ST 0, -3(5)	store variable value on stack
* <- assign
* -> assign
* -> constant
 21:   LDC 0, 2(0)	load const
 22:    ST 0, -7(5)	op: push left
* <- constant
 23:    LD 0, -7(5)	load value in array x
 24:    ST 0, -4(5)	store variable value on stack
* <- assign
* -> assign
* -> constant
 25:   LDC 0, 3(0)	load const
 26:    ST 0, -7(5)	op: push left
* <- constant
 27:    LD 0, -7(5)	load value in array x
 28:    ST 0, -5(5)	store variable value on stack
* <- assign
* -> assign
* -> constant
 29:   LDC 0, 4(0)	load const
 30:    ST 0, -7(5)	op: push left
* <- constant
 31:    LD 0, -7(5)	load value in array x
 32:    ST 0, -6(5)	store variable value on stack
* <- assign
* -> assign
 33:    LD 0, -6(5)	load value in array x
 34:    ST 0, -7(5)	store variable value on stack
* -> constant
 35:   LDC 0, 4(0)	load const
 36:    ST 0, -7(5)	op: push left
* <- constant
 37:    LD 0, -7(5)	load value in array x
 38:    ST 0, -2(5)	store variable value on stack
* <- assign
* <- compound statement
 39:    LD 7, -1(5)	load return address
* <- fundecl
 11:   LDA 7, 28(7)	jump body
 40:    ST 5, 0(5)	push ofp
 41:   LDA 5, 0(5)	push frame
 42:   LDA 0, 1(7)	load ac with ret ptr
 43:   LDA 7, -32(7)	jump to main loc
 44:    LD 5, 0(5)	pop frame
* End of execution.
 45:  HALT 0, 0, 0	
