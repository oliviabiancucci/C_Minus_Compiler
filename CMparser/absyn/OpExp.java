package absyn;

public class OpExp extends Exp {
  public final static int PLUS   = 0;
  public final static int MINUS  = 1;
  public final static int TIMES  = 2;
  public final static int DIVIDE   = 3;
  public final static int EQ     = 4;
  public final static int LT     = 5;
  public final static int GT     = 6;
  public final static int UMINUS = 7;
  public final static int COMP   = 8;
  public final static int NE     = 9;
  public final static int TILDA    = 10;
  public final static int LTE    = 11;
  public final static int GTE    = 12;
  public final static int AND    = 13;
  public final static int OR     = 14;

  public Exp left;
  public int op;
  public Exp right;

  public OpExp( int row, int col, Exp left, int op, Exp right ) {
    this.row = row;
    this.col = col;
    this.left = left;
    this.op = op;
    this.right = right;
  }

  public void accept( AbsynVisitor visitor, int level, boolean isAddr) {
    visitor.visit( this, level, isAddr );
  }
}
