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
* processing function: rec
* jump around function body
 12:    ST 0, -1(5)	store return
* processing local var: a -2
* -> compound statement
* processing local var: z -3
* -> if
* -> op
 13:    LD 0, -2(5)	load value in variable a
 14:    ST 0, -4(5)	store variable value on stack
* -> id
* looking up id: a
* <- id
* -> constant
 15:   LDC 0, 3(0)	load const
 16:    ST 0, -5(5)	op: push left
* <- constant
 17:    LD 0, -4(5)	
 18:    LD 1, -5(5)	
 19:   SUB 0, 0, 1	op >
 20:   JGT 0, 2(7)	br if true
 21:   LDC 0, 0(0)	false case
 22:   LDA 7, 1(7)	unconditional jump
 23:   LDC 0, 1(0)	true case
 24:    ST 0, -4(5)	storing operation result
* <- op
* -> compound statement
* -> assign
* -> call of function: rec
* -> op
 27:    LD 0, -2(5)	load value in variable a
 28:    ST 0, -7(5)	store variable value on stack
* -> id
* looking up id: a
* <- id
* -> constant
 29:   LDC 0, 1(0)	load const
 30:    ST 0, -8(5)	op: push left
* <- constant
 31:    LD 0, -7(5)	
 32:    LD 1, -8(5)	
 33:   SUB 0, 0, 1	op -
 34:    ST 0, -7(5)	storing operation result
* <- op
 35:    ST 5, -5(5)	push ofp
 36:   LDA 5, -5(5)	push frame
 37:   LDA 0, 1(7)	load ac with ret ptr
 38:   LDA 7, -27(7)	jump to fun loc
 39:    LD 5, 0(5)	pop frame
* <- call
 40:    ST 0, -3(5)	assign: store value
* <- assign
* <- compound statement
* if: jump to else belongs here
* -> compound statement
* -> return
* -> constant
 42:   LDC 0, 69(0)	load const
 43:    ST 0, -4(5)	op: push left
* <- constant
 44:    ST 0, -4(5)	store return address in register 0
 45:    LD 7, -1(5)	load return address
* <- return
* <- compound statement
 41:   LDA 7, 4(7)	if: jmp to end
 25:    LD 0, -4(5)	load result
 26:   JEQ 0, 15(7)	if: jmp to else
* <- if
* <- compound statement
* <- fundecl
 11:   LDA 7, 34(7)	jump body
* -> fundecl
* processing function: main
* jump around function body
 47:    ST 0, -1(5)	store return
* Function Parameters are null
* -> compound statement
* processing local var: x -2
* processing local var: z -3
* -> assign
* -> constant
 48:   LDC 0, 5(0)	load const
 49:    ST 0, -4(5)	op: push left
* <- constant
 50:    LD 0, -4(5)	assign: load left
 51:    ST 0, -2(5)	assign: store value
* <- assign
* -> assign
* -> call of function: rec
 52:    LD 0, -2(5)	load value in variable x
 53:    ST 0, -6(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
 54:    ST 5, -4(5)	push ofp
 55:   LDA 5, -4(5)	push frame
 56:   LDA 0, 1(7)	load ac with ret ptr
 57:   LDA 7, -46(7)	jump to fun loc
 58:    LD 5, 0(5)	pop frame
* <- call
 59:    ST 0, -3(5)	assign: store value
* <- assign
* <- compound statement
* <- fundecl
 46:   LDA 7, 13(7)	jump body
 60:    ST 5, -4(5)	push ofp
 61:   LDA 5, -4(5)	push frame
 62:   LDA 0, 1(7)	load ac with ret ptr
 63:   LDA 7, -17(7)	jump to main loc
 64:    LD 5, 0(5)	pop frame
* End of execution.
 65:  HALT 0, 0, 0	
