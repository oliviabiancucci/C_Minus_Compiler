package absyn;

public class Vartype extends Absyn{
	public String type;
	
	public Vartype(String type)
	{
		this.type = type;
	}
	public void accept( AbsynVisitor visitor, int level ) {
		visitor.visit( this, level );
	}
}
