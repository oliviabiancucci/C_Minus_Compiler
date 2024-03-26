import absyn.*;

public class ShowTreeVisitor implements AbsynVisitor {
  final static int SPACES = 4;

  private void indent( int level ) {
    for( int i = 0; i < level * SPACES; i++ ) System.out.print( " " );
  }

  //NameTy

  public void visit( NameTy exp, int level )
  {
    indent(level);
    System.out.print("NameTy: ");
    level++;
    if(exp == null)
    {
      System.out.println("Unrecognized value for field TYPE");
    }
    else
    {
      if(exp.type == 0)
      {
        System.out.println("BOOL");
      }
      else if(exp.type == 1)
      {
        System.out.println("INT");
      }
      else if(exp.type == 2)
      {
        System.out.println("VOID");
      }
      else 
      {
        System.out.println("Unrecognized value for field TYPE");
      }
    }
    
  }

  //Vars

  public void visit( SimpleVar exp, int level )
  {
    indent(level);
    System.out.println("SimpleVar: " + exp.name);
  }

  public void visit( IndexVar exp, int level )
  {
    indent(level);
    System.out.println("IndexVar : " + exp.name);
    level++;
    exp.index.accept(this, level);
  }

  //NilExp

  public void visit( NilExp exp, int level)
  {
    indent( level );
    System.out.println("NilExp");
  }

  //Exps

  public void visit( IntExp exp, int level ) {
    indent( level );
    System.out.println("IntExp: " + exp.value ); 
  }

  public void visit( BoolExp exp, int level )
  {
    indent (level);
    System.out.println("BoolExp: " + exp.value);
  }

  public void visit( VarExp exp, int level ) {
    indent( level );
    System.out.println("VarExp: ");
    level++;
    if(exp.varName != null)
    {
      exp.varName.accept(this, level);
    }
  }

  public void visit( CallExp exp, int level )
  {
    indent(level);
    System.out.println("CallExp: "+ exp.func);
    level++;
    if(exp.args != null)
    {
      exp.args.accept(this, level);
    }
  }

  public void visit( OpExp exp, int level ) {
    indent( level );
    System.out.print( "OpExp:" ); 
    switch( exp.op ) {
      case OpExp.PLUS:
        System.out.println( " + " );
        break;
      case OpExp.MINUS:
        System.out.println( " - " );
        break;
      case OpExp.UMINUS:
        System.out.println( " - " );
        break;
      case OpExp.TIMES:
        System.out.println( " * " );
        break;
      case OpExp.DIVIDE:
        System.out.println( " / " );
        break;
      case OpExp.EQ:
        System.out.println( " = " );
        break;
      case OpExp.COMP:
        System.out.println( " == " );
        break;
      case OpExp.NE:
        System.out.println(" != ");
        break;
      case OpExp.NOT:
        System.out.println( " ~ " );
        break;
      case OpExp.LT:
        System.out.println( " < " );
        break;
      case OpExp.LTE:
        System.out.println( " <= " );
        break;
      case OpExp.GT:
        System.out.println( " > " );
        break;
      case OpExp.GTE:
        System.out.println( " >= " );
        break;
      case OpExp.AND:
        System.out.println( " && " );
        break;
      case OpExp.OR:
        System.out.println( " || " );
        break;
      default:
        System.out.println( "Unrecognized operator at line " + exp.row + " and column " + exp.col);
    }
    level++;
    if (exp.left != null)
       exp.left.accept( this, level );
    else{
      indent(level);
      System.out.println("Unrecognized left side expression");
    }
    if (exp.right != null)
       exp.right.accept( this, level );
    else{
      indent(level);
      System.out.println("Unrecognized right side expression");
    }
  }

  public void visit( AssignExp exp, int level ) {
    indent( level );
    System.out.println( "AssignExp:" );
    level++;
    if (exp.lhs != null)
    {
      exp.lhs.accept( this, level );
    }
    if(exp.rhs != null)
    {
      exp.rhs.accept( this, level );
    }
  }

  public void visit( IfExp exp, int level ) {
    indent( level );
    System.out.println( "IfExp:" );
    level++;
    if (exp.test != null )
      exp.test.accept( this, level );
    else
    {
      indent( level );
      System.out.println("Missing condition");
    }
    if (exp.thenpart != null )
      exp.thenpart.accept( this, level );
    if (!(exp.elsepart instanceof NilExp))
    {
      indent(level - 1);
      System.out.println("ElseExp:");
      exp.elsepart.accept( this, level );
    }
  }

  public void visit( WhileExp exp, int level )
  {
    indent(level);
    System.out.println("WhileExp:");
    level++;
    if(exp.test != null)
    {
      exp.test.accept(this, level);
    }
    if(exp.body != null)
    {
      exp.body.accept(this, level);
    }
  }

  public void visit( ReturnExp exp, int level )
  {
    indent(level);
    System.out.println("ReturnExp:");
    level++;
    if(exp.exp != null)
    {
      exp.exp.accept(this, level);
    }
  }

  public void visit( CompoundExp exp, int level )
  {
    indent(level);
    System.out.println("CompoundExp:");
    level++;
    if(exp.decs != null)
    {
      exp.decs.accept(this, level);
    }
    if(exp.exp != null)
    {
      exp.exp.accept(this, level);
    }
  }

  //FunctionDec

  public void visit( FuncDec exp, int level)
  {
    indent(level);
    System.out.println("FunctionDec: " + exp.func);
    level++;

    if(exp.result != null)
    {
      exp.result.accept(this, level);
    }
    if(exp.params != null)
    {
      VarDecLists paramsList = exp.params;
      while (paramsList != null)
      {
        paramsList.head.accept(this, level);
        paramsList = paramsList.tail;
      }
    }
    if(exp.body != null)
    {
      exp.body.accept(this, level);
    }
  }

  //Decs

  public void visit( SimpleDec exp, int level )
  {
    indent(level);
    System.out.println("SimpleDec: " + exp.name);
    level++;
    if(exp.typ != null)
    {
      exp.typ.accept(this, level);
    }
  }

  public void visit( ArrayDec exp, int level )
  {
    indent(level);
    System.out.println("ArrayDec: " + exp.name);
    level++;
    if(exp.size > -1)
    {
      indent(level);
      System.out.println("Size: " + exp.size);
    }
    if(exp.type != null)
    {
      exp.type.accept(this, level);
    }
  }

  //Lists

  public void visit( VarDecLists exp, int level ) {
    while( exp != null ) {
      if(exp.head != null)
      {
        exp.head.accept( this, level );
      }
      exp = exp.tail;
    }
  }

  public void visit( DecLists exp, int level ) {
    while( exp != null ) {
      if(exp.head != null)
      {
        exp.head.accept( this, level );
      }
      exp = exp.tail;
    }
  }

  public void visit(ExpList exp, int level) {
    while (exp != null) {
        if (exp.head != null) {
            exp.head.accept(this, level);
        }
        exp = exp.tail;
    }
  }

  //Misc

  public void visit( Vartype exp, int level ) {
    indent( level );
    System.out.println( "Vartype: " + exp.type );
  }
/*
   //TODO: check this
   public void visit( Dec exp, int level ) {
    indent( level );
    System.out.println( "Declaration ");
  }
  */
}
