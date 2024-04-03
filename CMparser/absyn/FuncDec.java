package absyn;

import java.util.ArrayList;

public class FuncDec extends Dec{
	public NameTy result;
	public String func;
	public VarDecLists params;
	public Exp body;
	public int funAddr;
	public int[] funLocs = new int[1];

	public FuncDec(int row, int col, NameTy result, String func, VarDecLists params, Exp body)
	{
		this.row = row;
		this.col = col;
		this.result = result;
		this.func = func;
		this.params = params;
		this.body = body;
		this.funAddr = 0;
		this.funLocs[0] = -1;

	}

	public String toString()
    {
		String retString = "(";
		int numParams = 0;

		if(params == null)
		{
			retString = retString + "VOID";
		}
		
		VarDecLists temp = params;
		while(temp != null)
		{
			if(numParams > 0)
			{
				retString = retString + ", ";
			}

			if(temp.head instanceof SimpleDec)
			{
				SimpleDec simp = (SimpleDec)temp.head;
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
			else if(temp.head instanceof ArrayDec)
			{
				ArrayDec array = (ArrayDec)temp.head;
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
			
			temp = temp.tail;
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

	public void copyLocs()
	{
		int len = this.funLocs.length;
		int[] newList = new int[len + 1];

		System.arraycopy(this.funLocs, 0, newList, 0, len);
		this.funLocs = newList;
		funLocs[len] = -1;
	}
}
