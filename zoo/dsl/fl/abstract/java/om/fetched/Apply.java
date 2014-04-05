package types;

import java.util.LinkedList;

/**
 * The application form of expression
 */
public class Apply extends Expr {
	public String name;
	public LinkedList<Expr> args;
	public Apply(String name, LinkedList<Expr> args) {
		this.name = name;
		this.args = args;
	}
	public void accept(Visitor v) {
		v.visit(this);
	}
}
