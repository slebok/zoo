package types;

/**
 * The literal (constant) form of expression
 */
public class Literal extends Expr {
	public int info;
	public Literal(int info) {
		this.info = info;
	}
	public void accept(Visitor v) {
		v.visit(this);
	}
}
