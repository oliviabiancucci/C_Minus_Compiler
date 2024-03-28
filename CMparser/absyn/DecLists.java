package absyn;

public class DecLists extends Absyn {
	public Dec head;
	public DecLists tail;
	
	public DecLists(Dec head, DecLists tail)
	{
		this.head = head;
		this.tail = tail;
	}

	public void accept( AbsynVisitor visitor, int level, boolean isAddr) {
		visitor.visit( this, level, isAddr );
	}
}
