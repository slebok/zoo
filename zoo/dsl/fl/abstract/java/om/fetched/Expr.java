package types;

/**
 * The abstract base class of all expression forms of TFPL
 */
public abstract class Expr {
	public abstract void accept(Visitor v);
}
