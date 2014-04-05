package types;

import java.util.LinkedList;

/**
 * Programs as collections of functions
 */
public class Program {
        public LinkedList<Function> functions;
        public Program(LinkedList<Function> functions) {
	    this.functions = functions;
	}
	public void accept(Visitor v) {
		v.visit(this);
	}
}
