package absyn;

public class ArrayDec extends VarDec
{
    public NameTy type;
	public String name;
    public int size;

    public ArrayDec(int row, int col, NameTy type, String name, int size)
    {
        this.row = row;
        this.col = col;
        this.type = type;
        this.name = name;
        this.size = size;
    }

    public String toString()
    {
        if(this.type.type == NameTy.BOOL)
        {
            return "BOOL[]";
        }
        else if(this.type.type == NameTy.INT)
        {
            return "INT[]";
        }
        else if(this.type.type == NameTy.VOID)
        {
            return "VOID";
        }
        return "INT[]";
    }

    public void accept( AbsynVisitor visitor, int level, boolean isAddr) {
		visitor.visit( this, level, isAddr);
	}
}
