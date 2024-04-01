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
* processing function: add
* jump around function body
 12:    ST 0, -1(5)	store return
* -> compound statement
* processing local var: c -2
* -> op
* -> op
 13:    LD 0, 0(5)	load value in variable a
 14:    ST 0, -3(5)	store variable value on stack
* -> id
* looking up id: a
* <- id
 15:    LD 0, 0(5)	load value in variable b
 16:    ST 0, -4(5)	store variable value on stack
* -> id
* looking up id: b
* <- id
 17:    LD 0, -3(5)	
 18:    LD 1, -4(5)	
 19:   ADD 0, 0, 1	op +
 20:    ST 0, -3(5)	storing operation result
* <- op
 21:    LD 0, -3(5)	op: load left
 22:    ST 0, -2(5)	assign: store value
* <- op
* -> return
 23:    LD 0, -2(5)	load value in variable c
 24:    ST 0, -3(5)	store variable value on stack
* -> id
* looking up id: c
* <- id
 25:    LD 7, -1(7)	return to caller
* <- return
* <- compound statement
 26:    LD 7, -1(5)	load return address
* <- fundecl
 11:   LDA 7, 15(7)	jump body
* -> fundecl
* processing function: main
* jump around function body
 28:    ST 0, -1(5)	store return
* -> compound statement
* processing local var: x -2
* processing local var: y -3
* processing local var: z -4
* -> op
* -> constant
 29:   LDC 0, 1(0)	load const
 30:    ST 0, -5(5)	op: push left
* <- constant
 31:    LD 0, -5(5)	op: load left
 32:    ST 0, -2(5)	assign: store value
* <- op
* -> op
* -> constant
 33:   LDC 0, 69(0)	load const
 34:    ST 0, -5(5)	op: push left
* <- constant
 35:    LD 0, -5(5)	op: load left
 36:    ST 0, -3(5)	assign: store value
* <- op
* -> op
* -> call of function: add
 37:    LD 0, -2(5)	load value in variable x
 38:    ST 0, -7(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
 39:    LD 0, -3(5)	load value in variable y
 40:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: y
* <- id
 41:    ST 5, -5(5)	push ofp
 42:   LDA 5, -5(5)	push frame
 43:   LDA 0, 1(7)	load ac with ret ptr
 44:   LDA 7, -33(7)	jump to fun loc
 45:    LD 5, 0(5)	pop frame
* <- call
 46:    LD 0, -5(5)	op: load left
 47:    ST 0, -4(5)	assign: store value
* <- op
* <- compound statement
 48:    LD 7, -1(5)	load return address
* <- fundecl
 27:   LDA 7, 21(7)	jump body
 49:    ST 5, -4(5)	push ofp
 50:   LDA 5, -4(5)	push frame
 51:   LDA 0, 1(7)	load ac with ret ptr
 52:   LDA 7, -25(7)	jump to main loc
 53:    LD 5, 0(5)	pop frame
* End of execution.
 54:  HALT 0, 0, 0	
