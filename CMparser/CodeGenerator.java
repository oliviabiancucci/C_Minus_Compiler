
import java.util.HashMap;

import absyn.*;

public class CodeGenerator implements AbsynVisitor{
	HashMap<String, FuncDec> functionTable = new HashMap<String, FuncDec>();
	//how to calculate a jump: target - current location - 1

	int emitLoc = 0; //current instruction we are generating
	int highEmitLoc = 0; //next available space for instructions

	int ac = 0;
	int ac1 = 1;
	int fp = 5;
	int gp = 6;
	int pc = 7;

	int globalOffset; //this will be subtracted by 1 for every int
	int mainEntry = 0; //store where the main is

	int ofpFO = 0;
	int retFO = -1;
	int initFO = -2;
	int frameOffset = -2;

	public void codeGenerator() {
	}

	public void emitRO( String op, int r, int s, int t, String c ) {
		System.out.printf("%3d: %5s %d, %d, %d", emitLoc, op, r, s, t);
        System.out.printf("\t%s\n", c);
		++emitLoc;
		if( highEmitLoc < emitLoc ) highEmitLoc = emitLoc;
	}

	public void emitRM( String op, int r, int d, int s, String c ) {
		System.out.printf( "%3d: %5s %d, %d(%d)", emitLoc, op, r, d, s );
		System.out.printf( "\t%s\n", c );
		++emitLoc;
		if( highEmitLoc < emitLoc ) highEmitLoc = emitLoc;
	}

	public void emitRM_Abs( String op, int r, int a, String c ) {
		System.out.printf( "%3d: %5s %d, %d(%d)", emitLoc, op, r, (a - (emitLoc + 1)), pc );
		System.out.printf( "\t%s\n", c );
		++emitLoc;
		if( highEmitLoc < emitLoc ) highEmitLoc = emitLoc;
	}

	public int emitSkip( int distance ) {
		int i = emitLoc;
		emitLoc += distance;
		if( highEmitLoc < emitLoc )
		highEmitLoc = emitLoc;
		return i;
	}

	public void emitBackup( int loc ) {
		if( loc > highEmitLoc ) emitComment( "BUG in emitBackup" );
		emitLoc = loc;
	}

	public void emitRestore() {
		emitLoc = highEmitLoc;
	}

	public void emitComment( String c ) {
		System.out.printf("* %s\n", c );
	}

	public void prelude(String fileName) {
		int inSavedLoc = 0;
		int outSavedLoc = 0;

		emitComment("C-Minus Compilation to TM Code");
		emitComment("File: " + fileName);

		//Prelude
		emitComment("Standard prelude:");
        emitRM("LD", gp, 0, ac, "load gp with maxaddress");
        emitRM("LDA", fp, 0, gp, "copy to gp to fp");
        emitRM("ST", ac, 0, ac, "clear location 0");
		
		//Jump to a different instruction
		emitComment("Jump around i/o routines here");

		//Input Routine
		emitComment("code for input routine");
		inSavedLoc = emitSkip(1);
		emitRM("ST", ac, retFO, fp, "store return");
		emitRO("IN", 0, 0, 0, "input");
		emitRM("LD", pc, retFO, fp, "return to caller");

		//Output Routine
		emitComment("code for output routine");
		emitRM("ST", ac, retFO, fp, "store return");
		emitRM("LD", 0, initFO, fp, "load output value"); //TODO: CHECK THIS
		emitRO("OUT", 0, 0, 0, "output");
		emitRM("LD", pc, retFO, fp, "return to caller");
		outSavedLoc = emitSkip(0);
		emitBackup(inSavedLoc);
		emitRM_Abs("LDA", pc, outSavedLoc, "jump around i/o code");

		emitRestore();
        emitComment("End of standard prelude.");
	}

	public void finale(){
		if (mainEntry == 0){ //if there is no main function
			emitRO("HALT", 0, 0, 0, "no main"); //emit error
		}

		//Finale
		emitRM( "ST", fp, globalOffset + ofpFO, fp, "push ofp" );
		emitRM( "LDA", fp, globalOffset, fp, "push frame" );
		emitRM( "LDA", ac, 1, pc, "load ac with ret ptr" );
		emitRM_Abs( "LDA", pc, mainEntry, "jump to main loc" );
		emitRM( "LD", fp, ofpFO, fp, "pop frame" );

		emitComment("End of execution.");
		emitRO( "HALT", 0, 0, 0, "" );
	}

	public void visit( NameTy exp, int level, boolean isAddr){

	}
  
	public void visit( SimpleVar exp, int level, boolean isAddr){
		emitComment("-> id");
        emitComment("looking up id: " + exp.name);
		emitComment("<- id");
	}
  
	public void visit( IndexVar exp, int level, boolean isAddr){
		exp.index.accept(this, level, isAddr);
	}
  
	public void visit( Vartype exp, int level, boolean isAddr){

	}
  
	public void visit( NilExp exp, int level, boolean isAddr){

	}
  
	public void visit( IntExp exp, int level, boolean isAddr){
        emitComment("-> constant");
        emitRM("LDC", ac, Integer.parseInt(exp.value), 0, "load const"); // holds constant in ac1
        emitRM("ST", ac, level, fp, "op: push left");
        emitComment("<- constant");
	}
  
	public void visit( BoolExp exp, int level, boolean isAddr){
		if(exp.value == false){
			emitRM("LDC", ac, 0, 0, "false condition");
		}
		else{
			emitRM("LDC", ac, 1, 0, "true condition");
		}
		emitRM("ST", ac, level, fp, "");
	}
  
	public void visit( VarExp exp, int level, boolean isAddr){
		emitComment("-> varexpression");
		if(exp != null)
		{
			if(exp.dtype instanceof SimpleDec)
			{
				SimpleDec simp = (SimpleDec)exp.dtype;

				if(simp.nestLevel == 0) //global scope
				{
					emitRM( "LD", ac, simp.offset, gp, "load value in variable " + simp.name);
					emitRM( "ST", ac, level, fp, "store variable value on stack");
				}
				else // local scope
				{
					emitRM( "LD", ac, simp.offset, fp, "load value in variable " + simp.name);
					emitRM( "ST", ac, level, fp, "store variable value on stack");
				}
			}
			else if(exp.dtype instanceof ArrayDec)
			{
				ArrayDec array = (ArrayDec)exp.dtype;
				IndexVar index = (IndexVar)exp.varName;

				index.accept(this, level, isAddr); // store index exp result in stack

				//TODO: implement using variables as indices
				//TODO: implement using opexp as indices
				//been using 7.cm and 8.cm for these

				emitRM( "LD", ac, level, fp, "assign: load result of array index calculation into register 0"); // gets top value off of stack to store
				if(array.nestLevel == 0) //global scope
				{
					emitRM( "LDA", ac1, array.offset, gp, "load array base address into register 1");
				}
				else // local scope
				{
					emitRM( "LDA", ac1, array.offset, fp, "load array base address into register 1");
				}
				emitRO("SUB", ac1, ac1, ac, "adds the base address to the index");
				//emitRM( "ST", ac, level-1, fp, "assign: store base address + index below rhs result");

				if(array.nestLevel == 0) //global scope
				{
					emitRM( "LD", ac, 0, ac1, "load value in array " + array.name);
					emitRM( "ST", ac, level, fp, "store variable value on stack");
				}
				else // local scope
				{
					emitRM( "LD", ac, 0, ac1, "load value in array " + array.name);
					emitRM( "ST", ac, level, fp, "store variable value on stack");
				}
			}
		}
		
		// if(exp.varName != null){
		// 	exp.varName.accept(this, level, isAddr);
		// }
		emitComment("<- varexpression");
	}
  
	public void visit( CallExp exp, int level, boolean isAddr){
		emitComment("-> call of function: " + exp.func);

		if(exp.func.equals("output"))
		{
			initFO = -2;
			int numVar = 0;
			ExpList list = exp.args;
			while(list != null && list.head != null)
			{
				if(!(list.head instanceof NilExp))
				{
					list.head.accept(this, level + initFO - numVar, isAddr);
				}
				numVar++;
				list = list.tail;
			}

			emitRM("ST", fp, level, fp, "push ofp");
			emitRM("LDA", fp, level, fp, "push frame");
			emitRM("LDA", ac, 1, pc, "load ac with ret ptr");
			emitRM_Abs("LDA", pc, 7, "jump to fun loc");
			emitRM("LD", fp, 0, fp, "pop frame");
		}
		else if(exp.func.equals("input"))
		{
			emitRM("ST", fp, level, fp, "push ofp");
			emitRM("LDA", fp, level, fp, "push frame");
			emitRM("LDA", ac, 1, pc, "load ac with ret ptr");
			emitRM_Abs("LDA", pc, 4, "jump to fun loc");
			emitRM("LD", fp, 0, fp, "pop frame");
			emitRM("ST", ac, level, fp, "store result on the stack");
		}
		else
		{
			FuncDec func = functionTable.get(exp.func);

			if(func == null )
			{
				System.out.println(exp.func + " does not exist");
			}

			initFO = -2; // used to push onto calling functions stack
			int numVar = 0; // keeps track of number of variables so that parameters are not written on top of one another
			ExpList list = exp.args;
			while(list != null && list.head != null)
			{
				if(!(list.head instanceof NilExp))
				{
					list.head.accept(this, level + initFO - numVar, isAddr);
				}
				numVar++;
				list = list.tail;
			}

			if(func.func.equals("main")) // adds global offset on main since it is first function on stack
			{
				emitRM("ST", fp, level - globalOffset, fp, "push ofp");
			}
			else
			{
				emitRM("ST", fp, level, fp, "push ofp");
			}
			emitRM("LDA", fp, level, fp, "push frame");
			emitRM("LDA", ac, 1, pc, "load ac with ret ptr");

			// TODO: may need to turn this into array of function calls in case function is called more than once before definition
			if(func.funAddr == 0) // funAddr has not been set, will need to backpatch
			{
				func.funLocs[func.funLocs.length - 1] = emitSkip(1); // stores the location of call in an array for backpatching
				func.copyLocs(); // creates a new array which is one space larger in anticipation for another backpatching call
			}
			else
			{
				emitRM_Abs("LDA", pc, func.funAddr, "jump to fun loc");
			}
			
			emitRM("LD", fp, 0, fp, "pop frame");
			emitRM("ST", ac, level, fp, "store result on the stack");
		}
		emitComment("<- call of function" + exp.func);
	}
  
	public void visit( OpExp exp, int level, boolean isAddr){
		emitComment("-> op");

		exp.left.accept(this, level, isAddr);
		if(exp.left instanceof NilExp && exp.op == OpExp.UMINUS)
		{
			emitComment("-> constant");
			emitRM("LDC", ac, 0, 0, "load const"); // places a 0 in register 0
			emitRM("ST", ac, level, fp, "op: push left"); // adds it to the stack in place of where rhs of opExp would have been
			emitComment("<- constant");
		}
		exp.right.accept(this, level - 1, isAddr);

		emitRM("LD", ac, level, fp, "");
		emitRM("LD", ac1, level - 1, fp, "");

		switch(exp.op) {
			case OpExp.PLUS:
			  emitRO("ADD", ac, ac, ac1, "op +");
			  break;
			case OpExp.MINUS:
			  emitRO("SUB", ac, ac, ac1, "op -");
			  break;
			case OpExp.UMINUS:
			  emitRO("SUB", ac, ac, ac1, "op -");
			  break;
			case OpExp.TIMES:
			  emitRO("MUL", ac, ac, ac1, "op *");
			  break;
			case OpExp.DIVIDE:
			  emitRO("DIV", ac, ac, ac1, "op /");
			  break;
			case OpExp.COMP:
			  emitRO("SUB", ac, ac, ac1, "op ==");
			  emitRM("JEQ", ac, 2, pc, "br if true");
			  emitRM("LDC", ac, 0, 0, "false case");
			  emitRM("LDA", pc, 1, pc, "unconditional jump");
			  emitRM("LDC", ac, 1, 0, "true case");
			  break;
			case OpExp.NE:
			  emitRO("SUB", ac, ac, ac1, "op !=");
              emitRM("JNE", ac, 2, pc, "br if true");
			  emitRM("LDC", ac, 0, 0, "false case");
			  emitRM("LDA", pc, 1, pc, "unconditional jump");
			  emitRM("LDC", ac, 1, 0, "true case");
			  break;
			case OpExp.TILDA:
			  int loc1 = 0;
			  emitRM("LDC", ac, 0, 0, "");
			  int loc2 = emitSkip(1); //unconditional jump
			  int loc3 = emitLoc;
			  emitRM("LDC", ac, 1, 0, "");
			  int loc4 = emitLoc; //end of statement

			  emitBackup(loc2);
			  emitRM("LDA", pc, loc4 - emitLoc - 1, pc, ""); //not confident on these arguments
			  emitRestore();

			  emitBackup(loc1);
			  emitRM("JEQ", ac, loc3 - emitLoc - 1, pc, ""); //not confident on these arguments
			  emitRestore();
			  break;
			case OpExp.LT:
			  emitRO("SUB", ac, ac, ac1, "op <");
			  emitRM("JLT", ac, 2, pc, "br if true");
			  emitRM("LDC", ac, 0, 0, "false case");
			  emitRM("LDA", pc, 1, pc, "unconditional jump");
			  emitRM("LDC", ac, 1, 0, "true case");
			  break;
			case OpExp.LTE:
			  emitRO("SUB", ac, ac, ac1, "op <=");
			  emitRM("JLE", ac, 2, pc, "br if true");
			  emitRM("LDC", ac, 0, 0, "false case");
			  emitRM("LDA", pc, 1, pc, "unconditional jump");
			  emitRM("LDC", ac, 1, 0, "true case");
			  break;
			case OpExp.GT:
			  emitRO("SUB", ac, ac, ac1, "op >");
			  emitRM("JGT", ac, 2, pc, "br if true");
			  emitRM("LDC", ac, 0, 0, "false case");
			  emitRM("LDA", pc, 1, pc, "unconditional jump");
			  emitRM("LDC", ac, 1, 0, "true case");
			  break;
			case OpExp.GTE:
			  emitRO("SUB", ac, ac, ac1, "op >=");
			  emitRM("JGE", ac, 2, pc, "br if true");
			  emitRM("LDC", ac, 0, 0, "false case");
			  emitRM("LDA", pc, 1, pc, "unconditional jump");
			  emitRM("LDC", ac, 1, 0, "true case");
			  break;
			case OpExp.AND:
			  emitRO("SUB", ac, ac, ac1, "op &&");
			  emitRM("JEQ", ac, 2, pc, "br if true");
			  emitRM("LDC", ac, 0, 0, "false case");
			  emitRM("LDA", pc, 1, pc, "unconditional jump");
			  emitRM("LDC", ac, 1, 0, "true case");
			  break;
			case OpExp.OR:
			  //emitRO("SUB", ac, ac, ac1, "op ||");
			  emitRM("JNE", ac, 4, pc, "br if true");
			  emitRM("LDC", ac, 0, 0, "false case");
			  emitRM("JNE", ac1, 2, pc, "br if true");
			  emitRM("LDC", ac, 0, 0, "false case");
			  emitRM("LDA", pc, 1, pc, "unconditional jump");
			  emitRM("LDC", ac, 1, 0, "true case");
			  break;
		}

		emitRM("ST", ac, level, fp, "storing operation result"); // places result on stack

		emitComment("<- op");
	}
  
	public void visit( AssignExp exp, int level, boolean isAddr){
		emitComment("-> assign");

		exp.rhs.accept(this, level, isAddr);

		if(exp.lhs.dtype instanceof SimpleDec)
		{
			SimpleDec dec = (SimpleDec)exp.lhs.dtype;

			emitRM( "LD", ac, level, fp, "assign: load left"); // gets top value off of stack to store
			if(dec.nestLevel == 0)
			{
				emitRM( "ST", ac, dec.offset, gp, "assign: store value from register 0");
			}
			else
			{
				emitRM( "ST", ac, dec.offset, fp, "assign: store value from register 0");
			}
			
		}
		else if(exp.lhs.dtype instanceof ArrayDec)
		{
			// Add index checking for out of bounds
			// 1. Get the value off the top of the stack (index of array) into register 0
			// 2. LDC the array size into register 1
			// 3. if register 0 is bigger than register 1 HALT
			// 4. Else jump over the HALT
			ArrayDec array = (ArrayDec)exp.lhs.dtype;
			IndexVar indexVar = (IndexVar)exp.lhs.varName;

			indexVar.accept(this, level-1, isAddr); // accepts on index expression, which should place result on stack - 1

			emitRM( "LD", ac, level - 1, fp, "assign: load result of array index calculation into register 0"); // gets top value off of stack to store
			
			//check if the index is less than 0
			emitRM("JLT", ac, 1, pc, "check if the index is less than 0");
			emitRM("LDA", pc, 1, pc, "unconditional jump");
			emitRO("HALT", 0, 0, 0, "array index out of bounds");

			emitRM("LDC", ac1, array.size, 0, "load array size"); //load array size into register 1

			//check if the index is outside of the array bounds
			emitRO("SUB", ac, ac, ac1, "op >");
			emitRM("JGT", ac, 1, pc, "br if true");
			emitRM("LDA", pc, 1, pc, "unconditional jump");
			emitRO("HALT", 0, 0, 0, "array index out of bounds");

			emitRM( "LD", ac, level - 1, fp, "assign: load result of array index calculation into register 0");

			if(array.nestLevel == 0) //global scope
			{
				emitRM( "LDA", ac1, array.offset, gp, "load array base address into register 1");
			}
			else // local scope
			{
				emitRM( "LDA", ac1, array.offset, fp, "load array base address into register 1");
			}
			emitRO("SUB", ac1, ac1, ac, "adds the base address to the index");
			//emitRM( "ST", ac, level-1, fp, "assign: store base address + index below rhs result");

			emitRM( "LD", ac, level, fp, "assign: load result of rhs into register 0"); // gets top value off of stack to store
			if(array.nestLevel == 0) //global scope
			{
				emitRM( "ST", ac, 0, ac1, "assign: store value from register 0 ");
			}
			else // local scope
			{
				emitRM( "ST", ac, 0, ac1, "assign: store value from register 0");
			}
		}
	
		emitComment("<- assign");
	}
  
	public void visit( IfExp exp, int level, boolean isAddr){
		int loc3 = -1; //end of then block
		int loc4 = -1; //end of else block

        emitComment("-> if");

		//IF
		exp.test.accept(this, level, isAddr);
		int loc1 = emitSkip(2); //save two lines to load the result of the condition
		exp.thenpart.accept(this, level - 1, isAddr);
		int loc2 = emitLoc;
		
		//ELSE
		if(!(exp.elsepart instanceof NilExp)){
			emitComment("if: jump to else belongs here");
			loc3 = emitSkip(1);
			exp.elsepart.accept(this, level, isAddr);
			loc4 = emitLoc;
			emitBackup(loc3);
			emitRM_Abs("LDA", pc, loc4, "if: jmp to end");
			emitRestore();

			emitBackup(loc1);
			emitRM("LD", ac, level, fp, "load result");
			emitRM_Abs("JEQ", 0, loc2 + 1, "if: jmp to else"); // loc2 + 1 to account for added line by else jump
			emitRestore();
		}
		else
		{
			emitBackup(loc1);
			emitRM("LD", ac, level, fp, "load result");
			emitRM_Abs("JEQ", 0, loc2, "if: jmp to end");
			emitRestore();
		}

		emitComment("<- if");
	}
  
	public void visit( WhileExp exp, int level, boolean isAddr){
		emitComment("-> while");
		emitComment("while: jump after body comes back here");
		int whileTest = emitLoc;
		if (!(exp.test instanceof NilExp))
		{
            exp.test.accept(this, level, isAddr);
        }
		int loc1 = emitSkip(2);

		emitComment("-----> while body start");
        exp.body.accept(this, level - 1, isAddr);
		// unconditional jump to before the test condition
		emitRM_Abs("LDA", pc, whileTest, "while: jmp back to test exp");
		int loc2 = emitLoc; // gets the location at the end of the while loop for when loop ends
		emitComment("<----- while body end");
        
		// writes lines just below test expression
		emitBackup(loc1); // back up to two reserved lines
		emitRM("LD", ac, level, fp, "load result"); // loads the result from the stack into ac
		emitRM_Abs("JEQ", 0, loc2 , "while: jmp to below while loop"); // compares ac against 0, jumps to loc2 if ac == 0
		emitRestore(); // moves back to correct place to continue writing lines of code

		emitComment("<- while");

		/*
		 * 		TEST EXPRESSION 
		 * 
		 * 		"LD", ac, level, fp, "load result"
		 * 		"JEQ", 0, loc2, "while: jmp to below while loop" conditional jump
		 * 		
		 * 		BODY
		 * 
		 * 		"LDA", pc, whileTest, "while: jmp back to test exp" unconditional jump
		 */
	}
  
	public void visit( ReturnExp exp, int level, boolean isAddr){
		emitComment("-> return");
		if(exp.exp != null)
		{
			exp.exp.accept(this, level, isAddr);
		}
		emitRM("LD", ac, level, fp, "store returned value in register 0");
		emitComment("<- return");
	}
  
	public void visit( CompoundExp exp, int level, boolean isAddr){
		emitComment("-> compound statement");
		if(exp != null)
		{
			if(exp.decs != null){
				exp.decs.accept(this, level, isAddr);
				emitComment("FO: " + frameOffset + " GO: " + globalOffset);
				level = frameOffset;
			}
			if(exp.exp != null){
				exp.exp.accept(this, level, isAddr);
			}
		}
		emitComment("<- compound statement");
	}

	public void visit( FuncDec exp, int level, boolean isAddr){
		if(!(exp.body instanceof NilExp)) // full definition
		{
			emitComment("-> fundecl");
			emitComment("processing function: " + exp.func);
			if(functionTable.get(exp.func) != null) // if prototype was declared
			{
				// copies all of the previous references into current 
				exp.funLocs = functionTable.get(exp.func).funLocs;
				functionTable.replace(exp.func, exp);
			}
			else
			{
				functionTable.put(exp.func, exp);
			}

			emitComment("jump around function body");
			int startLoc = emitSkip(1);
			exp.funAddr = emitLoc;

			int i = 0;
			while(exp.funLocs[i] != -1) // funLoc has been set, function has been called before this declaration was reached, need to backpatch jump address in
			{
				System.err.println("Backpatching function call at " + exp.funLocs[i]);
				emitBackup(exp.funLocs[i]);
				emitRM_Abs("LDA", pc, exp.funAddr, "jump to fun loc");
				emitRestore();
				i++;
			}

			if (exp.func.equals("main")) {
				mainEntry = emitLoc;
			}

			emitRM("ST", ac, -1, fp, "store return"); //TODO: make sure the return address is in register 0

			frameOffset = -2;

			if(exp.params != null){
				exp.params.accept(this, frameOffset, isAddr);
			}

			exp.body.accept(this, frameOffset, isAddr);

			emitRM("LD", pc, -1, fp, "load return address");

			emitComment("<- fundecl");
			
			int endLoc = emitLoc;
			emitBackup(startLoc);
			emitRM("LDA", pc,  endLoc - startLoc - 1, pc, "jump body");
			emitRestore();
		}
		else // prototype
		{
			emitComment("-> funproto");
			emitComment("processing function prototype: " + exp.func);
			functionTable.put(exp.func, exp);
			emitComment("<- funproto");
		}

	}
  
	public void visit( SimpleDec exp, int level, boolean isAddr){
		//System.err.println("SimpleDec");
		exp.offset = level;

		if(exp.name != null){
			emitComment("-> vardecl");
			if (exp.nestLevel == 0){
				emitComment("allocating global var: " + exp.name + " " + exp.offset); //TODO: Remove offset printout
				globalOffset -= 1;
			}
			else{
				emitComment("processing local var: " + exp.name + " " + exp.offset); //TODO: Remove offset printout
			}
			emitComment("<- vardecl");
		}
		
	}
  
	public void visit( ArrayDec exp, int level, boolean isAddr){
		//System.err.println("ArrayDec");
		exp.offset = level;

		if(exp.name != null){
			emitComment("-> vardecl");
			if (exp.nestLevel == 0){
				emitComment("allocating global array: " +  exp.name + " " + exp.offset); //TODO: Remove offset printout
				globalOffset -= exp.size;
			}
			else{
				emitComment("processing local array: " + exp.name + " " + exp.offset); //TODO: Remove offset printout
			}
			emitComment("<- vardecl");
		}
	}

	public void visit( ExpList exp, int level, boolean isAddr){
		//System.err.println("ExpList");
		while(exp != null && exp.head != null){
			exp.head.accept(this, level, isAddr);
			exp = exp.tail;
		}
	}
  
	public void visit ( DecLists exp, int level, boolean isAddr){
		//System.err.println("DecLists");
		while(exp != null && exp.head != null){
			exp.head.accept(this, level, isAddr);
			exp = exp.tail;
		}
	}
  
	public void visit ( VarDecLists exp, int level, boolean isAddr){
		emitComment("-> vardeclist");
		while(exp != null && exp.head != null){
			exp.head.accept(this, level, isAddr);

			
			int offset = 1;
			if(exp.head instanceof SimpleDec)
			{
				SimpleDec simp = (SimpleDec)exp.head;

				if(simp.nestLevel != 0)
				{
					level -= offset;
				}
			}
			else if(exp.head instanceof ArrayDec){ //offset an array by its size
				ArrayDec array = (ArrayDec)exp.head;
				offset = array.size; //TODO: check that this is the right result

				if(array.nestLevel != 0)
				{
					level -= offset;
				}
			}

			exp = exp.tail;
		}
		//VERY IMPORTANT
		frameOffset = level; // passes the new level back up to compound expression where is it reset for rest of function
		emitComment("<- vardeclist");
	}
}
