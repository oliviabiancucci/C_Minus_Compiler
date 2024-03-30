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
 22:    LD 0, 0(5)	load value in variable u
 23:    ST 0, -3(5)	store variable value on stack
* -> id
* looking up id: u
* <- id
 24:    LD 7, -1(5)	return to call
* <- return
* if: jump to else belongs here
* -> return
* ---------------------------------------------------------> CALLEXP
 26:    LD 7, -1(5)	return to call
* <- return
 25:   LDA 7, 1(7)	if: jmp to end
 20:    LD 0, -2(5)	load result
 21:   JEQ 0, 3(7)	if: jmp to else
* <- if
* <- compound
 27:    LD 7, -1(5)	load return address
* <- fundecl
 28:   LDA 7, 16(7)	jump body
* -> fundecl
* processing function: main
* jump around function body
 30:    ST 0, -1(5)	store return
* -> compound
* allocated local var: x -2
* -> assign
* ---------------------------------------------------------> CALLEXP
 31:    LD 0, -4(5)	retrieve result
 32:    ST 0, -2(5)	store result in variable
* <- assign
* -> assign
* -> constant
 33:   LDC 0, 10(0)	load const
 34:    ST 0, -4(5)	op: push left
* <- constant
 35:    LD 0, -4(5)	retrieve result
 36:    ST 0, 0(5)	store result in variable
* <- assign
* ---------------------------------------------------------> CALLEXP
* <- compound
 37:    LD 7, -1(5)	load return address
* <- fundecl
 38:   LDA 7, 8(7)	jump body
 39:    ST 5, -1(5)	push ofp
 40:   LDA 5, -1(5)	push frame
 41:   LDA 0, 1(7)	load ac with ret ptr
 42:   LDA 7, -13(7)	jump to main loc
 43:    LD 5, 0(5)	pop frame
* End of execution.
 44:  HALT 0, 0, 0	
