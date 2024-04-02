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
 25:   LDC 0, 0(0)	load const
 26:    ST 0, -6(5)	op: push left
* <- constant
* -> constant
 27:   LDC 0, 2(0)	load const
 28:    ST 0, -7(5)	op: push left
* <- constant
 29:    LD 0, -6(5)	
 30:    LD 1, -7(5)	
 31:   SUB 0, 0, 1	op -
 32:    ST 0, -6(5)	storing operation result
* <- op
 33:    LD 0, -6(5)	assign: load left
 34:    ST 0, -4(5)	assign: store value
* <- assign
* -> assign
* -> constant
 35:   LDC 0, 7(0)	load const
 36:    ST 0, -6(5)	op: push left
* <- constant
 37:    LD 0, -6(5)	assign: load left
 38:    ST 0, -3(5)	assign: store value
* <- assign
* -> assign
* -> call of function: add
 39:    LD 0, -4(5)	load value in variable fac
 40:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: fac
* <- id
 41:    LD 0, -3(5)	load value in variable y
 42:    ST 0, -9(5)	store variable value on stack
* -> id
* looking up id: y
* <- id
 43:    ST 5, -6(5)	push ofp
 44:   LDA 5, -6(5)	push frame
 45:   LDA 0, 1(7)	load ac with ret ptr
 46:   LDA 7, -35(7)	jump to fun loc
 47:    LD 5, 0(5)	pop frame
 48:    ST 0, -6(5)	store result on the stack
* <- call
 49:    LD 0, -6(5)	assign: load left
 50:    ST 0, -2(5)	assign: store value
* <- assign
* -> assign
 51:   LDC 0, 1(0)	true condition
 52:    ST 0, -6(5)	
 53:    LD 0, -6(5)	assign: load left
 54:    ST 0, -5(5)	assign: store value
* <- assign
* -> call of function: output
 55:    LD 0, -4(5)	load value in variable fac
 56:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: fac
* <- id
 57:    ST 5, -6(5)	push ofp
 58:   LDA 5, -6(5)	push frame
 59:   LDA 0, 1(7)	load ac with ret ptr
 60:   LDA 7, -54(7)	jump to fun loc
 61:    LD 5, 0(5)	pop frame
* <- call
* -> if
* -> op
 62:    LD 0, -4(5)	load value in variable fac
 63:    ST 0, -6(5)	store variable value on stack
* -> id
* looking up id: fac
* <- id
* -> constant
 64:   LDC 0, 0(0)	load const
 65:    ST 0, -7(5)	op: push left
* <- constant
 66:    LD 0, -6(5)	
 67:    LD 1, -7(5)	
 68:   SUB 0, 0, 1	op <
 69:   JLT 0, 2(7)	br if true
 70:   LDC 0, 0(0)	false case
 71:   LDA 7, 1(7)	unconditional jump
 72:   LDC 0, 1(0)	true case
 73:    ST 0, -6(5)	storing operation result
* <- op
* -> compound statement
* -> if
* -> op
 76:    LD 0, -3(5)	load value in variable y
 77:    ST 0, -7(5)	store variable value on stack
* -> id
* looking up id: y
* <- id
* -> constant
 78:   LDC 0, 0(0)	load const
 79:    ST 0, -8(5)	op: push left
* <- constant
 80:    LD 0, -7(5)	
 81:    LD 1, -8(5)	
 82:   SUB 0, 0, 1	op >
 83:   JGT 0, 2(7)	br if true
 84:   LDC 0, 0(0)	false case
 85:   LDA 7, 1(7)	unconditional jump
 86:   LDC 0, 1(0)	true case
 87:    ST 0, -7(5)	storing operation result
* <- op
* -> compound statement
* -> assign
* -> constant
 90:   LDC 0, 420(0)	load const
 91:    ST 0, -8(5)	op: push left
* <- constant
 92:    LD 0, -8(5)	assign: load left
 93:    ST 0, -4(5)	assign: store value
* <- assign
* <- compound statement
 88:    LD 0, -7(5)	load result
 89:   JEQ 0, 4(7)	if: jmp to end
* <- if
* <- compound statement
* if: jump to else belongs here
* -> compound statement
* -> assign
* -> constant
 95:   LDC 0, 69(0)	load const
 96:    ST 0, -6(5)	op: push left
* <- constant
 97:    LD 0, -6(5)	assign: load left
 98:    ST 0, -4(5)	assign: store value
* <- assign
* <- compound statement
 94:   LDA 7, 4(7)	if: jmp to end
 74:    LD 0, -6(5)	load result
 75:   JEQ 0, 19(7)	if: jmp to else
* <- if
* -> call of function: output
 99:    LD 0, -4(5)	load value in variable fac
100:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: fac
* <- id
101:    ST 5, -6(5)	push ofp
102:   LDA 5, -6(5)	push frame
103:   LDA 0, 1(7)	load ac with ret ptr
104:   LDA 7, -98(7)	jump to fun loc
105:    LD 5, 0(5)	pop frame
* <- call
* <- compound statement
106:    LD 7, -1(5)	load return address
* <- fundecl
 23:   LDA 7, 83(7)	jump body
107:    ST 5, 0(5)	push ofp
108:   LDA 5, 0(5)	push frame
109:   LDA 0, 1(7)	load ac with ret ptr
110:   LDA 7, -87(7)	jump to main loc
111:    LD 5, 0(5)	pop frame
* End of execution.
112:  HALT 0, 0, 0	
