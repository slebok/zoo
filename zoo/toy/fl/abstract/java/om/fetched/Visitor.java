package types;

/**
 * The abstract visitor for TFPL
 */
public abstract class Visitor {
	public abstract void visit(Program x);
	public abstract void visit(Function x);
	public abstract void visit(Literal x);
	public abstract void visit(Argument x);
	public abstract void visit(Binary x);
	public abstract void visit(Apply x);
	public abstract void visit(IfThenElse x);
}
