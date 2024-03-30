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
* processing function: main
* jump around function body
 12:    ST 0, -1(5)	store return
* -> compound statement
* processing local var: x -2
* processing local var: y -3
* processing local var: z -4
* -> op
* -> constant
 13:   LDC 0, 0(0)	load const
 14:    ST 0, -5(5)	op: push left
* <- constant
 15:    LD 0, -5(5)	op: load left
 16:    ST 0, -2(5)	assign: store value
* <- op
* -> op
* -> constant
 17:   LDC 0, 1(0)	load const
 18:    ST 0, -5(5)	op: push left
* <- constant
 19:    LD 0, -5(5)	op: load left
 20:    ST 0, -3(5)	assign: store value
* <- op
* -> op
* -> constant
 21:   LDC 0, 2(0)	load const
 22:    ST 0, -5(5)	op: push left
* <- constant
 23:    LD 0, -5(5)	op: load left
 24:    ST 0, -4(5)	assign: store value
* <- op
* -> if
* -> op
 25:    LD 0, -2(5)	load value in variable x
 26:    ST 0, -5(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
 27:    LD 0, -3(5)	load value in variable y
 28:    ST 0, -6(5)	store variable value on stack
* -> id
* looking up id: y
* <- id
 29:    LD 0, -5(5)	
 30:    LD 1, -6(5)	
 31:   SUB 0, 0, 1	op ==
 32:   JEQ 0, 2(7)	br if true
 33:   LDC 0, 0(0)	false case
 34:   LDA 7, 1(7)	unconditional jump
 35:   LDC 0, 1(0)	true case
 36:    ST 0, -5(5)	storing operation result
* <- op
* -> compound statement
* -> op
* -> constant
 39:   LDC 0, 3(0)	load const
 40:    ST 0, -6(5)	op: push left
* <- constant
 41:    LD 0, -6(5)	op: load left
 42:    ST 0, -4(5)	assign: store value
* <- op
* <- compound statement
 37:    LD 0, -5(5)	load result
 38:   JEQ 0, 4(7)	if: jmp to end
* <- if
* <- compound statement
 43:    LD 7, -1(5)	load return address
* <- fundecl
 44:   LDA 7, -5(7)	jump body
 45:    ST 5, -3(5)	push ofp
 46:   LDA 5, -3(5)	push frame
 47:   LDA 0, 1(7)	load ac with ret ptr
 48:   LDA 7, -37(7)	jump to main loc
 49:    LD 5, 0(5)	pop frame
* End of execution.
 50:  HALT 0, 0, 0	
