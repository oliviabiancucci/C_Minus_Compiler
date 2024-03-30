import java.util.ArrayList;
import java.util.HashMap;

import absyn.*;

public class CodeGenerator implements AbsynVisitor{

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
	int frameOffset = 0;

	public void codeGenerator() {
		int frameOffset = -2; //TODO: check this?
		globalOffset = 0;

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

		//if (isAddr) emitRM("LDA", ac, exp.dec.offset, fp, "load id address"); //TODO: just added recently (march 29th), delete if u want
		//else emitRM("LD", ac, exp.dec.offset, fp, "load id value"); 
		
		emitComment("<- id");
	}
  
	public void visit( IndexVar exp, int level, boolean isAddr){
		emitComment("---------------------------------------------------------> INDEXVAR");
		exp.index.accept(this, level, isAddr);
	}
  
	public void visit( Vartype exp, int level, boolean isAddr){
		emitComment("---------------------------------------------------------> VARTYPE");
	}
  
	public void visit( NilExp exp, int level, boolean isAddr){

	}
  
	public void visit( IntExp exp, int level, boolean isAddr){
        emitComment("-> constant");
        emitRM("LDC", ac, Integer.parseInt(exp.value), 0, "load const"); // holds constant in ac1
        emitRM("ST", ac, level, fp, "op: push left");
        emitComment("<- constant");
		//TODO: globalOffset--;
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
		if(exp != null)
		{
			if(exp.dtype instanceof SimpleDec)
			{
				SimpleDec simp = (SimpleDec)exp.dtype;

				if(simp.nestLevel == 0) //global scope
				{
					emitRM( "LD", ac, simp.offset, gp, "load value in variable " + simp.name);
					emitRM( "ST", ac, level, gp, "store variable value on stack");
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
				System.out.println(array.name);
			}
		}

		if(exp.varName != null){
			exp.varName.accept(this, level, isAddr);
		}
	}
  
	public void visit( CallExp exp, int level, boolean isAddr){
		int funAddr = -1;
		int loc2 = -1;
		emitComment("-> call of function: " + exp.func);

		//save current line in memory
		//go to function address
		//create space for parameters
		// run function code
		//pass back function returns
		// return to previous line in memory

		emitRM("ST", fp, level, fp, "push ofp"); //ofpFO + level?
		emitRM("LDA", fp, level, fp, "push frame");
		emitRM("LDA", ac, 1, pc, "load ac with ret ptr");
		emitRM_Abs("LDA", pc, ((FuncDec)exp.dtype).funAddr, "jump to fun loc");
		emitRM("LD", fp, 0, fp, "pop frame"); //ofpFO instead of 0?

		emitComment("<- call");
	}
  
	public void visit( OpExp exp, int level, boolean isAddr){
		emitComment("-> op");

		exp.left.accept(this, level, isAddr);
		exp.right.accept(this, level - 1, isAddr);

		//TODO: idk anymore about this emits
		emitRM("LD", ac, level, fp, "");
		emitRM("LD", ac1, level - 1, fp, "");

		switch(exp.op) {
			case OpExp.PLUS:
			  emitRO("ADD", ac, ac, ac1, "perform add operation");
			  break;
			case OpExp.MINUS:
			  emitRO("SUB", ac, ac, ac1, "perform subtract operation");
			  break;
			case OpExp.TIMES:
			  emitRO("MUL", ac, ac, ac1, "perform multiply operation");
			  break;
			case OpExp.DIVIDE:
			  emitRO("DIV", ac, ac, ac1, "perform division operation");
			  break;
			case OpExp.EQ:
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
			case OpExp.NOT:
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

			  break;
			case OpExp.OR:

			  break;
		}

		//TODO: this is storing the result of GT in the wrong spot, needs to store below the variables memory
		//TODO: this error is in the if statement of 0.cm rn
		emitRM("ST", ac, level, fp, "storing operation result");

		emitComment("<- op");
	}
  
	public void visit( AssignExp exp, int level, boolean isAddr){
		emitComment("-> op");
		
		exp.lhs.accept(this, level - 1, isAddr);
		exp.rhs.accept(this, level - 2, isAddr);

		if(exp.lhs.dtype instanceof SimpleDec)
		{
			SimpleDec dec = (SimpleDec)exp.lhs.dtype;
			//emitRM( "LD", ac, level - 2, fp, "retrieve result");
			//emitRM( "ST", ac, dec.offset, fp, "store result in variable");
			emitRM("LD", ac, level - 1, fp, "op: load left");
			emitRM("LD", ac1, level - 2, fp, "op: load right");
			emitRM("ST", ac1, ac, ac, "");
			emitRM("ST", ac1, level, fp, "assign: store value");
		}
		else if(exp.lhs.dtype instanceof ArrayDec)
		{
			//TODO: something eventually
		}
	
		emitComment("<- op");
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
		
		// emitBackup(loc1);
		// emitComment("if: jump to end belongs here");
		// emitRM_Abs("JEQ", 0, loc2, "if: jmp to else");
		// emitRestore();

		//ELSE
		if(exp.elsepart != null){
			loc3 = emitSkip(1);
			emitComment("if: jump to else belongs here");
			exp.elsepart.accept(this, level, isAddr);
			loc4 = emitLoc;
			emitBackup(loc3);
			emitRM_Abs("LDA", pc, loc4, "if: jmp to end");
			emitRestore();
		}

		emitBackup(loc1);
		emitRM("LD", ac, level, fp, "load result");
		emitRM_Abs("JEQ", 0, loc2, "if: jmp to else");
		emitRestore();

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
		emitRM_Abs("LDA", pc, whileTest, "while: jmp back to test exp"); // (whileTest: top) - (emitLoc: current) - 1
		int loc2 = emitLoc;
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
		emitRM("LD", pc, -1, 77, "return to call");
		emitComment("<- return");
	}
  
	public void visit( CompoundExp exp, int level, boolean isAddr){
		emitComment("-> compound statement");
		if(exp != null)
		{
			if(exp.decs != null){
				exp.decs.accept(this, level, isAddr);
				level = frameOffset; //JUST ADDED
			}
			if(exp.exp != null){
				exp.exp.accept(this, level, isAddr);
			}
		}
		emitComment("<- compound statement");

	}

	public void visit( FuncDec exp, int level, boolean isAddr){
		emitComment("-> fundecl");
    	emitComment("processing function: " + exp.func);
    	emitComment("jump around function body");

		int startLoc = emitSkip(1);

		exp.funAddr = emitLoc;

		if (exp.func.equals("main")) {
			mainEntry = emitLoc;
		}

		emitRM("ST", 0, -1, fp, "store return"); //TODO: make sure the return address is in register 0

		int frameOffset = -2;

		exp.body.accept(this, frameOffset, isAddr);

		emitRM("LD", pc, -1, fp, "load return address"); // places the value offset(fp) in program counter

		emitComment("<- fundecl");

		int endLoc = 7;
		emitRM("LDA", pc, endLoc - startLoc - 1, pc, "jump body");
		emitRestore();
	}
  
	public void visit( SimpleDec exp, int level, boolean isAddr){
		exp.offset = level;

		if(exp.name != null){
			if (exp.nestLevel == 0){
				emitComment("allocating global var: " + exp.name);
				emitComment("<- vardecl");
			}
			else{
				emitComment("processing local var: " + exp.name + " " + exp.offset);
			}
		}
		
	}
  
	public void visit( ArrayDec exp, int level, boolean isAddr){
		exp.offset = level;

		if(exp.name != null){
			if (exp.nestLevel == 0){
				emitComment("allocating global array: " + exp.name);
				emitComment("<- vardecl");
			}
			else{
				emitComment("processing local array: " + exp.name + " " + exp.offset);
			}
		}
	}

	public void visit( ExpList exp, int level, boolean isAddr){
		while(exp != null && exp.head != null){
			exp.head.accept(this, level, isAddr);
			exp = exp.tail;
		}
	}
  
	public void visit ( DecLists exp, int level, boolean isAddr){
		while(exp != null && exp.head != null){
			exp.head.accept(this, level, isAddr);
			exp = exp.tail;
		}
	}
  
	public void visit ( VarDecLists exp, int level, boolean isAddr){
		while(exp != null && exp.head != null){
			exp.head.accept(this, level, isAddr);

			int offset = 1; //default offset

			if(exp.head instanceof ArrayDec){ //offset an array by its size
				offset = (((ArrayDec)exp.head).size) + 1; //TODO: check that this is the right result
			}

			if(exp.head.nestLevel == 0){
				globalOffset -= offset;
			}

			level -= offset;
			exp = exp.tail;
		}
		frameOffset = level; //JUST ADDED
	}
}
