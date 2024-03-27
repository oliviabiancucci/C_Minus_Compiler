import absyn.*;

public class CodeGenerator implements AbsynVisitor{

	int emitLoc = 0;
	int highEmitLoc = 0;


	//from slide deck 11, slide number 24
	void emitRO( String op, int r, int s, int t, String c ) {
		System.out.printf("%3d: %5s %d, %d, %d", emitLoc, op, r, s, t);
        System.out.printf("\t%s\n", c);
		++emitLoc;
		if( highEmitLoc < emitLoc ) highEmitLoc = emitLoc;
	}

	//from slide deck 11, slide number 24
	void emitRM( String op, int r, int d, int s, String c ) {
		System.out.printf( "%3d: %5s %d, %d(%d)", emitLoc, op, r, d, s );
		System.out.printf( "\t%s\n", c );
		++emitLoc;
		if( highEmitLoc < emitLoc ) highEmitLoc = emitLoc;
	}

	//from slide deck 11, slide number 24
	void emitRM_Abs( String op, int r, int a, String c ) {
		System.out.printf( "%3d: %5s %d, %d(%d)", emitLoc, op, r, (a - (emitLoc + 1)), pc );
		System.out.printf( "\t%s\n", c );
		++emitLoc;
		if( highEmitLoc < emitLoc ) highEmitLoc = emitLoc;
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
