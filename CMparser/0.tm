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
sub2 is null
* -> op
* -> id
* looking up id: a
* <- id
* -> constant
 27:   LDC 0, 1(0)	load const
 28:    ST 0, -8(5)	op: push left
* <- constant
 29:    LD 0, -7(5)	
 30:    LD 1, -8(5)	
 31:   ADD 0, 0, 1	op +
 32:    ST 0, -7(5)	storing operation result
* <- op
 33:    ST 5, -5(5)	push ofp
 34:   LDA 5, -5(5)	push frame
 35:   LDA 0, 1(7)	load ac with ret ptr
