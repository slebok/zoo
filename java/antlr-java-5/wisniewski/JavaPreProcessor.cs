using System.Collections.Generic;
using System.IO;
using System;
using System.Text;
using System.Diagnostics;

public class JavaPreProcessor : TextReader
{
	[Flags()]
	private enum State
	{
		Start = 1,
		Slash = 2,
		SlashEven = 4,
		U0 = 8,
		U1 = 16,
		U2 = 32,
		U3 = 64,
		Queue = 128,
		EOF = 256,
		Peek = 512
	}

	private const char nl_ = '\n';
	private const char cr_ = '\r';

	private TextReader reader_;
	private State state_;
	private List<int> buffer_;
	private int bufferPos_ = 0;
	private IEnumerator<int> enumerator_;
	private int peekChar_;

	public JavaPreProcessor(TextReader reader)
	{
		reader_ = reader;
		state_ = State.Start;
		buffer_ = new List<int>();
		bufferPos_ = 0;
		enumerator_ = FilterReader_();

	}

	private bool IsHexDigit_(int i)
	{
		return ((i >= 'a' && i <= 'f') || (i >= 'A' && i <= 'F') || (i >= '0' && i <= '9'));
	}

	private int ConvDigit_(int i)
	{
		if (i >= 'a' && i <= 'f')
			return i - 'a' + 10;
		else if (i >= 'A' && i <= 'F')
			return i - 'A' + 10;
		else if (i >= '0' && i <= '9')
			return i - '0';
		else
			return 0;
	}

	private char CreateChar_(int d0, int d1, int d2, int d3) {
		return (char)((d0 << 12) | (d1 << 8) | (d2 << 4) | d3);
	}

	private void Enqueue_(int i)
	{
		buffer_.Add(i);
	}

	private int QPeek_()
	{
		return buffer_[bufferPos_];
	}

	private int Dequeue_()
	{
		int ret = QPeek_();
		if (++bufferPos_ >= buffer_.Count || ret == -1)
		{
			buffer_.Clear();
			bufferPos_ = 0;
		}
		return ret;
	}

	private int SPeek_()
	{
		return buffer_[buffer_.Count - 1];
	}

	private int Pop_()
	{
		int ret = SPeek_();
		buffer_.RemoveAt(buffer_.Count - 1);
		return ret;
	}

	private void Transisition_(State state)
	{
		state_ = state;
	}

	private void Output_(int output)
	{
	}

	private int Read_()
	{
		int ret = reader_.Read();
		return ret;
	}

	private IEnumerator<int> FilterReader_()
	{
		state_ = State.Start;
		int x;
		while ((state_ & State.EOF) != State.EOF)
		{
			
			switch (state_)
			{
				case State.Start:
					x = Read_();
					if (x == -1)							
						Transisition_(State.EOF);
					else if (x == '\\')
					{
						Transisition_(State.Slash);
						Enqueue_(x);
					}
					else
					{
						Output_(x);
						yield return x;
					}
					break;
				case State.Slash:
					x = Read_();
					if (x == '\\')
					{
						Transisition_(State.SlashEven);
						Output_(x);
						yield return x;
					}
					else if (x == 'u')
					{
						Transisition_(State.U0);
						Enqueue_(x);
					}
					else
					{
						Enqueue_(x);
						Transisition_(State.Queue);
					}
					break;
				case State.SlashEven:
					x = Read_();
					if (x == '\\')
					{
						Transisition_(State.Slash);
						Output_(x);
						yield return x;
					}
					else
					{
						Enqueue_(x);
						Transisition_(State.Queue);
					}
					break;
				case State.U0:
					Enqueue_(x = Read_());
					if (IsHexDigit_(x))
						Transisition_(State.U1);
					else if (x != 'u')
						Transisition_(State.Queue);
					break;
				case State.U1:
					Enqueue_(x = Read_());
					if (IsHexDigit_(x))
						Transisition_(State.U2);
					else
						Transisition_(State.Queue);
					break;
				case State.U2:
					Enqueue_(x = Read_());
					if (IsHexDigit_(x))
						Transisition_(State.U3);
					else
						Transisition_(State.Queue);
					break;
				case State.U3:
					x = Read_();
					if (IsHexDigit_(x))
					{
						int d4 = ConvDigit_(x);
						int d3 = ConvDigit_(Pop_());
						int d2 = ConvDigit_(Pop_());
						int d1 = ConvDigit_(Pop_());
						char c = CreateChar_(d1, d2, d3, d4);
						buffer_.Clear();
						Transisition_(State.Start);
						Output_(c);
						yield return c;
					}
					else
					{
						Enqueue_(x);
						Transisition_(State.Queue);
					}
					break;
				case State.Queue:
					if (bufferPos_ >= buffer_.Count)
					{
						Transisition_(State.Start);
						buffer_.Clear();
						bufferPos_ = 0;
					}
					else
					{
						x = Dequeue_();
						if (x == -1)
							Transisition_(State.EOF);
						else
						{
							Output_(x);
							yield return x;
						}
					}
					break;
			}
		}
		yield break;
	}

	public override void Close()
	{
		reader_.Close();
		if (enumerator_ != null)
		{
			enumerator_.Dispose();
			enumerator_ = null;
		}
	}

	protected override void Dispose(bool disposing)
	{
		if (disposing)
		{
			if (reader_ != null)
			{
				((IDisposable)reader_).Dispose();
				reader_ = null;
			}
			if (enumerator_ != null)
			{
				enumerator_.Dispose();
				enumerator_ = null;
			}
		}				
	}

	public override int Peek()
	{
		if ((state_ & State.Peek) != State.Peek)
		{
			if (enumerator_.MoveNext())
				peekChar_ = enumerator_.Current;
			else
				peekChar_ = -1;
			state_ |= State.Peek;
		}
		return peekChar_;
	}

	public override int Read()
	{
		int ret = Peek();
		state_ &= ~State.Peek;
		return ret;
	}

	public override int Read(char[] buffer, int index, int count)
	{
		int readCount = 0;
		while (readCount < count && peekChar_ != -1 && index < buffer.Length)
		{
			Read();
			if (peekChar_ != -1)
			{
				buffer[index++] = (char)peekChar_;
				++readCount;
			}
		}
		return readCount;
	}

	public override int ReadBlock(char[] buffer, int index, int count)
	{
		return Read(buffer, index, count);
	}

	public override string ReadLine()
	{
		StringBuilder bldr = new StringBuilder();
		bool done = false;
		while (! done)
		{
			Read();
			if (peekChar_ == cr_)
			{
				done = true;
				if (Peek() == nl_)
					Read();
			}
			else if (peekChar_ == nl_ || peekChar_ == -1)
				done = true;
			else
				bldr.Append((char)peekChar_);
		}
		return bldr.ToString();
	}

	public override string ReadToEnd()
	{
		StringBuilder bldr = new StringBuilder();
		while (peekChar_ != -1)
		{
			bldr.Append((char)Read());	
		}
		return bldr.ToString();
	}
}

