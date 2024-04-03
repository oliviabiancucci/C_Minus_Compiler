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
 21:    LD 0, -4(5)	store returned value in register 0
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
* -> call of function: add
 41:    LD 0, -4(5)	load value in variable fac
 42:    ST 0, -11(5)	store variable value on stack
* -> id
* looking up id: fac
* <- id
 43:    LD 0, -3(5)	load value in variable y
 44:    ST 0, -12(5)	store variable value on stack
* -> id
* looking up id: y
* <- id
 45:    ST 5, -9(5)	push ofp
 46:   LDA 5, -9(5)	push frame
 47:   LDA 0, 1(7)	load ac with ret ptr
 48:   LDA 7, -37(7)	jump to fun loc
 49:    LD 5, 0(5)	pop frame
 50:    ST 0, -9(5)	store result on the stack
* <- call of functionadd
 51:    ST 5, -6(5)	push ofp
 52:   LDA 5, -6(5)	push frame
 53:   LDA 0, 1(7)	load ac with ret ptr
 54:   LDA 7, -43(7)	jump to fun loc
 55:    LD 5, 0(5)	pop frame
 56:    ST 0, -6(5)	store result on the stack
* <- call of functionadd
 57:    LD 0, -6(5)	assign: load left
 58:    ST 0, -2(5)	assign: store value
* <- assign
* -> assign
 59:   LDC 0, 1(0)	true condition
 60:    ST 0, -6(5)	
 61:    LD 0, -6(5)	assign: load left
 62:    ST 0, -5(5)	assign: store value
* <- assign
* -> call of function: output
 63:    LD 0, -2(5)	load value in variable x
 64:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
 65:    ST 5, -6(5)	push ofp
 66:   LDA 5, -6(5)	push frame
 67:   LDA 0, 1(7)	load ac with ret ptr
 68:   LDA 7, -62(7)	jump to fun loc
 69:    LD 5, 0(5)	pop frame
* <- call of functionoutput
* -> if
* -> op
 70:    LD 0, -4(5)	load value in variable fac
 71:    ST 0, -6(5)	store variable value on stack
* -> id
* looking up id: fac
* <- id
* -> constant
 72:   LDC 0, 0(0)	load const
 73:    ST 0, -7(5)	op: push left
* <- constant
 74:    LD 0, -6(5)	
 75:    LD 1, -7(5)	
 76:   SUB 0, 0, 1	op <
 77:   JLT 0, 2(7)	br if true
 78:   LDC 0, 0(0)	false case
 79:   LDA 7, 1(7)	unconditional jump
 80:   LDC 0, 1(0)	true case
 81:    ST 0, -6(5)	storing operation result
* <- op
* -> compound statement
* -> if
* -> op
 84:    LD 0, -5(5)	load value in variable z
 85:    ST 0, -7(5)	store variable value on stack
* -> id
* looking up id: z
* <- id
 86:   LDC 0, 1(0)	true condition
 87:    ST 0, -8(5)	
 88:    LD 0, -7(5)	
 89:    LD 1, -8(5)	
 90:   SUB 0, 0, 1	op ==
 91:   JEQ 0, 2(7)	br if true
 92:   LDC 0, 0(0)	false case
 93:   LDA 7, 1(7)	unconditional jump
 94:   LDC 0, 1(0)	true case
 95:    ST 0, -7(5)	storing operation result
* <- op
* -> compound statement
* -> assign
* -> constant
 98:   LDC 0, 420(0)	load const
 99:    ST 0, -8(5)	op: push left
* <- constant
100:    LD 0, -8(5)	assign: load left
101:    ST 0, -4(5)	assign: store value
* <- assign
* <- compound statement
 96:    LD 0, -7(5)	load result
 97:   JEQ 0, 4(7)	if: jmp to end
* <- if
* <- compound statement
* if: jump to else belongs here
* -> compound statement
* -> assign
* -> constant
103:   LDC 0, 69(0)	load const
104:    ST 0, -6(5)	op: push left
* <- constant
105:    LD 0, -6(5)	assign: load left
106:    ST 0, -4(5)	assign: store value
* <- assign
* <- compound statement
102:   LDA 7, 4(7)	if: jmp to end
 82:    LD 0, -6(5)	load result
 83:   JEQ 0, 19(7)	if: jmp to else
* <- if
* -> call of function: output
107:    LD 0, -4(5)	load value in variable fac
108:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: fac
* <- id
109:    ST 5, -6(5)	push ofp
110:   LDA 5, -6(5)	push frame
111:   LDA 0, 1(7)	load ac with ret ptr
112:   LDA 7, -106(7)	jump to fun loc
113:    LD 5, 0(5)	pop frame
* <- call of functionoutput
* <- compound statement
114:    LD 7, -1(5)	load return address
* <- fundecl
 23:   LDA 7, 91(7)	jump body
115:    ST 5, 0(5)	push ofp
116:   LDA 5, 0(5)	push frame
117:   LDA 0, 1(7)	load ac with ret ptr
118:   LDA 7, -95(7)	jump to main loc
119:    LD 5, 0(5)	pop frame
* End of execution.
120:  HALT 0, 0, 0	
