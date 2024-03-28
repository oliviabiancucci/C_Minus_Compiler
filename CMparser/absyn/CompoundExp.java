package absyn;

public class CompoundExp extends Exp{
    public VarDecLists decs;
    public ExpList exp;

    public CompoundExp(int row, int col, VarDecLists decs, ExpList exp)
    {
        this.row = row;
        this.col = col;
        this.decs = decs;
        this.exp = exp;
    }

    public void accept( AbsynVisitor visitor, int level, boolean isAddr)
    {
        visitor.visit(this, level, isAddr);
    }
}
