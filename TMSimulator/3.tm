* C-Minus Compilation to TM Code
* File: 3.tm
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
* -> funproto
* processing function prototype: add1
* <- funproto
* -> funproto
* processing function prototype: sub2
* <- funproto
* -> fundecl
* processing function: add1
* jump around function body
 12:    ST 0, -1(5)	store return
* -> vardeclist
* -> vardecl
* processing local var: x -2
* <- vardecl
* <- vardeclist
* -> compound statement
* -> vardeclist
* -> vardecl
* processing local var: y -3
* <- vardecl
* <- vardeclist
* FO: -4 GO: 0
* -> if
* -> op
 13:    LD 0, -2(5)	load value in variable x
 14:    ST 0, -4(5)	store variable value on stack
* -> id
* looking up id: x
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
* -> return
* -> call of function: sub2
* -> op
 27:    LD 0, -2(5)	load value in variable x
 28:    ST 0, -7(5)	store variable value on stack
* -> id
* looking up id: x
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
 40:    ST 0, -5(5)	store result on the stack
* <- call of functionsub2
 41:    LD 0, -5(5)	store returned value in register 0
* <- return
* <- compound statement
* if: jump to else belongs here
* -> compound statement
* -> return
 43:    LD 0, -2(5)	load value in variable x
 44:    ST 0, -4(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
 45:    LD 0, -4(5)	store returned value in register 0
* <- return
* <- compound statement
 42:   LDA 7, 3(7)	if: jmp to end
 25:    LD 0, -4(5)	load result
 26:   JEQ 0, 16(7)	if: jmp to else
* <- if
* <- compound statement
 46:    LD 7, -1(5)	load return address
* <- fundecl
 11:   LDA 7, 35(7)	jump body
* -> fundecl
* processing function: sub2
* jump around function body
 38:   LDA 7, 9(7)	jump to fun loc
 48:    ST 0, -1(5)	store return
* -> vardeclist
* -> vardecl
* processing local var: x -2
* <- vardecl
* <- vardeclist
* -> compound statement
* -> if
* -> op
 49:    LD 0, -2(5)	load value in variable x
 50:    ST 0, -3(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
* -> constant
 51:   LDC 0, 5(0)	load const
 52:    ST 0, -4(5)	op: push left
* <- constant
 53:    LD 0, -3(5)	
 54:    LD 1, -4(5)	
 55:   SUB 0, 0, 1	op >
 56:   JGT 0, 2(7)	br if true
 57:   LDC 0, 0(0)	false case
 58:   LDA 7, 1(7)	unconditional jump
 59:   LDC 0, 1(0)	true case
 60:    ST 0, -3(5)	storing operation result
* <- op
* -> compound statement
* -> return
* -> call of function: add1
* -> op
 63:    LD 0, -2(5)	load value in variable x
 64:    ST 0, -6(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
* -> constant
 65:   LDC 0, 2(0)	load const
 66:    ST 0, -7(5)	op: push left
* <- constant
 67:    LD 0, -6(5)	
 68:    LD 1, -7(5)	
 69:   SUB 0, 0, 1	op -
 70:    ST 0, -6(5)	storing operation result
* <- op
 71:    ST 5, -4(5)	push ofp
 72:   LDA 5, -4(5)	push frame
 73:   LDA 0, 1(7)	load ac with ret ptr
 74:   LDA 7, -63(7)	jump to fun loc
 75:    LD 5, 0(5)	pop frame
 76:    ST 0, -4(5)	store result on the stack
* <- call of functionadd1
 77:    LD 0, -4(5)	store returned value in register 0
* <- return
* <- compound statement
* if: jump to else belongs here
* -> compound statement
* -> return
 79:    LD 0, -2(5)	load value in variable x
 80:    ST 0, -3(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
 81:    LD 0, -3(5)	store returned value in register 0
* <- return
* <- compound statement
 78:   LDA 7, 3(7)	if: jmp to end
 61:    LD 0, -3(5)	load result
 62:   JEQ 0, 16(7)	if: jmp to else
* <- if
* <- compound statement
 82:    LD 7, -1(5)	load return address
* <- fundecl
 47:   LDA 7, 35(7)	jump body
* -> fundecl
* processing function: main
* jump around function body
 84:    ST 0, -1(5)	store return
* -> compound statement
* -> vardeclist
* -> vardecl
* processing local var: x -2
* <- vardecl
* <- vardeclist
* FO: -3 GO: 0
* -> assign
* -> constant
 85:   LDC 0, 8(0)	load const
 86:    ST 0, -3(5)	op: push left
* <- constant
 87:    LD 0, -3(5)	assign: load left
 88:    ST 0, -2(5)	assign: store value
* <- assign
* -> call of function: output
* -> call of function: add1
 89:    LD 0, -2(5)	load value in variable x
 90:    ST 0, -7(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
 91:    ST 5, -5(5)	push ofp
 92:   LDA 5, -5(5)	push frame
 93:   LDA 0, 1(7)	load ac with ret ptr
 94:   LDA 7, -83(7)	jump to fun loc
 95:    LD 5, 0(5)	pop frame
 96:    ST 0, -5(5)	store result on the stack
* <- call of functionadd1
 97:    ST 5, -3(5)	push ofp
 98:   LDA 5, -3(5)	push frame
 99:   LDA 0, 1(7)	load ac with ret ptr
100:   LDA 7, -94(7)	jump to fun loc
101:    LD 5, 0(5)	pop frame
* <- call of functionoutput
* <- compound statement
102:    LD 7, -1(5)	load return address
* <- fundecl
 83:   LDA 7, 19(7)	jump body
103:    ST 5, 0(5)	push ofp
104:   LDA 5, 0(5)	push frame
105:   LDA 0, 1(7)	load ac with ret ptr
106:   LDA 7, -23(7)	jump to main loc
107:    LD 5, 0(5)	pop frame
* End of execution.
108:  HALT 0, 0, 0	
