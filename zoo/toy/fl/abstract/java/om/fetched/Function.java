package types;

import java.util.LinkedList;

/**
 * Function definitions (equations) in TFPL
 */
public class Function {
	public String name;
	public LinkedList<String> args;
	public Expr rhs;
	public Function(String name, LinkedList<String> args, Expr rhs) {
		this.name = name;
		this.args = args;
		this.rhs = rhs;
	}
	public void accept(Visitor v) {
		v.visit(this);
	}
}
