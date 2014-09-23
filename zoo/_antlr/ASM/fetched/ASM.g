/** This grammar is generated with antlrworks in order to parse an asm source
code.First of all the lexical rules established here do not replace the ones 
generated in JFlex we used in EditorASM to color the tokens, instead they are used
to provide the necessary tokens for the parser.
**/

grammar ASM;
options {k=2; backtrack=true; memoize=true;}
tokens{
	DS='ds';
	ES='es';
	CS='cs';
	SS='ss';
	GS='gs';
	FS = 'fs';
	AH='ah';
	AL='al';
	AX='ax';
	BH='bh';
	BL='bl';
	BX='bx';
	CH='ch';
	CL='cl';
	CX='cx';
	DH='dh';
	DL='dl';
	DX='dx';
	SI='si';
	DI='di';
	SP='sp';
	BP='bp';
	EAX='eax';
	EBX='ebx';
	ECX='ecx';
	EDX='edx';
	ESI='esi';
	EDI='edi';
	ESP='esp';
	EBP='ebp';
	MOV='mov';
	CMP='cmp';
	TEST='test';
	PUSH='push';
	POP='pop';
	IDIV='idiv';
	INC='inc';
	DEC='dec';
	NEG='neg';
	MUL='mul';
	DIV='div';
	IMUL='imul';
	NOT='not';
	SETPO='setpo';
	SETAE='setae';
	SETNLE='setnle';
	SETC='setc';
	SETNO='setno';
	SETNB='setnb';
	SETP='setp';
	SETNGE='setnge';
	SETL='setl';
	SETGE='setge';
	SETPE='setpe';
	SETNL='setnl';
	SETNZ='setnz';
	SETNE='setne';
	SETNC='setnc';
	SETBE='setbe';
	SETNP='setnp';
	SETNS='setns';
	SETO='seto';
	SETNA='setna';
	SETNAE='setnae';
	SETZ='setz';
	SETLE='setle';
	SETNBE='setnbe';
	SETS='sets';
	SETE='sete';
	SETB='setb';
	SETA='seta';
	SETG='setg';
	SETNG='setng';
	XCHG='xchg';
	POPAD='popad';
	AAA='aaa';
	POPA='popa';
	POPFD='popfd';
	CWD='cwd';
	LAHF='lahf';
	PUSHAD='pushad';
	PUSHF='pushf';
	AAS='aas';
	BSWAP='bswap';
	PUSHFD='pushfd';
	CBW='cbw';
	CWDE='cwde';
	XLAT='xlat';
	AAM='aam';
	AAD='aad';
	CDQ='cdq';
	DAA='daa';
	SAHF='sahf';
	DAS='das';
	INTO='into';
	IRET='iret';
	CLC='clc';
	STC='stc';
	CMC='cmc';
	CLD='cld';
	STD='std';
	CLI='cli';
	STI='sti';
	MOVSB='movsb';
	MOVSW='movsw';
	MOVSD='movsd';
	LODS='lods';
	LODSB='lodsb';
	LODSW='lodsw';
	LODSD='lodsd';
	STOS='stos';
	STOSB='stosb';
	STOSW='stosw';
	SOTSD='sotsd';
	SCAS='scas';
	SCASB='scasb';
	SCASW='scasw';
	SCASD='scasd';
	CMPS='cmps';
	CMPSB='cmpsb';
	CMPSW='cmpsw';
	CMPSD='cmpsd';
	INSB='insb';
	INSW='insw';
	INSD='insd';
	OUTSB='outsb';
	OUTSW='outsw';
	OUTSD='outsd';
	ADC='adc';
	ADD='add';
	SUB='sub';
	CBB='cbb';
	XOR='xor';
	OR='or';
	JNBE='jnbe';
	JNZ='jnz';
	JPO='jpo';
	JZ='jz';
	JS='js';
	LOOPNZ='loopnz';
	JGE='jge';
	JB='jb';
	JNB='jnb';
	JO='jo';
	JP='jp';
	JNO='jno';
	JNL='jnl';
	JNAE='jnae';
	LOOPZ='loopz';
	JMP='jmp';
	JNP='jnp';
	LOOP='loop';
	JL='jl';
	JCXZ='jcxz';
	JAE='jae';
	JNGE='jnge';
	JA='ja';
	LOOPNE='loopne';
	LOOPE='loope';
	JG='jg';
	JNLE='jnle';
	JE='je';
	JNC='jnc';
	JC='jc';
	JNA='jna';
	JBE='jbe';
	JLE='jle';
	JPE='jpe';
	JNS='jns';
	JECXZ='jecxz';
	JNG='jng';
	MOVZX='movzx';
	BSF='bsf';
	BSR='bsr';
	LES='les';
	LEA='lea';
	LDS='lds';
	INS='ins';
	OUTS='outs';
	XADD='xadd';
	CMPXCHG='cmpxchg';
	SHL='shl';
	SHR='shr';
	ROR='ror';
	ROL='rol';
	RCL='rcl';
	SAL='sal';
	RCR='rcr';
	SAR='sar';
	SHRD='shrd';
	SHLD='shld';
	BTR='btr';
	BT='bt';
	BTC='btc';
	CALL='call';
	INT='int';
	RETN='retn';
	RET='ret';
	RETF='retf';
	IN='in';
	OUT='out';
	REP='rep';
	REPE='repe';
	REPZ='repz';
	REPNE='repne';
	REPNZ='repnz';
	ALPHA='.alpha';
	CONST='.const';
	CREF='.cref';
	XCREF='.xcref';
	DATA='data';
	DATA2='data?';
	DOSSEG='dosseg';
	ERR='.err';
	ERR1='.err1';
	ERR2='.err2';
	ERRE='.erre';
	ERRNZ='.errnz';
	ERRDEF='.errdef';
	ERRNDEF='.errndef';
	ERRB='.errb';
	ERRNB='.errnb';
	ERRIDN='.erridn[i]';
	ERRDIF='.errdif[i]';
	EVEN='even';
	LIST='.list';
	WIDTH='width';
	MASK='mask';
	SEQ='.seq';
	XLIST='.xlist';
	EXIT='.exit';
	MODEL='.model';
	BYTE='byte';
	SBYTE='sbyte';
	DB='db';
	WORD='word';
	SWORD='sword';
	DW='dw';
	DWORD='dword';
	SDWORD='sdword';
	DD='dd';
	FWORD='fword';
	DF='df';
	QWORD='qword';
	DQ='dq';
	TBYTE='tbyte';
	DT='dt';
	REAL4='real4';
	REAL8='real8';
	REAL='real';
	FAR='far';
	NEAR='near';
	PROC='proc';
	QUESTION='?';
	TIMES='times';
}
@header{ package com.Ostermiller.Syntax;}
@members{
private ArrayList<String> errores = new ArrayList<String>();
public void emitErrorMessage(String msg) {
	errores.add(msg);
}
public String getMensajes(){
	String mensaje=null;
	for(int i=0; i<errores.size(); i++){
		mensaje+=(String)errores.get(i) + "\n";
	}
	return mensaje;
}
}
//This are the parser rules for ASM
compilationUnit:
	(segments|directive_exp1)*
	'end' Identifier
	;

segments
options{k=4;}	:
	
	Identifier 'segments' 'para' 'public'
	(code|proc)*
	Identifier 'ends'
	;

proc	:
	Identifier 'proc'
	( code )*
	'ret'
	Identifier 'endp'
	;
	
code: 
      binary_exp1
      | binary_exp10
      | binary_exp11
      | binary_exp12
      | binary_exp2
      | binary_exp3
      | binary_exp4
      | binary_exp5
      | binary_exp6
      | binary_exp7
      | binary_exp8
      | binary_exp9
      | unuary_exp1
      | unuary_exp2
      | unuary_exp3
      | unuary_exp4
      | unuary_exp5
      | notarguments
      | variabledeclaration
      | directive_exp1	
	;
	
binary_exp1
	: o register Separator (register|Integer|memory)
	{String e="Found binary_exp1: "+$binary_exp1.text;
	errores.add(e);}
	| o memory Separator (register|Integer)
	{String e="Found binary_exp1: "+$binary_exp1.text;
	errores.add(e);}
	;
	
unuary_exp1
	: op (Integer|register|memory)
	{String e="Found unuary_exp1: "+$unuary_exp1.text;
	errores.add(e);}
	;
	
unuary_exp2
	: ope (register|memory)
	{String e="Found unuary_exp2: "+$unuary_exp2.text;
	errores.add(e);}
	;
	
binary_exp2
	: oper register Separator (register|memory)
	{String e="Found binary_exp2: "+$binary_exp2.text;
	errores.add(e);}
	| oper memory Separator register
	{String e="Found binary_exp2: "+$binary_exp2.text;
	errores.add(e);}
	;

notarguments
	: opera	{String e="Found not arguments exp: "+$notarguments.text;
	errores.add(e);};
	
binary_exp3
	: operat (register|memory) Separator (register|Integer|memory)
	{String e="Found binary_exp3: "+$binary_exp3.text;
	errores.add(e);}
	;
	
unuary_exp3
	: operato Identifier
	{String e="Found unuary_exp3: "+$unuary_exp3.text;
	errores.add(e);}	
	;
	
binary_exp4
	: operator register Separator (register|memory)
	{String e="Found binary_exp4: "+$binary_exp4.text;
	errores.add(e);}
	;
	
binary_exp5
	: l register Separator memory
	{String e="Found binary_exp5: "+$binary_exp5.text;
	errores.add(e);}
	;
	
binary_exp6
	: x (register|memory) Separator register
	{String e="Found binary_exp6: "+$binary_exp6.text;
	errores.add(e);}
	;

binary_exp7
	: s (register|memory) Separator (Integer|register)
	{String e="Found binary_exp7: "+$binary_exp7.text;
	errores.add(e);}
	;
	
binary_exp8
	: sh (register|memory) Separator register Separator (register|Integer)
	{String e="Found binary_exp8: "+$binary_exp8.text;
	errores.add(e);}
	;

binary_exp9
	: b (register|memory) Separator (register|memory)
	{String e="Found binary_exp9: "+$binary_exp9.text;
	errores.add(e);}
	;
	
unuary_exp4
	: call (register|memory|Integer)
	{String e="Found unuary_exp4: "+$unuary_exp4.text;
	errores.add(e);}
	;
	
unuary_exp5
	: interruption Integer	
	{String e="Found unuary_exp5: "+$unuary_exp5.text;
	errores.add(e);}
	;
	
binary_exp10
	: in register Separator (register|Integer)
	{String e="Found binary_exp10: "+$binary_exp10.text;
	errores.add(e);}
	;
	
binary_exp11
	: out (register|Integer) Separator register
	{String e="Found binary_exp11: "+$binary_exp11.text;
	errores.add(e);}
	;
	
binary_exp12
	: re opera	
	{String e="Found binary_exp12: "+$binary_exp12.text;
	errores.add(e);}
	;
	
directive_exp1	:	(directives Identifier | directives) 	{String e="Found directive_exp1: "+$directive_exp1.text;
	errores.add(e);};
	
variabledeclaration
	: Identifier ty (question|String|Integer) 	{String e="Found variable declaration: "+$variabledeclaration.text;
	errores.add(e);}
	;
	
memory	:
	'[' (register|Identifier) ('+' ((register ('+' (Integer|Hexnum|Octalnum))? )|Integer|Hexnum|Octalnum))? ']'
	;
	
/*option1	: '[' register ('+') register ']';
	
option2	:	('[') register ('+') (Integer|Hexnum|Octalnum) (']');
	
option3	:	('[') register ('+') register ('+') (Integer|Hexnum|Octalnum) (']');*/

segmentos: DS | ES | CS | SS | GS | FS;
register:AH|AL|AX|BH|BL|BX|CH|CL|CX|DH|DL|DX|SI|DI|SP|BP|EAX|EBX|ECX|EDX|ESI|EDI|ESP|EBP;
o:	MOV|CMP|TEST;
op:	PUSH;
ope:	POP|IDIV|INC|DEC|NEG|MUL|DIV|IMUL|NOT|SETPO|SETAE|SETNLE|SETC|SETNO|SETNB|SETP|SETNGE|SETL|SETGE|SETPE|SETNL|SETNZ|SETNE|SETNC|SETBE|SETNP|SETNS|SETO|SETNA|SETNAE|SETZ|SETLE|SETNBE|SETS|SETE|SETB|SETA|SETG|SETNG;
oper:	XCHG;
opera:	POPAD|AAA|POPA|POPFD|CWD|LAHF|PUSHAD|PUSHF|AAS|BSWAP|PUSHFD|CBW|CWDE|XLAT|AAM|AAD|CDQ|DAA|SAHF|DAS|INTO|IRET|CLC|STC|CMC|CLD|STD|CLI|STI|MOVSB|MOVSW|MOVSD|LODS|LODSB|LODSW|LODSD|STOS|STOSB|STOSW|SOTSD|SCAS|SCASB|SCASW|SCASD|CMPS|CMPSB|CMPSW|CMPSD|INSB|INSW|INSD|OUTSB|OUTSW|OUTSD;
operat: ADC|ADD|SUB|CBB|XOR|OR;
operato:JNBE|JNZ|JPO|JZ|JS|LOOPNZ|JGE|JB|JNB|JO|JP|JNO|JNL|JNAE|LOOPZ|JMP|JNP|LOOP|JL|JCXZ|JAE|JNGE|JA|LOOPNE|LOOPE|JG|JNLE|JE|JNC|JC|JNA|JBE|JLE|JPE|JNS|JECXZ|JNG;
operator:MOVZX|BSF|BSR;
l:	LES|LEA|LDS|INS|OUTS;
x:	XADD|CMPXCHG;
s:	SHL|SHR|ROR|ROL|RCL|SAL|RCR|SAR;
sh:	SHRD|SHLD;
b:	BTR|BT|BTC;
call:	CALL;
interruption:	INT|RETN|RET|RETF;
in:	IN;
out:	OUT;
re:	REP|REPE|REPZ|REPNE|REPNZ;
directives: ALPHA|CONST|CREF|XCREF|DATA|DATA2|DOSSEG|ERR|ERR1|ERR2|ERRE|ERRNZ|ERRDEF|ERRNDEF|ERRB|ERRNB|ERRIDN|ERRDIF|EVEN|LIST|WIDTH|MASK|SEQ|XLIST|EXIT|MODEL;	 
ty:	BYTE|SBYTE|DB|WORD|SWORD|DW|DWORD|SDWORD|DD|FWORD|DF|QWORD|DQ|TBYTE|DT|REAL4|REAL8|REAL|FAR|NEAR|PROC;	
question: QUESTION;
time:	TIMES;

//So let's start  defining the ASM lexer
//Groups of reserved words
Identifier 
    :   Letter ('_'|Letter|Digit)*
    ;

//Special tokens	
Hexnum : HexDigit+ ('h'|'H') ;

Integer : (Digit+);

Octalnum : ('0'..'7')+ ('o'|'O') ;

fragment
HexDigit : ('0'..'9'|'a'..'f'|'A'..'F') ;
FloatingPointLiteral
    :   ('0'..'9')+ '.' ('0'..'9')* Exponent? 
    |   '.' ('0'..'9')+ Exponent? 
    |   ('0'..'9')+ Exponent  
	;


fragment
Exponent : ('e'|'E') ('+'|'-')? ('0'..'9')+ ;


String	:	' \'' ( '\\' . | ~('\\'|'\'') )* '\'';



fragment
Letter: ('a'..'z' | 'A'..'Z');
    
fragment
Digit
	:	'0'..'9';

Etiqueta
	:	 Identifier (':');
		
Separator
	:	',';
	
WS  :  (' '|'\t'|'\n'|'\r') {$channel=HIDDEN;} ;

LINE_COMMENT
    : ';' ~('\n'|'\r')* '\r'? '\n' {$channel=HIDDEN;}
    ;
