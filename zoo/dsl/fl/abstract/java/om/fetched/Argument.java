package types;

/**
 * The form of expression for referring to function arguments
 */
public class Argument extends Expr {
	public String name;
	public Argument(String name) {
		this.name = name;
	}
	public void accept(Visitor v) {
		v.visit(this);
	}
}
