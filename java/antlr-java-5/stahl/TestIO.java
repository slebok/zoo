import java.io.*;

public class TestIO
{
    public static void main(String[] args) throws Exception
	{
		File file = new File(args[0]);
		String fileName = file.getName();
		BufferedReader reader = new BufferedReader(new FileReader(file));

		//Create a scanner that reads from the input stream passed to us
		JavaLexer lexer = new JavaLexer(reader);
		lexer.setFilename(fileName);

		//Create a parser that reads from the scanner
		JavaRecognizer parser = new JavaRecognizer(lexer);
		parser.setFilename(fileName);

		//start parsing at the compilationUnit rule
		parser.compilationUnit();
    }
}
