* C-Minus Compilation to TM Code
* File: sort.tm
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
* processing local array: x 0
* -> fundecl
* processing function: minloc
* jump around function body
 12:    ST 0, -1(5)	store return
* processing local array: a -2
* processing local var: low -2
* processing local var: high -3
* -> compound statement
* processing local var: i -4
* processing local var: x -5
* processing local var: k -6
* -> assign
 13:    LD 0, -2(5)	load value in variable low
 14:    ST 0, -7(5)	store variable value on stack
* -> id
* looking up id: low
* <- id
 15:    LD 0, -7(5)	assign: load left
 16:    ST 0, -6(5)	assign: store value
* <- assign
* -> assign
a
* ---------------------------------------------------------> INDEXVAR
 17:    LD 0, -2(5)	load value in variable low
 18:    ST 0, -7(5)	store variable value on stack
* -> id
* looking up id: low
* <- id
* <- assign
* -> assign
* -> op
 19:    LD 0, -2(5)	load value in variable low
 20:    ST 0, -7(5)	store variable value on stack
* -> id
* looking up id: low
* <- id
* -> constant
 21:   LDC 0, 1(0)	load const
 22:    ST 0, -8(5)	op: push left
* <- constant
 23:    LD 0, -7(5)	
 24:    LD 1, -8(5)	
 25:   ADD 0, 0, 1	op +
 26:    ST 0, -7(5)	storing operation result
* <- op
 27:    LD 0, -7(5)	assign: load left
 28:    ST 0, -4(5)	assign: store value
* <- assign
* -> while
* while: jump after body comes back here
* -> op
 29:    LD 0, -4(5)	load value in variable i
 30:    ST 0, -7(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
 31:    LD 0, -3(5)	load value in variable high
 32:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: high
* <- id
 33:    LD 0, -7(5)	
 34:    LD 1, -8(5)	
 35:   SUB 0, 0, 1	op <
 36:   JLT 0, 2(7)	br if true
 37:   LDC 0, 0(0)	false case
 38:   LDA 7, 1(7)	unconditional jump
 39:   LDC 0, 1(0)	true case
 40:    ST 0, -7(5)	storing operation result
* <- op
* -----> while body start
* -> compound statement
* -> if
* -> op
a
* ---------------------------------------------------------> INDEXVAR
 43:    LD 0, -4(5)	load value in variable i
 44:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
x
* -> id
* looking up id: x
* <- id
 45:    LD 0, -8(5)	
 46:    LD 1, -9(5)	
 47:   SUB 0, 0, 1	op <
 48:   JLT 0, 2(7)	br if true
 49:   LDC 0, 0(0)	false case
 50:   LDA 7, 1(7)	unconditional jump
 51:   LDC 0, 1(0)	true case
 52:    ST 0, -8(5)	storing operation result
* <- op
* -> compound statement
* -> assign
a
* ---------------------------------------------------------> INDEXVAR
 55:    LD 0, -4(5)	load value in variable i
 56:    ST 0, -9(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
* <- assign
* -> assign
 57:    LD 0, -4(5)	load value in variable i
 58:    ST 0, -9(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
 59:    LD 0, -9(5)	assign: load left
 60:    ST 0, -6(5)	assign: store value
* <- assign
* <- compound statement
 53:    LD 0, -8(5)	load result
 54:   JEQ 0, 6(7)	if: jmp to end
* <- if
* -> assign
* -> op
 61:    LD 0, -4(5)	load value in variable i
 62:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
* -> constant
 63:   LDC 0, 1(0)	load const
 64:    ST 0, -9(5)	op: push left
* <- constant
 65:    LD 0, -8(5)	
 66:    LD 1, -9(5)	
 67:   ADD 0, 0, 1	op +
 68:    ST 0, -8(5)	storing operation result
* <- op
 69:    LD 0, -8(5)	assign: load left
 70:    ST 0, -4(5)	assign: store value
* <- assign
* <- compound statement
 71:   LDA 7, -43(7)	while: jmp back to test exp
* <----- while body end
 41:    LD 0, -7(5)	load result
 42:   JEQ 0, 29(7)	while: jmp to below while loop
* <- while
* -> return
 72:    LD 0, -6(5)	load value in variable k
 73:    ST 0, -7(5)	store variable value on stack
* -> id
* looking up id: k
* <- id
 74:    ST 0, -7(5)	store return address in register 0
* <- return
* <- compound statement
 75:    LD 7, -1(5)	load return address
* <- fundecl
 11:   LDA 7, 64(7)	jump body
* -> fundecl
* processing function: sort
* jump around function body
 77:    ST 0, -1(5)	store return
* processing local array: a -2
* processing local var: low -2
* processing local var: high -3
* -> compound statement
* processing local var: i -4
* processing local var: k -5
* -> assign
 78:    LD 0, -2(5)	load value in variable low
 79:    ST 0, -6(5)	store variable value on stack
* -> id
* looking up id: low
* <- id
 80:    LD 0, -6(5)	assign: load left
 81:    ST 0, -4(5)	assign: store value
* <- assign
* -> while
* while: jump after body comes back here
* -> op
 82:    LD 0, -4(5)	load value in variable i
 83:    ST 0, -6(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
* -> op
 84:    LD 0, -3(5)	load value in variable high
 85:    ST 0, -7(5)	store variable value on stack
* -> id
* looking up id: high
* <- id
* -> constant
 86:   LDC 0, 1(0)	load const
 87:    ST 0, -8(5)	op: push left
* <- constant
 88:    LD 0, -7(5)	
 89:    LD 1, -8(5)	
 90:   SUB 0, 0, 1	op -
 91:    ST 0, -7(5)	storing operation result
* <- op
 92:    LD 0, -6(5)	
 93:    LD 1, -7(5)	
 94:   SUB 0, 0, 1	op <
 95:   JLT 0, 2(7)	br if true
 96:   LDC 0, 0(0)	false case
 97:   LDA 7, 1(7)	unconditional jump
 98:   LDC 0, 1(0)	true case
 99:    ST 0, -6(5)	storing operation result
* <- op
* -----> while body start
* -> compound statement
* processing local var: t -7
* -> assign
* -> call of function: minloc
a
* -> id
* looking up id: a
* <- id
102:    LD 0, -4(5)	load value in variable i
103:    ST 0, -11(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
104:    LD 0, -3(5)	load value in variable high
105:    ST 0, -12(5)	store variable value on stack
* -> id
* looking up id: high
* <- id
106:    ST 5, -8(5)	push ofp
107:   LDA 5, -8(5)	push frame
108:   LDA 0, 1(7)	load ac with ret ptr
109:   LDA 7, -98(7)	jump to fun loc
110:    LD 5, 0(5)	pop frame
* <- call
111:    ST 0, -5(5)	assign: store value
* <- assign
* -> assign
a
* ---------------------------------------------------------> INDEXVAR
112:    LD 0, -5(5)	load value in variable k
113:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: k
* <- id
114:    LD 0, -8(5)	assign: load left
115:    ST 0, -7(5)	assign: store value
* <- assign
* -> assign
a
* ---------------------------------------------------------> INDEXVAR
116:    LD 0, -4(5)	load value in variable i
117:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
* <- assign
* -> assign
118:    LD 0, -7(5)	load value in variable t
119:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: t
* <- id
* <- assign
* -> assign
* -> op
120:    LD 0, -4(5)	load value in variable i
121:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
* -> constant
122:   LDC 0, 1(0)	load const
123:    ST 0, -9(5)	op: push left
* <- constant
124:    LD 0, -8(5)	
125:    LD 1, -9(5)	
126:   ADD 0, 0, 1	op +
127:    ST 0, -8(5)	storing operation result
* <- op
128:    LD 0, -8(5)	assign: load left
129:    ST 0, -4(5)	assign: store value
* <- assign
* <- compound statement
130:   LDA 7, -49(7)	while: jmp back to test exp
* <----- while body end
100:    LD 0, -6(5)	load result
101:   JEQ 0, 29(7)	while: jmp to below while loop
* <- while
* <- compound statement
131:    LD 7, -1(5)	load return address
* <- fundecl
 76:   LDA 7, 55(7)	jump body
* -> fundecl
* processing function: main
* jump around function body
133:    ST 0, -1(5)	store return
* -> compound statement
* processing local var: i -2
* -> assign
* -> constant
134:   LDC 0, 0(0)	load const
135:    ST 0, -3(5)	op: push left
* <- constant
136:    LD 0, -3(5)	assign: load left
137:    ST 0, -2(5)	assign: store value
* <- assign
* -> while
* while: jump after body comes back here
* -> op
138:    LD 0, -2(5)	load value in variable i
139:    ST 0, -3(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
* -> constant
140:   LDC 0, 10(0)	load const
141:    ST 0, -4(5)	op: push left
* <- constant
142:    LD 0, -3(5)	
143:    LD 1, -4(5)	
144:   SUB 0, 0, 1	op <
145:   JLT 0, 2(7)	br if true
146:   LDC 0, 0(0)	false case
147:   LDA 7, 1(7)	unconditional jump
148:   LDC 0, 1(0)	true case
149:    ST 0, -3(5)	storing operation result
* <- op
* -----> while body start
* -> compound statement
* -> assign
* -> call of function: input
152:    ST 5, -4(5)	push ofp
153:   LDA 5, -4(5)	push frame
154:   LDA 0, 1(7)	load ac with ret ptr
155:   LDA 7, -156(7)	jump to fun loc
156:    LD 5, 0(5)	pop frame
* <- call
* <- assign
* -> assign
* -> op
157:    LD 0, -2(5)	load value in variable i
158:    ST 0, -4(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
* -> constant
159:   LDC 0, 1(0)	load const
160:    ST 0, -5(5)	op: push left
* <- constant
161:    LD 0, -4(5)	
162:    LD 1, -5(5)	
163:   ADD 0, 0, 1	op +
164:    ST 0, -4(5)	storing operation result
* <- op
165:    LD 0, -4(5)	assign: load left
166:    ST 0, -2(5)	assign: store value
* <- assign
* <- compound statement
167:   LDA 7, -30(7)	while: jmp back to test exp
* <----- while body end
150:    LD 0, -3(5)	load result
151:   JEQ 0, 16(7)	while: jmp to below while loop
* <- while
* -> call of function: sort
x
* -> id
* looking up id: x
* <- id
* -> constant
168:   LDC 0, 0(0)	load const
169:    ST 0, -6(5)	op: push left
* <- constant
* -> constant
170:   LDC 0, 10(0)	load const
171:    ST 0, -7(5)	op: push left
* <- constant
172:    ST 5, -3(5)	push ofp
173:   LDA 5, -3(5)	push frame
174:   LDA 0, 1(7)	load ac with ret ptr
175:   LDA 7, -99(7)	jump to fun loc
176:    LD 5, 0(5)	pop frame
* <- call
* -> assign
* -> constant
177:   LDC 0, 0(0)	load const
178:    ST 0, -3(5)	op: push left
* <- constant
179:    LD 0, -3(5)	assign: load left
180:    ST 0, -2(5)	assign: store value
* <- assign
* -> while
* while: jump after body comes back here
* -> op
181:    LD 0, -2(5)	load value in variable i
182:    ST 0, -3(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
* -> constant
183:   LDC 0, 10(0)	load const
184:    ST 0, -4(5)	op: push left
* <- constant
185:    LD 0, -3(5)	
186:    LD 1, -4(5)	
187:   SUB 0, 0, 1	op <
188:   JLT 0, 2(7)	br if true
189:   LDC 0, 0(0)	false case
190:   LDA 7, 1(7)	unconditional jump
191:   LDC 0, 1(0)	true case
192:    ST 0, -3(5)	storing operation result
* <- op
* -----> while body start
* -> compound statement
* -> call of function: output
x
* ---------------------------------------------------------> INDEXVAR
195:    LD 0, -2(5)	load value in variable i
196:    ST 0, -6(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
197:    ST 5, -4(5)	push ofp
198:   LDA 5, -4(5)	push frame
199:   LDA 0, 1(7)	load ac with ret ptr
200:   LDA 7, -201(7)	jump to fun loc
201:    LD 5, 0(5)	pop frame
* <- call
* -> assign
* -> op
202:    LD 0, -2(5)	load value in variable i
203:    ST 0, -4(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
* -> constant
204:   LDC 0, 1(0)	load const
205:    ST 0, -5(5)	op: push left
* <- constant
206:    LD 0, -4(5)	
207:    LD 1, -5(5)	
208:   ADD 0, 0, 1	op +
209:    ST 0, -4(5)	storing operation result
* <- op
210:    LD 0, -4(5)	assign: load left
211:    ST 0, -2(5)	assign: store value
* <- assign
* <- compound statement
212:   LDA 7, -32(7)	while: jmp back to test exp
* <----- while body end
193:    LD 0, -3(5)	load result
194:   JEQ 0, 18(7)	while: jmp to below while loop
* <- while
* <- compound statement
213:    LD 7, -1(5)	load return address
* <- fundecl
132:   LDA 7, 81(7)	jump body
214:    ST 5, -11(5)	push ofp
215:   LDA 5, -11(5)	push frame
216:   LDA 0, 1(7)	load ac with ret ptr
217:   LDA 7, -85(7)	jump to main loc
218:    LD 5, 0(5)	pop frame
* End of execution.
219:  HALT 0, 0, 0	
