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
 17:    LD 0, -2(5)	load value in variable low
 18:    ST 0, -7(5)	store variable value on stack
* -> id
* looking up id: low
* <- id
 19:    LD 0, -7(5)	assign: load left
 20:    ST 0, -5(5)	assign: store value
* <- assign
* -> assign
* -> op
 21:    LD 0, -2(5)	load value in variable low
 22:    ST 0, -7(5)	store variable value on stack
* -> id
* looking up id: low
* <- id
* -> constant
 23:   LDC 0, 1(0)	load const
 24:    ST 0, -8(5)	op: push left
* <- constant
 25:    LD 0, -7(5)	
 26:    LD 1, -8(5)	
 27:   ADD 0, 0, 1	op +
 28:    ST 0, -7(5)	storing operation result
* <- op
 29:    LD 0, -7(5)	assign: load left
 30:    ST 0, -4(5)	assign: store value
* <- assign
* -> while
* while: jump after body comes back here
* -> op
 31:    LD 0, -4(5)	load value in variable i
 32:    ST 0, -7(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
 33:    LD 0, -3(5)	load value in variable high
 34:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: high
* <- id
 35:    LD 0, -7(5)	
 36:    LD 1, -8(5)	
 37:   SUB 0, 0, 1	op <
 38:   JLT 0, 2(7)	br if true
 39:   LDC 0, 0(0)	false case
 40:   LDA 7, 1(7)	unconditional jump
 41:   LDC 0, 1(0)	true case
 42:    ST 0, -7(5)	storing operation result
* <- op
* -----> while body start
* -> compound statement
* -> if
* -> op
 45:    LD 0, -4(5)	load value in variable i
 46:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
 47:    LD 0, -5(5)	load value in variable x
 48:    ST 0, -9(5)	store variable value on stack
* -> id
* looking up id: x
* <- id
 49:    LD 0, -8(5)	
 50:    LD 1, -9(5)	
 51:   SUB 0, 0, 1	op <
 52:   JLT 0, 2(7)	br if true
 53:   LDC 0, 0(0)	false case
 54:   LDA 7, 1(7)	unconditional jump
 55:   LDC 0, 1(0)	true case
 56:    ST 0, -8(5)	storing operation result
* <- op
* -> compound statement
* -> assign
 59:    LD 0, -4(5)	load value in variable i
 60:    ST 0, -9(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
 61:    LD 0, -9(5)	assign: load left
 62:    ST 0, -5(5)	assign: store value
* <- assign
* -> assign
 63:    LD 0, -4(5)	load value in variable i
 64:    ST 0, -9(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
 65:    LD 0, -9(5)	assign: load left
 66:    ST 0, -6(5)	assign: store value
* <- assign
* <- compound statement
 57:    LD 0, -8(5)	load result
 58:   JEQ 0, 8(7)	if: jmp to end
* <- if
* -> assign
* -> op
 67:    LD 0, -4(5)	load value in variable i
 68:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
* -> constant
 69:   LDC 0, 1(0)	load const
 70:    ST 0, -9(5)	op: push left
* <- constant
 71:    LD 0, -8(5)	
 72:    LD 1, -9(5)	
 73:   ADD 0, 0, 1	op +
 74:    ST 0, -8(5)	storing operation result
* <- op
 75:    LD 0, -8(5)	assign: load left
 76:    ST 0, -4(5)	assign: store value
* <- assign
* <- compound statement
 77:   LDA 7, -47(7)	while: jmp back to test exp
* <----- while body end
 43:    LD 0, -7(5)	load result
 44:   JEQ 0, 33(7)	while: jmp to below while loop
* <- while
* -> return
 78:    LD 0, -6(5)	load value in variable k
 79:    ST 0, -7(5)	store variable value on stack
* -> id
* looking up id: k
* <- id
 80:    ST 0, -7(5)	store return address in register 0
* <- return
* <- compound statement
 81:    LD 7, -1(5)	load return address
* <- fundecl
 11:   LDA 7, 70(7)	jump body
* -> fundecl
* processing function: sort
* jump around function body
 83:    ST 0, -1(5)	store return
* processing local array: a -2
* processing local var: low -2
* processing local var: high -3
* -> compound statement
* processing local var: i -4
* processing local var: k -5
* -> assign
 84:    LD 0, -2(5)	load value in variable low
 85:    ST 0, -6(5)	store variable value on stack
* -> id
* looking up id: low
* <- id
 86:    LD 0, -6(5)	assign: load left
 87:    ST 0, -4(5)	assign: store value
* <- assign
* -> while
* while: jump after body comes back here
* -> op
 88:    LD 0, -4(5)	load value in variable i
 89:    ST 0, -6(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
* -> op
 90:    LD 0, -3(5)	load value in variable high
 91:    ST 0, -7(5)	store variable value on stack
* -> id
* looking up id: high
* <- id
* -> constant
 92:   LDC 0, 1(0)	load const
 93:    ST 0, -8(5)	op: push left
* <- constant
 94:    LD 0, -7(5)	
 95:    LD 1, -8(5)	
 96:   SUB 0, 0, 1	op -
 97:    ST 0, -7(5)	storing operation result
* <- op
 98:    LD 0, -6(5)	
 99:    LD 1, -7(5)	
100:   SUB 0, 0, 1	op <
101:   JLT 0, 2(7)	br if true
102:   LDC 0, 0(0)	false case
103:   LDA 7, 1(7)	unconditional jump
104:   LDC 0, 1(0)	true case
105:    ST 0, -6(5)	storing operation result
* <- op
* -----> while body start
* -> compound statement
* processing local var: t -7
* -> assign
* -> call of function: minloc
* -> id
* looking up id: a
* <- id
108:    LD 0, -4(5)	load value in variable i
109:    ST 0, -11(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
110:    LD 0, -3(5)	load value in variable high
111:    ST 0, -12(5)	store variable value on stack
* -> id
* looking up id: high
* <- id
112:    ST 5, -8(5)	push ofp
113:   LDA 5, -8(5)	push frame
114:   LDA 0, 1(7)	load ac with ret ptr
115:   LDA 7, -104(7)	jump to fun loc
116:    LD 5, 0(5)	pop frame
* <- call
117:    ST 0, -5(5)	assign: store value
* <- assign
* -> assign
118:    LD 0, -5(5)	load value in variable k
119:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: k
* <- id
120:    LD 0, -8(5)	assign: load left
121:    ST 0, -7(5)	assign: store value
* <- assign
* -> assign
122:    LD 0, -4(5)	load value in variable i
123:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
* <- assign
* -> assign
124:    LD 0, -7(5)	load value in variable t
125:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: t
* <- id
* <- assign
* -> assign
* -> op
126:    LD 0, -4(5)	load value in variable i
127:    ST 0, -8(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
* -> constant
128:   LDC 0, 1(0)	load const
129:    ST 0, -9(5)	op: push left
* <- constant
130:    LD 0, -8(5)	
131:    LD 1, -9(5)	
132:   ADD 0, 0, 1	op +
133:    ST 0, -8(5)	storing operation result
* <- op
134:    LD 0, -8(5)	assign: load left
135:    ST 0, -4(5)	assign: store value
* <- assign
* <- compound statement
136:   LDA 7, -49(7)	while: jmp back to test exp
* <----- while body end
106:    LD 0, -6(5)	load result
107:   JEQ 0, 29(7)	while: jmp to below while loop
* <- while
* <- compound statement
137:    LD 7, -1(5)	load return address
* <- fundecl
 82:   LDA 7, 55(7)	jump body
* -> fundecl
* processing function: main
* jump around function body
139:    ST 0, -1(5)	store return
* -> compound statement
* processing local var: i -2
* -> assign
* -> constant
140:   LDC 0, 0(0)	load const
141:    ST 0, -3(5)	op: push left
* <- constant
142:    LD 0, -3(5)	assign: load left
143:    ST 0, -2(5)	assign: store value
* <- assign
* -> while
* while: jump after body comes back here
* -> op
144:    LD 0, -2(5)	load value in variable i
145:    ST 0, -3(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
* -> constant
146:   LDC 0, 10(0)	load const
147:    ST 0, -4(5)	op: push left
* <- constant
148:    LD 0, -3(5)	
149:    LD 1, -4(5)	
150:   SUB 0, 0, 1	op <
151:   JLT 0, 2(7)	br if true
152:   LDC 0, 0(0)	false case
153:   LDA 7, 1(7)	unconditional jump
154:   LDC 0, 1(0)	true case
155:    ST 0, -3(5)	storing operation result
* <- op
* -----> while body start
* -> compound statement
* -> assign
* -> call of function: input
158:    ST 5, -4(5)	push ofp
159:   LDA 5, -4(5)	push frame
160:   LDA 0, 1(7)	load ac with ret ptr
161:   LDA 7, -158(7)	jump to fun loc
162:    LD 5, 0(5)	pop frame
* <- call
* <- assign
* -> assign
* -> op
163:    LD 0, -2(5)	load value in variable i
164:    ST 0, -4(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
* -> constant
165:   LDC 0, 1(0)	load const
166:    ST 0, -5(5)	op: push left
* <- constant
167:    LD 0, -4(5)	
168:    LD 1, -5(5)	
169:   ADD 0, 0, 1	op +
170:    ST 0, -4(5)	storing operation result
* <- op
171:    LD 0, -4(5)	assign: load left
172:    ST 0, -2(5)	assign: store value
* <- assign
* <- compound statement
173:   LDA 7, -30(7)	while: jmp back to test exp
* <----- while body end
156:    LD 0, -3(5)	load result
157:   JEQ 0, 16(7)	while: jmp to below while loop
* <- while
* -> call of function: sort
* -> id
* looking up id: x
* <- id
* -> constant
174:   LDC 0, 0(0)	load const
175:    ST 0, -6(5)	op: push left
* <- constant
* -> constant
176:   LDC 0, 10(0)	load const
177:    ST 0, -7(5)	op: push left
* <- constant
178:    ST 5, -3(5)	push ofp
179:   LDA 5, -3(5)	push frame
180:   LDA 0, 1(7)	load ac with ret ptr
181:   LDA 7, -99(7)	jump to fun loc
182:    LD 5, 0(5)	pop frame
* <- call
* -> assign
* -> constant
183:   LDC 0, 0(0)	load const
184:    ST 0, -3(5)	op: push left
* <- constant
185:    LD 0, -3(5)	assign: load left
186:    ST 0, -2(5)	assign: store value
* <- assign
* -> while
* while: jump after body comes back here
* -> op
187:    LD 0, -2(5)	load value in variable i
188:    ST 0, -3(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
* -> constant
189:   LDC 0, 10(0)	load const
190:    ST 0, -4(5)	op: push left
* <- constant
191:    LD 0, -3(5)	
192:    LD 1, -4(5)	
193:   SUB 0, 0, 1	op <
194:   JLT 0, 2(7)	br if true
195:   LDC 0, 0(0)	false case
196:   LDA 7, 1(7)	unconditional jump
197:   LDC 0, 1(0)	true case
198:    ST 0, -3(5)	storing operation result
* <- op
* -----> while body start
* -> compound statement
* -> call of function: output
201:    LD 0, -2(5)	load value in variable i
202:    ST 0, -6(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
203:    ST 5, -4(5)	push ofp
204:   LDA 5, -4(5)	push frame
205:   LDA 0, 1(7)	load ac with ret ptr
206:   LDA 7, -200(7)	jump to fun loc
207:    LD 5, 0(5)	pop frame
* <- call
* -> assign
* -> op
208:    LD 0, -2(5)	load value in variable i
209:    ST 0, -4(5)	store variable value on stack
* -> id
* looking up id: i
* <- id
* -> constant
210:   LDC 0, 1(0)	load const
211:    ST 0, -5(5)	op: push left
* <- constant
212:    LD 0, -4(5)	
213:    LD 1, -5(5)	
214:   ADD 0, 0, 1	op +
215:    ST 0, -4(5)	storing operation result
* <- op
216:    LD 0, -4(5)	assign: load left
217:    ST 0, -2(5)	assign: store value
* <- assign
* <- compound statement
218:   LDA 7, -32(7)	while: jmp back to test exp
* <----- while body end
199:    LD 0, -3(5)	load result
200:   JEQ 0, 18(7)	while: jmp to below while loop
* <- while
* <- compound statement
219:    LD 7, -1(5)	load return address
* <- fundecl
138:   LDA 7, 81(7)	jump body
220:    ST 5, -11(5)	push ofp
221:   LDA 5, -11(5)	push frame
222:   LDA 0, 1(7)	load ac with ret ptr
223:   LDA 7, -85(7)	jump to main loc
224:    LD 5, 0(5)	pop frame
* End of execution.
225:  HALT 0, 0, 0	
