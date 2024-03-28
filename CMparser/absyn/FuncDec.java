package absyn;

public class FuncDec extends Dec{
	public NameTy result;
	public String func;
	public VarDecLists params;
	public Exp body;
	public int funAddr;

	public FuncDec(int row, int col, NameTy result, String func, VarDecLists params, Exp body)
	{
		this.row = row;
		this.col = col;
		this.result = result;
		this.func = func;
		this.params = params;
		this.body = body;
	}

	public String toString()
    {
		String retString = "(";
		int numParams = 0;

		if(params == null)
		{
			retString = retString + "VOID";
		}
	
		while(params != null)
		{
			if(numParams > 0)
			{
				retString = retString + ", ";
			}

			if(params.head instanceof SimpleDec)
			{
				SimpleDec simp = (SimpleDec)params.head;
				if(simp.typ.type == NameTy.BOOL)
				{
					retString = retString + "BOOL";
				}
				else if(simp.typ.type == NameTy.INT)
				{
					retString = retString + "INT";
				}
				else if(simp.typ.type == NameTy.VOID)
				{
					retString = retString + "VOID";
				} 
				numParams++;
			}
			else if(params.head instanceof ArrayDec)
			{
				ArrayDec array = (ArrayDec)params.head;
				if(array.type.type == NameTy.BOOL)
				{
					retString = retString + "BOOL[]";
				}
				else if(array.type.type == NameTy.INT)
				{
					retString = retString + "INT[]";
				}
				else if(array.type.type == NameTy.VOID)
				{
					retString = retString + "VOID";
				}
				numParams++;
			}
			
			params = params.tail;
		}
		retString = retString + ") -> ";

        if(this.result.type == NameTy.BOOL)
        {
            retString = retString + "BOOL";
        }
        else if(this.result.type == NameTy.INT)
        {
            retString = retString + "INT";
        }
        else if(this.result.type == NameTy.VOID)
        {
            retString = retString + "VOID";
        }
		else
		{
			retString = retString + "INT";
		}
    
		return retString;
    }
	
	public void accept( AbsynVisitor visitor, int level, boolean isAddr) {
		visitor.visit( this, level, isAddr );
	}
}
