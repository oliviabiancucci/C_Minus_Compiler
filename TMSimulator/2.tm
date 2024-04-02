* C-Minus Compilation to TM Code
* File: 2.tm
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
* -> vardeclist
* -> vardecl
* processing local var: x -2
* <- vardecl
* -> vardecl
* processing local var: y -3
* <- vardecl
* <- vardeclist
* -> compound statement
* -> return
* -> op
 13:    LD 0, -2(5)	load value in variable x
 14:    ST 0, -4(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
 15:    LD 0, -3(5)	load value in variable y
 16:    ST 0, -5(5)	store variable value on stack
* -> id
* looking up id: y
* <- id
 17:    LD 0, -4(5)	
 18:    LD 1, -5(5)	
 19:   ADD 0, 0, 1	op +
 20:    ST 0, -4(5)	storing operation result
* <- op
 21:    ST 0, -4(5)	store returned value in register 0
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
* processing local var: y -3
* <- vardecl
* -> vardecl
* processing local var: fac -4
* <- vardecl
* -> vardecl
* processing local var: z -5
* <- vardecl
* <- vardeclist
* FO: -6 GO: 0
* -> assign
* -> op
* -> constant
 25:   LDC 0, 2(0)	load const
 26:    ST 0, -7(5)	op: push left
* <- constant
 27:    LD 0, -6(5)	
 28:    LD 1, -7(5)	
 29:    ST 0, -6(5)	storing operation result
* <- op
 30:    LD 0, -6(5)	assign: load left
 31:    ST 0, -4(5)	assign: store value
* <- assign
* -> assign
* -> constant
 32:   LDC 0, 7(0)	load const
 33:    ST 0, -6(5)	op: push left
* <- constant
 34:    LD 0, -6(5)	assign: load left
 35:    ST 0, -3(5)	assign: store value
* <- assign
* -> assign
* -> call of function: add
 36:    LD 0, -4(5)	load value in variable fac
 37:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: fac
* <- id
 38:    LD 0, -3(5)	load value in variable y
 39:    ST 0, -9(5)	store variable value on stack
* -> id
* looking up id: y
* <- id
 40:    ST 5, -6(5)	push ofp
 41:   LDA 5, -6(5)	push frame
 42:   LDA 0, 1(7)	load ac with ret ptr
 43:   LDA 7, -32(7)	jump to fun loc
 44:    LD 5, 0(5)	pop frame
 45:    ST 0, -6(5)	store result on the stack
* <- call
 46:    LD 0, -6(5)	assign: load left
 47:    ST 0, -2(5)	assign: store value
* <- assign
* -> assign
 48:   LDC 0, 1(0)	true condition
 49:    ST 0, -6(5)	
 50:    LD 0, -6(5)	assign: load left
 51:    ST 0, -5(5)	assign: store value
* <- assign
* -> call of function: output
 52:    LD 0, -4(5)	load value in variable fac
 53:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: fac
* <- id
 54:    ST 5, -6(5)	push ofp
 55:   LDA 5, -6(5)	push frame
 56:   LDA 0, 1(7)	load ac with ret ptr
 57:   LDA 7, -51(7)	jump to fun loc
 58:    LD 5, 0(5)	pop frame
* <- call
* -> if
* -> op
 59:    LD 0, -4(5)	load value in variable fac
 60:    ST 0, -6(5)	store variable value on stack
* -> id
* looking up id: fac
* <- id
* -> constant
 61:   LDC 0, 0(0)	load const
 62:    ST 0, -7(5)	op: push left
* <- constant
 63:    LD 0, -6(5)	
 64:    LD 1, -7(5)	
 65:   SUB 0, 0, 1	op <
 66:   JLT 0, 2(7)	br if true
 67:   LDC 0, 0(0)	false case
 68:   LDA 7, 1(7)	unconditional jump
 69:   LDC 0, 1(0)	true case
 70:    ST 0, -6(5)	storing operation result
* <- op
* -> compound statement
* -> if
* -> op
 73:    LD 0, -3(5)	load value in variable y
 74:    ST 0, -7(5)	store variable value on stack
* -> id
* looking up id: y
* <- id
* -> constant
 75:   LDC 0, 0(0)	load const
 76:    ST 0, -8(5)	op: push left
* <- constant
 77:    LD 0, -7(5)	
 78:    LD 1, -8(5)	
 79:   SUB 0, 0, 1	op >
 80:   JGT 0, 2(7)	br if true
 81:   LDC 0, 0(0)	false case
 82:   LDA 7, 1(7)	unconditional jump
 83:   LDC 0, 1(0)	true case
 84:    ST 0, -7(5)	storing operation result
* <- op
* -> compound statement
* -> assign
* -> constant
 87:   LDC 0, 420(0)	load const
 88:    ST 0, -8(5)	op: push left
* <- constant
 89:    LD 0, -8(5)	assign: load left
 90:    ST 0, -4(5)	assign: store value
* <- assign
* <- compound statement
 85:    LD 0, -7(5)	load result
 86:   JEQ 0, 4(7)	if: jmp to end
* <- if
* <- compound statement
* if: jump to else belongs here
* -> compound statement
* -> assign
* -> constant
 92:   LDC 0, 69(0)	load const
 93:    ST 0, -6(5)	op: push left
* <- constant
 94:    LD 0, -6(5)	assign: load left
 95:    ST 0, -4(5)	assign: store value
* <- assign
* <- compound statement
 91:   LDA 7, 4(7)	if: jmp to end
 71:    LD 0, -6(5)	load result
 72:   JEQ 0, 19(7)	if: jmp to else
* <- if
* -> call of function: output
 96:    LD 0, -4(5)	load value in variable fac
 97:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: fac
* <- id
 98:    ST 5, -6(5)	push ofp
 99:   LDA 5, -6(5)	push frame
100:   LDA 0, 1(7)	load ac with ret ptr
101:   LDA 7, -95(7)	jump to fun loc
102:    LD 5, 0(5)	pop frame
* <- call
* <- compound statement
103:    LD 7, -1(5)	load return address
* <- fundecl
 23:   LDA 7, 80(7)	jump body
104:    ST 5, 0(5)	push ofp
105:   LDA 5, 0(5)	push frame
106:   LDA 0, 1(7)	load ac with ret ptr
107:   LDA 7, -84(7)	jump to main loc
108:    LD 5, 0(5)	pop frame
* End of execution.
109:  HALT 0, 0, 0	
