* C-Minus Compilation to TM Code
* File: 7.tm
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
* processing local array: x -2
* processing local var: i -12
* -> assign
* -> constant
 13:   LDC 0, 0(0)	load const
 14:    ST 0, -13(5)	op: push left
* <- constant
 15:    LD 0, -13(5)	assign: load left
 16:    ST 0, -12(5)	assign: store value
* <- assign
* -> while
* while: jump after body comes back here
* -> op
 17:    LD 0, -12(5)	load value in variable i
 18:    ST 0, -13(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
* -> constant
 19:   LDC 0, 10(0)	load const
 20:    ST 0, -14(5)	op: push left
* <- constant
 21:    LD 0, -13(5)	
 22:    LD 1, -14(5)	
 23:   SUB 0, 0, 1	op <
 24:   JLT 0, 2(7)	br if true
 25:   LDC 0, 0(0)	false case
 26:   LDA 7, 1(7)	unconditional jump
 27:   LDC 0, 1(0)	true case
 28:    ST 0, -13(5)	storing operation result
* <- op
* -----> while body start
* -> compound statement
* -> assign
 31:    LD 0, -12(5)	load value in variable i
 32:    ST 0, -14(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
