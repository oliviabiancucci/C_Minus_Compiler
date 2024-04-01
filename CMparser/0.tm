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
* processing function prototype: sub2
* <- fundecl
* -> fundecl
* processing function: add
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
 15:   LDC 0, 5(0)	load const
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
* -> call of function: sub2
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
 33:   ADD 0, 0, 1	op +
 34:    ST 0, -7(5)	storing operation result
* <- op
 35:    ST 5, -5(5)	push ofp
 36:   LDA 5, -5(5)	push frame
 37:   LDA 0, 1(7)	load ac with ret ptr
 39:    LD 5, 0(5)	pop frame
* <- call
 40:    ST 0, -3(5)	assign: store value
* <- assign
* -> assign
* -> constant
 41:   LDC 0, 69(0)	load const
 42:    ST 0, -5(5)	op: push left
* <- constant
 43:    LD 0, -5(5)	assign: load left
 44:    ST 0, -3(5)	assign: store value
* <- assign
* -> return
 45:    LD 0, -3(5)	load value in variable z
 46:    ST 0, -5(5)	store variable value on stack
* -> id
* looking up id: z
* <- id
 47:    ST 0, -5(5)	store return address in register 0
* <- return
* <- compound statement
* if: jump to else belongs here
* -> compound statement
* -> return
 49:    LD 0, -3(5)	load value in variable z
 50:    ST 0, -4(5)	store variable value on stack
* -> id
* looking up id: z
* <- id
 51:    ST 0, -4(5)	store return address in register 0
* <- return
* <- compound statement
 48:   LDA 7, 3(7)	if: jmp to end
 25:    LD 0, -4(5)	load result
 26:   JEQ 0, 22(7)	if: jmp to else
* <- if
* <- compound statement
 52:    LD 7, -1(5)	load return address
* <- fundecl
 11:   LDA 7, 41(7)	jump body
* -> fundecl
* processing function: sub2
* jump around function body
 38:   LDA 7, 15(7)	jump to fun loc
 54:    ST 0, -1(5)	store return
* processing local var: a -2
* -> compound statement
* processing local var: z -3
* -> if
* -> op
 55:    LD 0, -2(5)	load value in variable a
 56:    ST 0, -4(5)	store variable value on stack
* -> id
* looking up id: a
* <- id
* -> constant
 57:   LDC 0, 5(0)	load const
 58:    ST 0, -5(5)	op: push left
* <- constant
 59:    LD 0, -4(5)	
 60:    LD 1, -5(5)	
 61:   SUB 0, 0, 1	op >
 62:   JGT 0, 2(7)	br if true
 63:   LDC 0, 0(0)	false case
 64:   LDA 7, 1(7)	unconditional jump
 65:   LDC 0, 1(0)	true case
 66:    ST 0, -4(5)	storing operation result
* <- op
* -> compound statement
* -> assign
* -> call of function: add
* -> op
 69:    LD 0, -2(5)	load value in variable a
 70:    ST 0, -7(5)	store variable value on stack
* -> id
* looking up id: a
* <- id
* -> constant
 71:   LDC 0, 2(0)	load const
 72:    ST 0, -8(5)	op: push left
* <- constant
 73:    LD 0, -7(5)	
 74:    LD 1, -8(5)	
 75:   SUB 0, 0, 1	op -
 76:    ST 0, -7(5)	storing operation result
* <- op
 77:    ST 5, -5(5)	push ofp
 78:   LDA 5, -5(5)	push frame
 79:   LDA 0, 1(7)	load ac with ret ptr
 80:   LDA 7, -69(7)	jump to fun loc
 81:    LD 5, 0(5)	pop frame
* <- call
 82:    ST 0, -3(5)	assign: store value
* <- assign
* -> return
 83:    LD 0, -3(5)	load value in variable z
 84:    ST 0, -5(5)	store variable value on stack
* -> id
* looking up id: z
* <- id
 85:    ST 0, -5(5)	store return address in register 0
* <- return
* <- compound statement
* if: jump to else belongs here
* -> compound statement
* -> return
 87:    LD 0, -3(5)	load value in variable z
 88:    ST 0, -4(5)	store variable value on stack
* -> id
* looking up id: z
* <- id
 89:    ST 0, -4(5)	store return address in register 0
* <- return
* <- compound statement
 86:   LDA 7, 3(7)	if: jmp to end
 67:    LD 0, -4(5)	load result
 68:   JEQ 0, 18(7)	if: jmp to else
* <- if
* <- compound statement
 90:    LD 7, -1(5)	load return address
* <- fundecl
 53:   LDA 7, 37(7)	jump body
* -> fundecl
* processing function: main
* jump around function body
 92:    ST 0, -1(5)	store return
* -> compound statement
* processing local var: x -2
* processing local var: z -3
* -> assign
* -> constant
 93:   LDC 0, 8(0)	load const
 94:    ST 0, -4(5)	op: push left
* <- constant
 95:    LD 0, -4(5)	assign: load left
 96:    ST 0, -2(5)	assign: store value
* <- assign
* -> assign
* -> call of function: add
 97:    LD 0, -2(5)	load value in variable x
 98:    ST 0, -6(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
 99:    ST 5, -4(5)	push ofp
100:   LDA 5, -4(5)	push frame
101:   LDA 0, 1(7)	load ac with ret ptr
102:   LDA 7, -91(7)	jump to fun loc
103:    LD 5, 0(5)	pop frame
* <- call
104:    ST 0, -3(5)	assign: store value
* <- assign
* -> call of function: output
105:    LD 0, -3(5)	load value in variable z
106:    ST 0, -6(5)	store variable value on stack
* -> id
* looking up id: z
* <- id
107:    ST 5, -4(5)	push ofp
108:   LDA 5, -4(5)	push frame
109:   LDA 0, 1(7)	load ac with ret ptr
110:   LDA 7, -104(7)	jump to fun loc
111:    LD 5, 0(5)	pop frame
* <- call
* -> assign
* -> call of function: input
112:    ST 5, -4(5)	push ofp
113:   LDA 5, -4(5)	push frame
114:   LDA 0, 1(7)	load ac with ret ptr
115:   LDA 7, -112(7)	jump to fun loc
116:    LD 5, 0(5)	pop frame
* <- call
117:    ST 0, -2(5)	assign: store value
* <- assign
* -> call of function: output
118:    LD 0, -2(5)	load value in variable x
119:    ST 0, -6(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
120:    ST 5, -4(5)	push ofp
121:   LDA 5, -4(5)	push frame
122:   LDA 0, 1(7)	load ac with ret ptr
123:   LDA 7, -117(7)	jump to fun loc
124:    LD 5, 0(5)	pop frame
* <- call
* <- compound statement
125:    LD 7, -1(5)	load return address
* <- fundecl
 91:   LDA 7, 34(7)	jump body
126:    ST 5, -6(5)	push ofp
127:   LDA 5, -6(5)	push frame
128:   LDA 0, 1(7)	load ac with ret ptr
129:   LDA 7, -38(7)	jump to main loc
130:    LD 5, 0(5)	pop frame
* End of execution.
131:  HALT 0, 0, 0	
