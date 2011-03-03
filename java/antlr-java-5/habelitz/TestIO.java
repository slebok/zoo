import org.antlr.runtime.*;
import java.io.*;
import com.habelitz.jsobjectizer.unmarshaller.antlrbridge.generated.*;

public class TestIO
{
    public static void main(String[] args) throws Exception
	{
		ANTLRFileStream input = new ANTLRFileStream(args[0]);
		JavaLexer lexer = new JavaLexer(input);
		CommonTokenStream tokens = new CommonTokenStream(lexer);
		JavaParser parser = new JavaParser(tokens);
		JavaParser.javaSource_return result = parser.javaSource();
    }
}
