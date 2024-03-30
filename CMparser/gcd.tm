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
* processing local var: y 0
* -> fundecl
* processing function: gcd
* jump around function body
 12:    ST 0, -1(5)	store return
* -> compound statement
* -> if
* -> op
* -> id
* looking up id: v
 13:    LD 0, -2(5)	load id value
* <- id
* -> constant
 14:   LDC 0, 0(0)	load const
* <- constant
 15:    LD 0, -2(5)	
 16:    LD 1, -3(5)	
* <- op
* -> return
* -> id
* looking up id: u
 19:    LD 0, -3(5)	load id value
* <- id
 20:    LD 7, -1(77)	return to caller
* <- return
* if: jump to else belongs here
* -> return
* -> call of function: gcd
* -> id
* looking up id: v
 22:    LD 0, -2(5)	load id value
* <- id
* -> op
* -> id
* looking up id: u
 23:    LD 0, -2(5)	load id value
* <- id
* -> op
* -> op
* -> id
* looking up id: u
 24:    LD 0, -3(5)	load id value
* <- id
* -> id
* looking up id: v
 25:    LD 0, -4(5)	load id value
* <- id
 26:    LD 0, -3(5)	
 27:    LD 1, -4(5)	
 28:   DIV 0, 0, 1	op /
* <- op
* -> id
* looking up id: v
 29:    LD 0, -4(5)	load id value
* <- id
 30:    LD 0, -3(5)	
 31:    LD 1, -4(5)	
 32:   MUL 0, 0, 1	op *
* <- op
 33:    LD 0, -2(5)	
 34:    LD 1, -3(5)	
 35:   SUB 0, 0, 1	op -
* <- op
 36:    ST 5, -2(5)	push ofp
 37:   LDA 5, -2(5)	push frame
 38:   LDA 0, 1(7)	load ac with ret ptr
 39:   LDA 7, -28(7)	jump to fun loc
 40:    LD 5, 0(5)	pop frame
* <- call
 41:    LD 7, -1(77)	return to caller
* <- return
 21:   LDA 7, 20(7)	if: jmp to end
 17:    LD 0, -2(5)	load result
 18:   JEQ 0, 2(7)	if: jmp to else
* <- if
* <- compound statement
 42:    LD 7, -1(5)	load return address
* <- fundecl
 43:   LDA 7, -5(7)	jump body
* -> fundecl
* processing function: main
* jump around function body
 45:    ST 0, -1(5)	store return
* -> compound statement
* processing local var: x -2
* -> op
* -> id
* looking up id: x
 46:   LDA 0, -3(5)	load id address
* <- id
 47:    ST 0, -3(5)	op: push left
* -> call of function: input
 48:    ST 5, -3(5)	push ofp
 49:   LDA 5, -3(5)	push frame
 50:   LDA 0, 1(7)	load ac with ret ptr
 51:   LDA 7, -52(7)	jump to fun loc
 52:    LD 5, 0(5)	pop frame
* <- call
 53:    LD 0, -3(5)	op: load left
 54:    ST 0, -2(5)	assign: store value
* <- op
* -> op
* -> id
* looking up id: y
 55:   LDA 0, -3(5)	load id address
* <- id
 56:    ST 0, -3(5)	op: push left
* -> constant
 57:   LDC 0, 10(0)	load const
* <- constant
 58:    LD 0, -3(5)	op: load left
 59:    ST 0, 0(5)	assign: store value
* <- op
* -> call of function: output
* -> call of function: gcd
* -> id
* looking up id: x
 60:    LD 0, -3(5)	load id value
* <- id
* -> id
* looking up id: y
 61:    LD 0, -3(5)	load id value
* <- id
 62:    ST 5, -3(5)	push ofp
 63:   LDA 5, -3(5)	push frame
 64:   LDA 0, 1(7)	load ac with ret ptr
 65:   LDA 7, -54(7)	jump to fun loc
 66:    LD 5, 0(5)	pop frame
* <- call
 67:    ST 5, -3(5)	push ofp
 68:   LDA 5, -3(5)	push frame
 69:   LDA 0, 1(7)	load ac with ret ptr
 70:   LDA 7, -71(7)	jump to fun loc
 71:    LD 5, 0(5)	pop frame
* <- call
* <- compound statement
 72:    LD 7, -1(5)	load return address
* <- fundecl
 73:   LDA 7, -38(7)	jump body
 74:    ST 5, -3(5)	push ofp
 75:   LDA 5, -3(5)	push frame
 76:   LDA 0, 1(7)	load ac with ret ptr
 77:   LDA 7, -33(7)	jump to main loc
 78:    LD 5, 0(5)	pop frame
* End of execution.
 79:  HALT 0, 0, 0	
