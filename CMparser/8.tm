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
 15:    LD 0, -2(5)	load value in array x
 16:    ST 0, -7(5)	store variable value on stack
* -> constant
 17:   LDC 0, 0(0)	load const
 18:    ST 0, -7(5)	op: push left
* <- constant
 19:    LD 0, -7(5)	load value in array x
 20:    ST 0, -2(5)	store variable value on stack
* <- assign
* -> assign
* -> constant
 21:   LDC 0, 1(0)	load const
 22:    ST 0, -7(5)	op: push left
* <- constant
 23:    LD 0, -3(5)	load value in array x
 24:    ST 0, -7(5)	store variable value on stack
* -> constant
 25:   LDC 0, 1(0)	load const
 26:    ST 0, -7(5)	op: push left
* <- constant
 27:    LD 0, -7(5)	load value in array x
 28:    ST 0, -3(5)	store variable value on stack
* <- assign
* -> assign
* -> constant
 29:   LDC 0, 2(0)	load const
 30:    ST 0, -7(5)	op: push left
* <- constant
 31:    LD 0, -4(5)	load value in array x
 32:    ST 0, -7(5)	store variable value on stack
* -> constant
 33:   LDC 0, 2(0)	load const
 34:    ST 0, -7(5)	op: push left
* <- constant
 35:    LD 0, -7(5)	load value in array x
 36:    ST 0, -4(5)	store variable value on stack
* <- assign
* -> assign
* -> constant
 37:   LDC 0, 3(0)	load const
 38:    ST 0, -7(5)	op: push left
* <- constant
 39:    LD 0, -5(5)	load value in array x
 40:    ST 0, -7(5)	store variable value on stack
* -> constant
 41:   LDC 0, 3(0)	load const
 42:    ST 0, -7(5)	op: push left
* <- constant
 43:    LD 0, -7(5)	load value in array x
 44:    ST 0, -5(5)	store variable value on stack
* <- assign
* -> assign
* -> constant
 45:   LDC 0, 4(0)	load const
 46:    ST 0, -7(5)	op: push left
* <- constant
 47:    LD 0, -6(5)	load value in array x
 48:    ST 0, -7(5)	store variable value on stack
* -> constant
 49:   LDC 0, 4(0)	load const
 50:    ST 0, -7(5)	op: push left
* <- constant
 51:    LD 0, -7(5)	load value in array x
 52:    ST 0, -6(5)	store variable value on stack
* <- assign
* -> assign
 53:    LD 0, -6(5)	load value in array x
 54:    ST 0, -7(5)	store variable value on stack
* -> constant
 55:   LDC 0, 4(0)	load const
 56:    ST 0, -7(5)	op: push left
* <- constant
