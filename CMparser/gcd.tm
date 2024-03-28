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
* allocated local var: y 0
* -> fundecl
* processing function: gcd
* jump around function body
 12:    ST 0, -1(5)	store return
* -> compound
* -> if
* -> op
 13:    LD 0, 0(5)	load value in variable v
 14:    ST 0, -2(5)	store variable value on stack
* -> id
* looking up id: v
* <- id
* -> constant
 15:   LDC 0, 0(0)	load const
 16:    ST 0, -3(5)	op: push left
* <- constant
 17:    LD 0, -2(5)	
 18:    LD 1, -3(5)	
 19:    ST 0, -2(5)	storing operation result
* <- op
* -> return
 21:    LD 0, 0(5)	load value in variable u
 22:    ST 0, -2(5)	store variable value on stack
* -> id
* looking up id: u
* <- id
 23:    LD 7, -1(5)	return to call
* <- return
* if: jump to end belongs here
 20:   JEQ 7, 3(7)	if: jmp to else
* if: jump to else belongs here
* -> return
* ---------------------------------------------------------> CALLEXP
 24:    LD 7, -1(5)	return to call
* <- return
* <- if
* <- compound
 25:    LD 7, -1(5)	load return address
* <- fundecl
 26:   LDA 7, 14(7)	jump body
* -> fundecl
* processing function: main
* jump around function body
 28:    ST 0, -1(5)	store return
* -> compound
* allocated local var: x -2
* -> assign
* ---------------------------------------------------------> CALLEXP
 29:    LD 0, -4(5)	retrieve result
 30:    ST 0, -2(5)	store result in variable
* <- assign
* -> assign
* -> constant
 31:   LDC 0, 10(0)	load const
 32:    ST 0, -4(5)	op: push left
* <- constant
 33:    LD 0, -4(5)	retrieve result
 34:    ST 0, 0(5)	store result in variable
* <- assign
* ---------------------------------------------------------> CALLEXP
* <- compound
 35:    LD 7, -1(5)	load return address
* <- fundecl
 36:   LDA 7, 8(7)	jump body
 37:    ST 5, -1(5)	push ofp
 38:   LDA 5, -1(5)	push frame
 39:   LDA 0, 1(7)	load ac with ret ptr
 40:   LDA 7, -13(7)	jump to main loc
 41:    LD 5, 0(5)	pop frame
* End of execution.
 42:  HALT 0, 0, 0	
