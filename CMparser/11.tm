* C-Minus Compilation to TM Code
* File: 11.tm
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
* -> vardeclist
* -> vardecl
* processing local array: arr -2
* <- vardecl
* <- vardeclist
* -> compound statement
* -> assign
* -> op
* -> varexpression
* -> constant
 13:   LDC 0, 1(0)	load const
 14:    ST 0, -1(5)	op: push left
* <- constant
 15:    LD 0, -1(5)	assign: load result of array index calculation into register 0
 16:   LDA 1, -2(5)	load array base address into register 1
 17:   SUB 1, 1, 0	adds the base address to the index
 18:    LD 0, 0(1)	load value in array arr
 19:    ST 0, -1(5)	store variable value on stack
* <- varexpression
* -> varexpression
* -> constant
 20:   LDC 0, 2(0)	load const
 21:    ST 0, -2(5)	op: push left
* <- constant
 22:    LD 0, -2(5)	assign: load result of array index calculation into register 0
 23:   LDA 1, -2(5)	load array base address into register 1
 24:   SUB 1, 1, 0	adds the base address to the index
 25:    LD 0, 0(1)	load value in array arr
 26:    ST 0, -2(5)	store variable value on stack
* <- varexpression
 27:    LD 0, -1(5)	
 28:    LD 1, -2(5)	
 29:   ADD 0, 0, 1	op +
 30:    ST 0, -1(5)	storing operation result
* <- op
* -> constant
 31:   LDC 0, 0(0)	load const
 32:    ST 0, -2(5)	op: push left
* <- constant
 33:    LD 0, -2(5)	assign: load result of array index calculation into register 0
 34:   LDA 1, -2(5)	load array base address into register 1
 35:   SUB 1, 1, 0	adds the base address to the index
 36:    LD 0, -1(5)	assign: load result of rhs into register 0
 37:    ST 0, 0(1)	assign: store value from register 0
* <- assign
* <- compound statement
 38:    LD 7, -1(5)	load return address
* <- fundecl
 11:   LDA 7, 27(7)	jump body
* -> fundecl
* processing function: main
* jump around function body
 40:    ST 0, -1(5)	store return
* -> compound statement
* -> vardeclist
* -> vardecl
* processing local array: array -2
* <- vardecl
* -> vardecl
* processing local var: i -12
* <- vardecl
* <- vardeclist
* FO: -13 GO: 0
* -> assign
* -> constant
 41:   LDC 0, 0(0)	load const
 42:    ST 0, -13(5)	op: push left
* <- constant
 43:    LD 0, -13(5)	assign: load left
 44:    ST 0, -12(5)	assign: store value from register 0
* <- assign
* -> while
* while: jump after body comes back here
* -> op
* -> varexpression
 45:    LD 0, -12(5)	load value in variable i
 46:    ST 0, -13(5)	store variable value on stack
* <- varexpression
* -> constant
 47:   LDC 0, 10(0)	load const
 48:    ST 0, -14(5)	op: push left
* <- constant
 49:    LD 0, -13(5)	
 50:    LD 1, -14(5)	
 51:   SUB 0, 0, 1	op <
 52:   JLT 0, 2(7)	br if true
 53:   LDC 0, 0(0)	false case
 54:   LDA 7, 1(7)	unconditional jump
 55:   LDC 0, 1(0)	true case
 56:    ST 0, -13(5)	storing operation result
* <- op
* -----> while body start
* -> compound statement
* -> assign
* -> op
* -> varexpression
 59:    LD 0, -12(5)	load value in variable i
 60:    ST 0, -14(5)	store variable value on stack
* <- varexpression
* -> constant
 61:   LDC 0, 20(0)	load const
 62:    ST 0, -15(5)	op: push left
* <- constant
 63:    LD 0, -14(5)	
 64:    LD 1, -15(5)	
 65:   ADD 0, 0, 1	op +
 66:    ST 0, -14(5)	storing operation result
* <- op
* -> varexpression
 67:    LD 0, -12(5)	load value in variable i
 68:    ST 0, -15(5)	store variable value on stack
* <- varexpression
 69:    LD 0, -15(5)	assign: load result of array index calculation into register 0
 70:   LDA 1, -2(5)	load array base address into register 1
 71:   SUB 1, 1, 0	adds the base address to the index
 72:    LD 0, -14(5)	assign: load result of rhs into register 0
 73:    ST 0, 0(1)	assign: store value from register 0
* <- assign
* -> assign
* -> op
* -> varexpression
 74:    LD 0, -12(5)	load value in variable i
 75:    ST 0, -14(5)	store variable value on stack
* <- varexpression
* -> constant
 76:   LDC 0, 1(0)	load const
 77:    ST 0, -15(5)	op: push left
* <- constant
 78:    LD 0, -14(5)	
 79:    LD 1, -15(5)	
 80:   ADD 0, 0, 1	op +
 81:    ST 0, -14(5)	storing operation result
* <- op
 82:    LD 0, -14(5)	assign: load left
 83:    ST 0, -12(5)	assign: store value from register 0
* <- assign
* <- compound statement
 84:   LDA 7, -40(7)	while: jmp back to test exp
* <----- while body end
 57:    LD 0, -13(5)	load result
 58:   JEQ 0, 26(7)	while: jmp to below while loop
* <- while
* -> call of function: add
* -> varexpression
