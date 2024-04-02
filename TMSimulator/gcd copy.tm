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
* -> vardecl
* allocating global var: y 0
* <- vardecl
* -> fundecl
* processing function: gcd
* jump around function body
 12:    ST 0, -1(5)	store return
* -> vardeclist
* -> vardecl
* processing local var: u -2
* <- vardecl
* -> vardecl
* processing local var: v -3
* <- vardecl
* <- vardeclist
* -> compound statement
* -> if
* -> op
 13:    LD 0, -3(5)	load value in variable v
 14:    ST 0, -4(5)	store variable value on stack
* -> id
* looking up id: v
* <- id
* -> constant
 15:   LDC 0, 0(0)	load const
 16:    ST 0, -5(5)	op: push left
* <- constant
 17:    LD 0, -4(5)	
 18:    LD 1, -5(5)	
 19:   SUB 0, 0, 1	op ==
 20:   JEQ 0, 2(7)	br if true
 21:   LDC 0, 0(0)	false case
 22:   LDA 7, 1(7)	unconditional jump
 23:   LDC 0, 1(0)	true case
 24:    ST 0, -4(5)	storing operation result
* <- op
* -> compound statement
* -> return
 27:    LD 0, -2(5)	load value in variable u
 28:    ST 0, -5(5)	store variable value on stack
* -> id
* looking up id: u
* <- id
 29:    ST 0, -5(5)	store returned value in register 0
* <- return
* <- compound statement
* if: jump to else belongs here
* -> compound statement
* -> return
* -> call of function: gcd
 31:    LD 0, -3(5)	load value in variable v
 32:    ST 0, -6(5)	store variable value on stack
* -> id
* looking up id: v
* <- id
* -> op
 33:    LD 0, -2(5)	load value in variable u
 34:    ST 0, -7(5)	store variable value on stack
* -> id
* looking up id: u
* <- id
* -> op
* -> op
 35:    LD 0, -2(5)	load value in variable u
 36:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: u
* <- id
 37:    LD 0, -3(5)	load value in variable v
 38:    ST 0, -9(5)	store variable value on stack
* -> id
* looking up id: v
* <- id
 39:    LD 0, -8(5)	
 40:    LD 1, -9(5)	
 41:   DIV 0, 0, 1	op /
 42:    ST 0, -8(5)	storing operation result
* <- op
 43:    LD 0, -3(5)	load value in variable v
 44:    ST 0, -9(5)	store variable value on stack
* -> id
* looking up id: v
* <- id
 45:    LD 0, -8(5)	
 46:    LD 1, -9(5)	
 47:   MUL 0, 0, 1	op *
 48:    ST 0, -8(5)	storing operation result
* <- op
 49:    LD 0, -7(5)	
 50:    LD 1, -8(5)	
 51:   SUB 0, 0, 1	op -
 52:    ST 0, -7(5)	storing operation result
* <- op
 53:    ST 5, -4(5)	push ofp
 54:   LDA 5, -4(5)	push frame
 55:   LDA 0, 1(7)	load ac with ret ptr
 56:   LDA 7, -45(7)	jump to fun loc
 57:    LD 5, 0(5)	pop frame
 58:    ST 0, -4(5)	store result on the stack
* <- call
 59:    ST 0, -4(5)	store returned value in register 0
* <- return
* <- compound statement
 30:   LDA 7, 29(7)	if: jmp to end
 25:    LD 0, -4(5)	load result
 26:   JEQ 0, 4(7)	if: jmp to else
* <- if
* <- compound statement
 60:    LD 7, -1(5)	load return address
* <- fundecl
 11:   LDA 7, 49(7)	jump body
* -> fundecl
* processing function: main
* jump around function body
 62:    ST 0, -1(5)	store return
* -> compound statement
* -> vardeclist
* -> vardecl
* processing local var: x -2
* <- vardecl
* <- vardeclist
* FO: -3 GO: -1
* -> assign
* -> call of function: input
 63:    ST 5, -3(5)	push ofp
 64:   LDA 5, -3(5)	push frame
 65:   LDA 0, 1(7)	load ac with ret ptr
 66:   LDA 7, -63(7)	jump to fun loc
 67:    LD 5, 0(5)	pop frame
 68:    ST 0, -3(5)	store result on the stack
* <- call
 69:    LD 0, -3(5)	assign: load left
 70:    ST 0, -2(5)	assign: store value
* <- assign
* -> assign
* -> constant
 71:   LDC 0, 10(0)	load const
 72:    ST 0, -3(5)	op: push left
* <- constant
 73:    LD 0, -3(5)	assign: load left
 74:    ST 0, 0(6)	assign: store value
* <- assign
* -> call of function: output
* -> call of function: gcd
 75:    LD 0, -2(5)	load value in variable x
 76:    ST 0, -7(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
 77:    LD 0, 0(6)	load value in variable y
 78:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: y
* <- id
 79:    ST 5, -5(5)	push ofp
 80:   LDA 5, -5(5)	push frame
 81:   LDA 0, 1(7)	load ac with ret ptr
 82:   LDA 7, -71(7)	jump to fun loc
 83:    LD 5, 0(5)	pop frame
 84:    ST 0, -5(5)	store result on the stack
* <- call
 85:    ST 5, -3(5)	push ofp
 86:   LDA 5, -3(5)	push frame
 87:   LDA 0, 1(7)	load ac with ret ptr
 88:   LDA 7, -82(7)	jump to fun loc
 89:    LD 5, 0(5)	pop frame
* <- call
* <- compound statement
 90:    LD 7, -1(5)	load return address
* <- fundecl
 61:   LDA 7, 29(7)	jump body
 91:    ST 5, -1(5)	push ofp
 92:   LDA 5, -1(5)	push frame
 93:   LDA 0, 1(7)	load ac with ret ptr
 94:   LDA 7, -33(7)	jump to main loc
 95:    LD 5, 0(5)	pop frame
* End of execution.
 96:  HALT 0, 0, 0	
