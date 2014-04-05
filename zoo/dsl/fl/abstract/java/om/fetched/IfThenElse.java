package types;

/**
 * IfThenElse expression form
 */
public class IfThenElse extends Expr {
	public Expr ifExpr, thenExpr, elseExpr;
	public IfThenElse(Expr ifExpr, Expr thenExpr, Expr elseExpr) {
		this.ifExpr = ifExpr;
		this.thenExpr = thenExpr;
		this.elseExpr = elseExpr;
	}
	public void accept(Visitor v) {
		v.visit(this);
	}
}
