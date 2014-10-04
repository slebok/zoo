package types;

/**
 * Binary expressions
 */
public class Binary extends Expr {
        public Ops ops;
	public Expr left, right;
        public Binary(Ops o, Expr left, Expr right) {
                this.ops = o;
		this.left = left;
		this.right = right;
	}
	public void accept(Visitor v) {
		v.visit(this);
	}
}
