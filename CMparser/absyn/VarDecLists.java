package absyn;

public class VarDecLists extends Absyn{
	public VarDec head;
	public VarDecLists tail;
	
	public VarDecLists(VarDec head, VarDecLists tail)
	{
		this.head = head;
		this.tail = tail;
	}

	public void accept( AbsynVisitor visitor, int level, boolean isAddr) {
		visitor.visit( this, level, isAddr );
	}
	
}
