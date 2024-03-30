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
* processing local var: z -4
* -> op
* -> id
* looking up id: x
 13:   LDA 0, -5(5)	load id address
* <- id
 14:    ST 0, -5(5)	op: push left
* -> constant
 15:   LDC 0, 0(0)	load const
* <- constant
 16:    LD 0, -5(5)	op: load left
 17:    ST 0, -2(5)	assign: store value
* <- op
* -> op
* -> id
* looking up id: y
 18:   LDA 0, -5(5)	load id address
* <- id
 19:    ST 0, -5(5)	op: push left
* -> constant
 20:   LDC 0, 1(0)	load const
* <- constant
 21:    LD 0, -5(5)	op: load left
 22:    ST 0, -3(5)	assign: store value
* <- op
* -> op
* -> id
* looking up id: z
 23:   LDA 0, -5(5)	load id address
* <- id
 24:    ST 0, -5(5)	op: push left
* -> constant
 25:   LDC 0, 0(0)	load const
* <- constant
 26:    LD 0, -5(5)	op: load left
 27:    ST 0, -4(5)	assign: store value
* <- op
* -> if
* -> op
* -> id
* looking up id: x
 28:    LD 0, -5(5)	load id value
* <- id
* -> id
* looking up id: y
 29:    LD 0, -6(5)	load id value
* <- id
 30:    LD 0, -5(5)	
 31:    LD 1, -6(5)	
* <- op
* -> compound statement
* -> op
* -> id
* looking up id: z
 34:   LDA 0, -6(5)	load id address
* <- id
 35:    ST 0, -6(5)	op: push left
* -> constant
 36:   LDC 0, 1(0)	load const
* <- constant
 37:    LD 0, -6(5)	op: load left
 38:    ST 0, -4(5)	assign: store value
* <- op
* <- compound statement
* if: jump to else belongs here
* -> compound statement
* -> op
* -> id
* looking up id: z
 40:   LDA 0, -5(5)	load id address
* <- id
 41:    ST 0, -5(5)	op: push left
* -> constant
 42:   LDC 0, 2(0)	load const
* <- constant
 43:    LD 0, -5(5)	op: load left
 44:    ST 0, -4(5)	assign: store value
* <- op
* <- compound statement
 39:   LDA 7, 5(7)	if: jmp to end
 32:    LD 0, -5(5)	load result
 33:   JEQ 0, 5(7)	if: jmp to else
* <- if
* <- compound statement
 45:    LD 7, -1(5)	load return address
* <- fundecl
 46:   LDA 7, -5(7)	jump body
 47:    ST 5, -8(5)	push ofp
 48:   LDA 5, -8(5)	push frame
 49:   LDA 0, 1(7)	load ac with ret ptr
 50:   LDA 7, -39(7)	jump to main loc
 51:    LD 5, 0(5)	pop frame
* End of execution.
 52:  HALT 0, 0, 0	
