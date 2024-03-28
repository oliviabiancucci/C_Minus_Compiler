import java.util.ArrayList;
import java.util.HashMap;

import absyn.*;

public class CodeGenerator implements AbsynVisitor{

	//how to calculate a jump: target - current location - 1

	HashMap<String, ArrayList<NodeType>> table;

	int emitLoc = 0; //current instruction we are generating
	int highEmitLoc = 0; //next available space for instructions

	int ac = 0;
	int ac1 = 1;
	int fp = 5;
	int gp = 6;
	int pc = 7;

	int globalOffset; //this will be subtracted by 1 for every int
	int mainEntry = 0; //store where the main is

	private void insert(NodeType node){
        if(table.containsKey(node.name)){
            table.get(node.name).add(0, node);
        }
        else{ 
            ArrayList<NodeType> arrList = new ArrayList<NodeType>();
            arrList.add(0, node);
            table.put(node.name, arrList);
        }
    }

    private ArrayList<NodeType> lookup(NodeType node){
        if(table.containsKey(node.name)){
            return table.get(node.name);
        }
        return null;
    }

    private void delete(int level){
        boolean delCheck;
        while(true)
        {
            delCheck = false;
            for(ArrayList<NodeType> nodes : table.values())
            {
                if(nodes.isEmpty() == false)
                {
                    for(int i = 0; i < nodes.size(); i++)
                    {
                        NodeType node = nodes.get(i);
                        if(node.level == level)
                        {
                            nodes.remove(i);
                            if(nodes.size() == 0)
                            {
                                table.remove(node.name);
                                delCheck = true;
                                break;
                            }
                        }
                    }
                }
                if(delCheck == true) // if something is deleted
                {
                    break;
                }
            }
            if(delCheck == false) // if nothing is deleted
            {
                break;
            }
        }
    }


	public void codeGenerator() {
		int frameOffset = -2; //TODO: check this?
		table = new HashMap<String, ArrayList<NodeType>>();

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

	//the "main function"
	public void visit(String fileName){
		int inSavedLoc = 0;
		int outSavedLoc = 0;
		int inFuncLocation = 0;
		int outFuncLocation = 0;

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
		inFuncLocation = emitSkip(0);
		NodeType inNode = new NodeType("input", "VOID", 0);
		insert(inNode);
		emitRM("ST", ac, retFO, fp, "store return");
		emitRM("IN", 0, 0, 0, "input");
		emitRM("LD", 7, -1, 5, "return to caller");  //TODO: double check the argument values here

		//Output Routine
		emitComment("code for output routine");
		outFuncLocation = emitSkip(0);
		NodeType outNode = new NodeType("output", "-2", 0); //TODO: check -2 here
		insert(outNode);
		emitRM("ST", ac, retFO, fp, "store return");
		emitRM("LD", 0, initOF, fp, "load output value");
		emitRM("OUT", 0, 0, 0, "output");
		emitRM("LD", 7, -1, 5, "return to caller"); //TODO: double check the argument values here
		outSavedLoc = emitSkip(0);
		emitBackup(outFuncLocation);
		emitRM_Abs("LDA", pc, outSavedLoc, "jump around i/o code");
        
		emitRestore();
        emitComment("End of standard prelude.");

		//call visit here

		if (mainEntry == 0){ //if there is no main function
			emitRO("HALT", 0, 0, 0, ""); //emit error
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

	}
  
	public void visit( IndexVar exp, int level, boolean isAddr){

	}
  
	public void visit( Vartype exp, int level, boolean isAddr){

	}
  
	public void visit( NilExp exp, int level, boolean isAddr){

	}
  
	public void visit( IntExp exp, int level, boolean isAddr){
        emitComment("-> constant");
        emitRM("LDC", ac, Integer.parseInt(exp.value), 0, "load const");
        emitRM("ST", ac, level, fp, "op: push left");
        emitComment("<- constant");
		//TODO: globalOffset--?
	}
  
	public void visit( BoolExp exp, int level, boolean isAddr){

	}
  
	public void visit( VarExp exp, int level, boolean isAddr){
		//TODO: this is very incomplete
		//emitRM("LD", ac, the expr offset, scope ptr or gp?, "load id value");
		//emitRM("ST", ac, level, fp, "store array value");
	}
  
	public void visit( CallExp exp, int level, boolean isAddr){
		int funAddr = -1;

	}
  
	public void visit( OpExp exp, int level, boolean isAddr){
		emitComment("-> op");

		exp.left.accept(this, level, isAddr);
		exp.right.accept(this, level - 1, isAddr);

		//TODO: idk anymore about this emits
		emitRM("LD", ac, level, fp, "");
		emitRM("ST", ac1, level - 1, fp, "");

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
			  
			  break;
			case OpExp.NE:
			  
			  break;
			case OpExp.NOT:
			  
			  break;
			case OpExp.LT:

			  break;
			case OpExp.LTE:
			 
			  break;
			case OpExp.GT:
			  
			  break;
			case OpExp.GTE:
			  
			  break;
		
		emitComment("<- op");
	}
  
	public void visit( AssignExp exp, int level, boolean isAddr){
		emitComment("-> assign");



		emitComment("<- assign");

	}
  
	public void visit( IfExp exp, int level, boolean isAddr){
        emitComment("-> if");

		emitComment("<- if");
	}
  
	public void visit( WhileExp exp, int level, boolean isAddr){
		emitComment("-> while");


		if (exp.body != null)
		{
            exp.body.accept(this, level, isAddr);
        }



		emitComment("<- while");
	}
  
	public void visit( ReturnExp exp, int level, boolean isAddr){
		emitComment("-> return");
		if(exp.exp != null)
		{
			exp.exp.accept(this, level, isAddr);
		}
		emitRM("LD", pc, -1, fp, "return to call");
		emitComment("<- return");
	}
  
	public void visit( CompoundExp exp, int level, boolean isAddr){
		emitComment("-> compound");
		if(exp != null)
		{
			exp.decs.accept(this, level, isAddr);
			exp.exp.accept(this, level, isAddr);
		}
		emitComment("<- compound");

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

		emitRM("LD", pc, 01, fp, "load return address");

		emitComment("<- fundecl");

		int endLoc = emitLoc;
		emitRM("LDA", pc, endLoc - startLoc - 1, pc, "jump body");
		emitRestore();
	}
  
	public void visit( SimpleDec exp, int level, boolean isAddr){
		if(exp != null)
		{
			//NodeType dec = new NodeType(exp.name, exp, level);
		}
	}
  
	public void visit( ArrayDec exp, int level, boolean isAddr){

	}

	public void visit( ExpList exp, int level, boolean isAddr){

	}
  
	public void visit ( DecLists exp, int level, boolean isAddr){

	}
  
	public void visit ( VarDecLists exp, int level, boolean isAddr){

	}
}
