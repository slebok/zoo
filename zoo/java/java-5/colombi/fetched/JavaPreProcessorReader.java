import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;

class State{

	static final int Start= 1, Slash= 2, SlashEven= 4, U0= 8, U1= 16, U2= 32, U3= 64, Queue= 128, EOF= 256, Peek= 512;
}

public class JavaPreProcessorReader extends Reader{

	private Reader resultReader;

	private int[] charStack;
	private int peek= 0;
	private int top= 0;

	public JavaPreProcessorReader(String source) throws IOException{
		Reader reader= new StringReader(source);
		charStack= new int[source.length()];
		clearBuffer();

		String result= "";

		int state= State.Start;
		int x;
		while (state != State.EOF){
			switch (state){
			// stato iniziale
			case State.Start:
				x= reader.read();
				if(x == -1) state=(State.EOF);
				else if(x == '\\'){
					state=(State.Slash);
					charStack[top++ ]=(x);
				}else result+= (char)x;
				break;
			// aveva trovato \
			case State.Slash:
				x= reader.read();
				if(x == '\\'){
					state=(State.SlashEven);
					result+= (char)x;
				}else if(x == 'u'){
					state=(State.U0);
					charStack[top++ ]=(x);
				}else{
					charStack[top++ ]=(x);
					state=(State.Queue);
				}
				break;
			// aveva trovato \\
			case State.SlashEven:
				x= reader.read();
				if(x == '\\'){
					state=(State.Slash);
					result+= (char)x;
				}else{
					charStack[top++ ]=(x);
					state=(State.Queue);
				}
				break;
			// aveva trovato \(u)+
			case State.U0:
				charStack[top++ ]=(x= reader.read());
				if(isHexDigit(x)) state=(State.U1);
				else if(x != 'u') state=(State.Queue);
				break;
			// aveva trovato \(u)+<HEX>
			case State.U1:
				charStack[top++ ]=(x= reader.read());
				if(isHexDigit(x)) state=(State.U2);
				else state=(State.Queue);
				break;
			// aveva trovato \(u)+<HEX><HEX>
			case State.U2:
				charStack[top++ ]=(x= reader.read());
				if(isHexDigit(x)) state=(State.U3);
				else state=(State.Queue);
				break;
			// aveva trovato \(u)+<HEX><HEX><HEX>
			case State.U3:
				x= reader.read();
				if(isHexDigit(x)){
					int d4= convertToDigit(x);
					int d3= convertToDigit(charStack[top-- ]);
					int d2= convertToDigit(charStack[top-- ]);
					int d1= convertToDigit(charStack[top-- ]);
					char c= createChar(d1, d2, d3, d4);
					clearBuffer();
					state=(State.Start);
					result+= (char)c;
				}else{
					charStack[top++ ]=(x);
					state=(State.Queue);
				}
				break;
			// nessuno dei precedenti
			case State.Queue:
				if(peek >= top){
					state=(State.Start);
					clearBuffer();
					peek= 0;
				}else{
					x= dequeue();
					if(x == -1) state=(State.EOF);
					else result+= (char)x;
				}
				break;
			}
		}

		reader.close();
		this.resultReader= new StringReader(result);
	}

	private boolean isHexDigit(int i){
		return ( (i >= 'a' && i <= 'f') || (i >= 'A' && i <= 'F') || (i >= '0' && i <= '9'));
	}

	private int convertToDigit(int i){
		if(i >= 'a' && i <= 'f') return i - 'a' + 10;
		else if(i >= 'A' && i <= 'F') return i - 'A' + 10;
		else if(i >= '0' && i <= '9') return i - '0';
		else return 0;
	}

	private char createChar(int d0, int d1, int d2, int d3){
		return (char) ( (d0 << 12) | (d1 << 8) | (d2 << 4) | d3);
	}

	private int dequeue(){
		int peeked= charStack[peek];
		if( ++peek >= top || peeked == -1) clearBuffer();
		return peeked;
	}

	private void clearBuffer(){
		top= 0;
		peek= 0;
	}

	public void close() throws IOException{
		resultReader.close();
	}

	@Override
	public int read(char[] buffer, int offset, int count) throws IOException{
		return resultReader.read(buffer, offset, count);
	}
}
