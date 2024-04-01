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
* allocating global var: y
* <- vardecl
* -> fundecl
* processing function: gcd
* jump around function body
 12:    ST 0, -1(5)	store return
* processing local var: u -2
* processing local var: v -3
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
* -> return
 27:    LD 0, -2(5)	load value in variable u
 28:    ST 0, -5(5)	store variable value on stack
* -> id
* looking up id: u
* <- id
 29:    ST 0, -5(5)	store return address in register 0
* <- return
* if: jump to else belongs here
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
* <- call
 58:    ST 0, -4(5)	store return address in register 0
* <- return
 30:   LDA 7, 28(7)	if: jmp to end
 25:    LD 0, -4(5)	load result
 26:   JEQ 0, 4(7)	if: jmp to else
* <- if
* <- compound statement
 59:    LD 7, -1(5)	load return address
* <- fundecl
 11:   LDA 7, 48(7)	jump body
* -> fundecl
* processing function: main
* jump around function body
 61:    ST 0, -1(5)	store return
* -> compound statement
* processing local var: x -2
* -> assign
* -> call of function: input
 62:    ST 5, -3(5)	push ofp
 63:   LDA 5, -3(5)	push frame
 64:   LDA 0, 1(7)	load ac with ret ptr
 65:   LDA 7, -62(7)	jump to fun loc
 66:    LD 5, 0(5)	pop frame
* <- call
 67:    ST 0, -2(5)	assign: store value
* <- assign
* -> assign
* -> constant
 68:   LDC 0, 10(0)	load const
 69:    ST 0, -3(5)	op: push left
* <- constant
 70:    LD 0, -3(5)	assign: load left
 71:    ST 0, 0(5)	assign: store value
* <- assign
* -> call of function: output
* -> call of function: gcd
 72:    LD 0, -2(5)	load value in variable x
 73:    ST 0, -7(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
 74:    LD 0, 0(6)	load value in variable y
 75:    ST 0, -8(6)	store variable value on stack
* -> id
* looking up id: y
* <- id
 76:    ST 5, -5(5)	push ofp
 77:   LDA 5, -5(5)	push frame
 78:   LDA 0, 1(7)	load ac with ret ptr
 79:   LDA 7, -68(7)	jump to fun loc
 80:    LD 5, 0(5)	pop frame
* <- call
 81:    ST 5, -3(5)	push ofp
 82:   LDA 5, -3(5)	push frame
 83:   LDA 0, 1(7)	load ac with ret ptr
 84:   LDA 7, -78(7)	jump to fun loc
 85:    LD 5, 0(5)	pop frame
* <- call
* <- compound statement
 86:    LD 7, -1(5)	load return address
* <- fundecl
 60:   LDA 7, 26(7)	jump body
 87:    ST 5, -3(5)	push ofp
 88:   LDA 5, -3(5)	push frame
 89:   LDA 0, 1(7)	load ac with ret ptr
 90:   LDA 7, -30(7)	jump to main loc
 91:    LD 5, 0(5)	pop frame
* End of execution.
 92:  HALT 0, 0, 0	
