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
	public void visit(){

		//Prelude
		emitComment("Standard Prelude:");
        emitRM("LD", gp, 0, ac, "load gp with maxaddress");
        emitRM("LDA", fp, 0, gp, "copy to gp to fp");
        emitRM("ST", ac, 0, ac, "clear value at location 0");
		
		//Jump to a different instruction
		emitRM("ST", ac, retFO, fp, "store return");

		//Finale
		emitRM( "ST", fp, globalOffset + ofpFO, fp, "push ofp" );
		emitRM( "LDA", fp, globalOffset, fp, "push frame" );
		emitRM( "LDA", ac, 1, pc, "load ac with ret ptr" );
		emitRM_Abs( "LDA", pc, mainEntry, "jump to main loc" );
		emitRM( "LD", fp, ofpFO, fp, "pop frame" );

		//TODO: end of execution comment?
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

	}
  
	public void visit( BoolExp exp, int level, boolean isAddr){

	}
  
	public void visit( VarExp exp, int level, boolean isAddr){

	}
  
	public void visit( CallExp exp, int level, boolean isAddr){

	}
  
	public void visit( OpExp exp, int level, boolean isAddr){

	}
  
	public void visit( AssignExp exp, int level, boolean isAddr){

	}
  
	public void visit( IfExp exp, int level, boolean isAddr){

	}
  
	public void visit( WhileExp exp, int level, boolean isAddr){

	}
  
	public void visit( ReturnExp exp, int level, boolean isAddr){

	}
  
	public void visit( CompoundExp exp, int level, boolean isAddr){

	}

	public void visit( FuncDec exp, int level, boolean isAddr){

	}
  
	public void visit( SimpleDec exp, int level, boolean isAddr){

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
