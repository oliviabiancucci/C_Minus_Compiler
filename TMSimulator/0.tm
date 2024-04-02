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
* processing function prototype: add
* <- fundecl
* -> fundecl
* processing function: add
* jump around function body
 12:    ST 0, -1(5)	store return
* -> vardeclist
* -> vardecl
* processing local var: a -2
* <- vardecl
* <- vardeclist
* -> compound statement
* -> return
* -> op
 13:    LD 0, -2(5)	load value in variable a
 14:    ST 0, -3(5)	store variable value on stack
* -> id
* looking up id: a
* <- id
* -> constant
 15:   LDC 0, 2(0)	load const
 16:    ST 0, -4(5)	op: push left
* <- constant
 17:    LD 0, -3(5)	
 18:    LD 1, -4(5)	
 19:   ADD 0, 0, 1	op +
 20:    ST 0, -3(5)	storing operation result
* <- op
 21:    ST 0, -3(5)	store returned value in register 0
* <- return
* <- compound statement
 22:    LD 7, -1(5)	load return address
* <- fundecl
 11:   LDA 7, 11(7)	jump body
* -> fundecl
* processing function: main
* jump around function body
 24:    ST 0, -1(5)	store return
* -> compound statement
* -> vardeclist
* -> vardecl
* processing local var: x -2
* <- vardecl
* -> vardecl
* processing local var: z -3
* <- vardecl
* <- vardeclist
* FO: -4 GO: 0
* -> assign
* -> constant
 25:   LDC 0, 8(0)	load const
 26:    ST 0, -4(5)	op: push left
* <- constant
 27:    LD 0, -4(5)	assign: load left
 28:    ST 0, -2(5)	assign: store value
* <- assign
* -> call of function: output
* -> call of function: add
 29:    LD 0, -2(5)	load value in variable x
 30:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
 31:    ST 5, -6(5)	push ofp
 32:   LDA 5, -6(5)	push frame
 33:   LDA 0, 1(7)	load ac with ret ptr
 34:   LDA 7, -23(7)	jump to fun loc
 35:    LD 5, 0(5)	pop frame
 36:    ST 0, -6(5)	store result on the stack
* <- call
 37:    ST 5, -4(5)	push ofp
 38:   LDA 5, -4(5)	push frame
 39:   LDA 0, 1(7)	load ac with ret ptr
 40:   LDA 7, -34(7)	jump to fun loc
 41:    LD 5, 0(5)	pop frame
* <- call
* <- compound statement
 42:    LD 7, -1(5)	load return address
* <- fundecl
 23:   LDA 7, 19(7)	jump body
 43:    ST 5, 0(5)	push ofp
 44:   LDA 5, 0(5)	push frame
 45:   LDA 0, 1(7)	load ac with ret ptr
 46:   LDA 7, -23(7)	jump to main loc
 47:    LD 5, 0(5)	pop frame
* End of execution.
 48:  HALT 0, 0, 0	
