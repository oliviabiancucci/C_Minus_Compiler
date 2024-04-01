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
* sub2 0
 39:    LD 5, 0(5)	pop frame
* <- call
 40:    ST 0, -3(5)	assign: store value
* <- assign
* -> return
 41:    LD 0, -3(5)	load value in variable z
 42:    ST 0, -5(5)	store variable value on stack
* -> id
* looking up id: z
* <- id
 43:    ST 0, -5(5)	store return address in register 0
* <- return
* <- compound statement
* if: jump to else belongs here
* -> compound statement
* -> return
 45:    LD 0, -3(5)	load value in variable z
 46:    ST 0, -4(5)	store variable value on stack
* -> id
* looking up id: z
* <- id
 47:    ST 0, -4(5)	store return address in register 0
* <- return
* <- compound statement
 44:   LDA 7, 3(7)	if: jmp to end
 25:    LD 0, -4(5)	load result
 26:   JEQ 0, 18(7)	if: jmp to else
* <- if
* <- compound statement
 48:    LD 7, -1(5)	load return address
* <- fundecl
 11:   LDA 7, 37(7)	jump body
* -> fundecl
* processing function: sub2
* jump around function body
 38:   LDA 7, 11(7)	jump to fun loc
 50:    ST 0, -1(5)	store return
* processing local var: a -2
* -> compound statement
* processing local var: z -3
* -> if
* -> op
 51:    LD 0, -2(5)	load value in variable a
 52:    ST 0, -4(5)	store variable value on stack
* -> id
* looking up id: a
* <- id
* -> constant
 53:   LDC 0, 5(0)	load const
 54:    ST 0, -5(5)	op: push left
* <- constant
 55:    LD 0, -4(5)	
 56:    LD 1, -5(5)	
 57:   SUB 0, 0, 1	op >
 58:   JGT 0, 2(7)	br if true
 59:   LDC 0, 0(0)	false case
 60:   LDA 7, 1(7)	unconditional jump
 61:   LDC 0, 1(0)	true case
 62:    ST 0, -4(5)	storing operation result
* <- op
* -> compound statement
* -> assign
* -> call of function: add
* -> op
 65:    LD 0, -2(5)	load value in variable a
 66:    ST 0, -7(5)	store variable value on stack
* -> id
* looking up id: a
* <- id
* -> constant
 67:   LDC 0, 2(0)	load const
 68:    ST 0, -8(5)	op: push left
* <- constant
 69:    LD 0, -7(5)	
 70:    LD 1, -8(5)	
 71:   SUB 0, 0, 1	op -
 72:    ST 0, -7(5)	storing operation result
* <- op
 73:    ST 5, -5(5)	push ofp
 74:   LDA 5, -5(5)	push frame
 75:   LDA 0, 1(7)	load ac with ret ptr
* add 12
 76:   LDA 7, -65(7)	jump to fun loc
 77:    LD 5, 0(5)	pop frame
* <- call
 78:    ST 0, -3(5)	assign: store value
* <- assign
* -> return
 79:    LD 0, -3(5)	load value in variable z
 80:    ST 0, -5(5)	store variable value on stack
* -> id
* looking up id: z
* <- id
 81:    ST 0, -5(5)	store return address in register 0
* <- return
* <- compound statement
* if: jump to else belongs here
* -> compound statement
* -> return
 83:    LD 0, -3(5)	load value in variable z
 84:    ST 0, -4(5)	store variable value on stack
* -> id
* looking up id: z
* <- id
 85:    ST 0, -4(5)	store return address in register 0
* <- return
* <- compound statement
 82:   LDA 7, 3(7)	if: jmp to end
 63:    LD 0, -4(5)	load result
 64:   JEQ 0, 18(7)	if: jmp to else
* <- if
* <- compound statement
 86:    LD 7, -1(5)	load return address
* <- fundecl
 49:   LDA 7, 37(7)	jump body
* -> fundecl
* processing function: main
* jump around function body
 88:    ST 0, -1(5)	store return
* -> compound statement
* processing local var: x -2
* processing local var: z -3
* -> assign
* -> constant
 89:   LDC 0, 8(0)	load const
 90:    ST 0, -4(5)	op: push left
* <- constant
 91:    LD 0, -4(5)	assign: load left
 92:    ST 0, -2(5)	assign: store value
* <- assign
* -> assign
* -> call of function: add
 93:    LD 0, -2(5)	load value in variable x
 94:    ST 0, -6(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
 95:    ST 5, -4(5)	push ofp
 96:   LDA 5, -4(5)	push frame
 97:   LDA 0, 1(7)	load ac with ret ptr
* add 12
 98:   LDA 7, -87(7)	jump to fun loc
 99:    LD 5, 0(5)	pop frame
* <- call
100:    ST 0, -3(5)	assign: store value
* <- assign
* <- compound statement
101:    LD 7, -1(5)	load return address
* <- fundecl
 87:   LDA 7, 14(7)	jump body
102:    ST 5, -6(5)	push ofp
103:   LDA 5, -6(5)	push frame
104:   LDA 0, 1(7)	load ac with ret ptr
105:   LDA 7, -18(7)	jump to main loc
106:    LD 5, 0(5)	pop frame
* End of execution.
107:  HALT 0, 0, 0	
