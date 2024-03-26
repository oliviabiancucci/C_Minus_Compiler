package absyn;

public class VarExp extends Exp {
  public Var varName;

  public VarExp( int row, int col, Var varName ) {
    this.row = row;
    this.col = col;
    this.varName = varName;
  }

  public void accept( AbsynVisitor visitor, int level ) {
    visitor.visit( this, level );
  }
}
