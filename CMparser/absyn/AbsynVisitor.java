package absyn;

public interface AbsynVisitor {

  //NameTy

  public void visit( NameTy exp, int level, boolean isAddr);

  //Vars

  public void visit( SimpleVar exp, int level, boolean isAddr);

  public void visit( IndexVar exp, int level, boolean isAddr);

  public void visit( Vartype exp, int level, boolean isAddr);

  //Exps

  public void visit( NilExp exp, int level, boolean isAddr);

  public void visit( IntExp exp, int level, boolean isAddr);

  public void visit( BoolExp exp, int level, boolean isAddr);

  public void visit( VarExp exp, int level, boolean isAddr);

  public void visit( CallExp exp, int level, boolean isAddr);

  public void visit( OpExp exp, int level, boolean isAddr);

  public void visit( AssignExp exp, int level, boolean isAddr);

  public void visit( IfExp exp, int level, boolean isAddr);

  public void visit( WhileExp exp, int level, boolean isAddr);

  public void visit( ReturnExp exp, int level, boolean isAddr);

  public void visit( CompoundExp exp, int level, boolean isAddr);

  //FunctionDec

  public void visit( FuncDec exp, int level, boolean isAddr);

  //Decs

  public void visit( SimpleDec exp, int level, boolean isAddr);

  public void visit( ArrayDec exp, int level, boolean isAddr);

  //lists

  public void visit( ExpList exp, int level, boolean isAddr);

  public void visit ( DecLists exp, int level, boolean isAddr);

  public void visit ( VarDecLists exp, int level, boolean isAddr);

}
