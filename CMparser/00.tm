* C-Minus Compilation to TM Code
* File: 00.tm
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
* processing function: main
* jump around function body
 12:    ST 0, -1(5)	store return
* -> compound statement
* processing local var: x -2
* processing local var: y -3
* processing local var: k -4
* -> assign
 13:   LDC 0, 1(0)	true condition
 14:    ST 0, -5(5)	
 15:    LD 0, -5(5)	assign: load left
 16:    ST 0, -2(5)	assign: store value
* <- assign
* -> assign
 17:   LDC 0, 0(0)	false condition
 18:    ST 0, -5(5)	
 19:    LD 0, -5(5)	assign: load left
 20:    ST 0, -3(5)	assign: store value
* <- assign
* -> if
* -> op
* -> op
 21:    LD 0, -2(5)	load value in variable x
 22:    ST 0, -5(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
 23:   LDC 0, 1(0)	true condition
 24:    ST 0, -6(5)	
 25:    LD 0, -5(5)	
 26:    LD 1, -6(5)	
 27:   SUB 0, 0, 1	op ==
 28:   JEQ 0, 2(7)	br if true
 29:   LDC 0, 0(0)	false case
 30:   LDA 7, 1(7)	unconditional jump
 31:   LDC 0, 1(0)	true case
 32:    ST 0, -5(5)	storing operation result
* <- op
* -> op
 33:    LD 0, -3(5)	load value in variable y
 34:    ST 0, -6(5)	store variable value on stack
* -> id
* looking up id: y
* <- id
 35:   LDC 0, 1(0)	true condition
 36:    ST 0, -7(5)	
 37:    LD 0, -6(5)	
 38:    LD 1, -7(5)	
 39:   SUB 0, 0, 1	op ==
 40:   JEQ 0, 2(7)	br if true
 41:   LDC 0, 0(0)	false case
 42:   LDA 7, 1(7)	unconditional jump
 43:   LDC 0, 1(0)	true case
 44:    ST 0, -6(5)	storing operation result
* <- op
 45:    LD 0, -5(5)	
 46:    LD 1, -6(5)	
 47:   JNE 0, 4(7)	br if true
 48:   LDC 0, 0(0)	false case
 49:   JNE 1, 2(7)	br if true
 50:   LDC 0, 0(0)	false case
 51:   LDA 7, 1(7)	unconditional jump
 52:   LDC 0, 1(0)	true case
 53:    ST 0, -5(5)	storing operation result
* <- op
* -> compound statement
* -> assign
* -> constant
 56:   LDC 0, 10(0)	load const
 57:    ST 0, -6(5)	op: push left
* <- constant
 58:    LD 0, -6(5)	assign: load left
 59:    ST 0, -4(5)	assign: store value
* <- assign
* <- compound statement
 54:    LD 0, -5(5)	load result
 55:   JEQ 0, 4(7)	if: jmp to end
* <- if
* -> return
 60:    ST 0, -5(5)	store return address in register 0
* <- return
* <- compound statement
 61:    LD 7, -1(5)	load return address
* <- fundecl
 11:   LDA 7, 50(7)	jump body
 62:    ST 5, -3(5)	push ofp
 63:   LDA 5, -3(5)	push frame
 64:   LDA 0, 1(7)	load ac with ret ptr
 65:   LDA 7, -54(7)	jump to main loc
 66:    LD 5, 0(5)	pop frame
* End of execution.
 67:  HALT 0, 0, 0	
