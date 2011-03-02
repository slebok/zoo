import org.antlr.runtime.*;
import java.io.*;

public class TestIO {
    public static void main(String[] args) throws Exception {

	// Parse file to program
	ANTLRFileStream input = new ANTLRFileStream(args[0]);
	JavaLexer lexer = new JavaLexer(input);
	CommonTokenStream tokens = new CommonTokenStream(lexer);
	JavaParser parser = new JavaParser(tokens);
	Program program = parser.program();

	// Pretty print program and save it in file
	PrettyPrinter pp = new PrettyPrinter();
	pp.visit(program);
	FileOutputStream output = new FileOutputStream (args[1]);
	new PrintStream(output).print(pp.getResult());
	output.close();	
    }
}
