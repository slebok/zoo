grammar JavaRecognizer;

compilationUnit
	:	
		(	packageDefinition|	EPSILON
		)

		
		( importDefinition )*

		
		
		( typeDefinition )*

		EOF
	;



packageDefinition
	
	:	annotations p='package' identifier SEMI
	;



importDefinition: i='import' ( 'static' )? identifierStar SEMI
	;


typeDefinition: m=modifiers
		typeDefinitionInternal
	|	SEMI
	;


typeDefinitionInternal: classDefinition		
	|	interfaceDefinition	
	|	enumDefinition		
	|	annotationDefinition	
	;



declaration: m=modifiers t=typeSpec v=variableDefinitions
	;



typeSpec: classTypeSpec
	|	builtInTypeSpec
	;





classTypeSpec: classOrInterfaceType
		(lb=LBRACK RBRACK
		)*
	;


classOrInterfaceType: IDENT (typeArguments)?
		(DOT
			IDENT (typeArguments)?
		)*
	;


typeArgumentSpec
	:	classTypeSpec
	|	builtInTypeArraySpec
	;


typeArgument
	:	(	typeArgumentSpec
		|	wildcardType
		)
	;


wildcardType
	:	q=QUESTION
		(typeArgumentBounds)?
	;


typeArguments: LT
		typeArgument
		(COMMA typeArgument
		)*

		(	
			
			typeArgumentsOrParametersEnd
		)?;



typeArgumentsOrParametersEnd: GT
	|	SR
	|	BSR
	;


typeArgumentBounds: ( 'extends' | 'super' ) classOrInterfaceType
	;


builtInTypeArraySpec: builtInType
		(lb=LBRACK RBRACK
		)+
	;



builtInTypeSpec: builtInType
		(lb=LBRACK RBRACK
		)*
	;



type
	:	classOrInterfaceType
	|	builtInType
	;


builtInType
	:	'void'
	|	'boolean'
	|	'byte'
	|	'char'
	|	'short'
	|	'int'
	|	'float'
	|	'long'
	|	'double'
	;



identifier
	:	IDENT ( DOT IDENT )*
	;

identifierStar
	:	IDENT
		( DOT IDENT )*
		( DOT STAR )?
	;





modifiers
	:
		(
			
			modifier
			|
			
			
			annotation)*
	;


modifier
	:	'private'
	|	'public'
	|	'protected'
	|	'static'
	|	'transient'
	|	'final'
	|	'abstract'
	|	'native'
	|	'threadsafe'
	|	'synchronized'
	|	'volatile'
	|	'strictfp'
	;

annotation: AT i=identifier ( LPAREN ( args=annotationArguments )? RPAREN )?
	;

annotations
    :   (annotation)*
    ;

annotationArguments
	:	annotationMemberValueInitializer | anntotationMemberValuePairs
	;

anntotationMemberValuePairs
	:	annotationMemberValuePair ( COMMA annotationMemberValuePair )*
	;

annotationMemberValuePair: i=IDENT ASSIGN v=annotationMemberValueInitializer
	;

annotationMemberValueInitializer
	:
		conditionalExpression | annotation | annotationMemberArrayInitializer
	;


annotationMemberArrayInitializer
	:	lc=LCURLY
			(	annotationMemberArrayValueInitializer
				(
					
					
					
					
					COMMA annotationMemberArrayValueInitializer
				)*
				(COMMA)?
			)?
		RCURLY
	;



annotationMemberArrayValueInitializer
	:	conditionalExpression
	|	annotation
	;

superClassClause: ( 'extends' c=classOrInterfaceType )?
	;


classDefinition: 'class' IDENT
		
		(tp=typeParameters)?
		
		sc=superClassClause
		
		ic=implementsClause
		
		cb=classBlock
	;


interfaceDefinition: 'interface' IDENT
		
		(tp=typeParameters)?
		
		ie=interfaceExtends
		
		ib=interfaceBlock
	;

enumDefinition: 'enum' IDENT
		
		ic=implementsClause
		
		eb=enumBlock
	;

annotationDefinition: AT 'interface' IDENT
		
		ab=annotationBlock
	;

typeParameters: LT
		typeParameter (COMMA typeParameter)*
		(typeArgumentsOrParametersEnd)?;

typeParameter
	:
		
		(id=IDENT) ( typeParameterBounds )?
	;

typeParameterBounds
	:
		'extends' classOrInterfaceType
		(BAND classOrInterfaceType)*
	;


classBlock
	:	LCURLY
			( classField | SEMI )*
		RCURLY
	;


interfaceBlock
	:	LCURLY
			( interfaceField | SEMI )*
		RCURLY
	;
	


annotationBlock
	:	LCURLY
		( annotationField | SEMI )*
		RCURLY
	;



enumBlock
	:	LCURLY
			( enumConstant ( COMMA enumConstant )* ( COMMA )? )?
			( SEMI ( classField | SEMI )* )?
		RCURLY
	;


annotationField: mods=modifiers
		(	td=typeDefinitionInternal
		|	t=typeSpec		
			(	i=IDENT				

				LPAREN RPAREN

				rt=declaratorBrackets

				( 'default' amvi=annotationMemberValueInitializer )?

				SEMI
			|	v=variableDefinitions SEMI
			)
		)
	;



enumConstant: an=annotations
		i=IDENT
		(	LPAREN
			a=argList
			RPAREN
		)?
		( b=enumConstantBlock )?
	;


enumConstantBlock
	:	LCURLY
		( enumConstantField | SEMI )*
		RCURLY
	;



enumConstantField: mods=modifiers
		(	td=typeDefinitionInternal

		|	
			
			
			(tp=typeParameters)? t=typeSpec		
			(	IDENT									

				
				LPAREN param=parameterDeclarationList RPAREN

				rt=declaratorBrackets

				
				
				(tc=throwsClause)?

				( s2=compoundStatement | SEMI )
			|	v=variableDefinitions SEMI
			)
		)

	
	|	s4=compoundStatement
	;


interfaceExtends
	:	(
		e='extends'
		classOrInterfaceType ( COMMA classOrInterfaceType )*
		)?
	;


implementsClause
	:	(
			i='implements' classOrInterfaceType ( COMMA classOrInterfaceType )*
		)?
	;


classField: mods=modifiers
		(	td=typeDefinitionInternal

		|	(tp=typeParameters)?
			(
				h=ctorHead s=constructorBody

				|	
					
					
					t=typeSpec		
					(	IDENT				

						
						LPAREN param=parameterDeclarationList RPAREN

						rt=declaratorBrackets

						
						
						(tc=throwsClause)?

						( s2=compoundStatement | SEMI )
					|	v=variableDefinitions SEMI
					)
			)
		)

	
	|	'static' s3=compoundStatement

	
	|	s4=compoundStatement
	;


interfaceField: mods=modifiers
		(	td=typeDefinitionInternal

		|	(tp=typeParameters)?
			
			
			
			
			t=typeSpec		
			(	IDENT				

				
				LPAREN param=parameterDeclarationList RPAREN

				rt=declaratorBrackets

				
				
				(tc=throwsClause)?

				SEMI
			|	v=variableDefinitions SEMI
			)
		)
	;

constructorBody
	:	lc=LCURLY
			( explicitConstructorInvocation)?
			(statement)*
		RCURLY
	;


explicitConstructorInvocation
	:	(typeArguments)?
		(	'this' lp1=LPAREN argList RPAREN SEMI
		|	'super' lp2=LPAREN argList RPAREN SEMI
		)
	;

variableDefinitions: variableDeclarator 
		(	COMMA
			variableDeclarator 
		)*
	;





variableDeclarator: id=IDENT d=declaratorBrackets v=varInitializer
	;

declaratorBrackets: (lb=LBRACK RBRACK)*;

varInitializer
	:	( ASSIGN initializer )?
	;


arrayInitializer
	:	lc=LCURLY
			(	initializer
				(
					
					
					
					
					COMMA initializer
				)*
				(COMMA)?
			)?
		RCURLY
	;




initializer
	:	expression
	|	arrayInitializer
	;




ctorHead
	:	IDENT 

		
		LPAREN parameterDeclarationList RPAREN

		
		(throwsClause)?
	;


throwsClause
	:	'throws' identifier ( COMMA identifier )*
	;




parameterDeclarationList
	
	
	:	(	parameterDeclaration
			( COMMA parameterDeclaration )*
			( COMMA variableLengthParameterDeclaration )?|
			variableLengthParameterDeclaration
		)?
	;


parameterDeclaration: pm=parameterModifier t=typeSpec id=IDENT
		pd=declaratorBrackets
	;

variableLengthParameterDeclaration: pm=parameterModifier t=typeSpec TRIPLE_DOT id=IDENT
		pd=declaratorBrackets
	;

parameterModifier
	
	
	:	(annotation)* (f='final')? (annotation)*
	;










compoundStatement
	:	lc=LCURLY
			
			(statement)*
		RCURLY
	;


statement
	
	:	compoundStatement

	
	
	
	
	|	declaration SEMI|	expression SEMI

	
	
	|	m=modifiers classDefinition

	
	|	IDENT c=COLON statement

	
	|	'if' LPAREN expression RPAREN statement
		(
			
			
			
			'else' statement
		)?

	
	|	forStatement

	
	|	'while' LPAREN expression RPAREN statement

	
	|	'do' statement 'while' LPAREN expression RPAREN SEMI

	
	|	'break' (IDENT)? SEMI

	
	|	'continue' (IDENT)? SEMI

	
	|	'return' (expression)? SEMI

	
	|	'switch' LPAREN expression RPAREN LCURLY
			( casesGroup )*
		RCURLY

	
	|	tryBlock

	
	|	'throw' expression SEMI

	
	|	'synchronized' LPAREN expression RPAREN compoundStatement

	
	|	'assert' expression ( COLON expression )? SEMI

	
	|	s=SEMI
	;

forStatement
	:	f='for'
		LPAREN
			(	traditionalForClause|	forEachClause
			)
		RPAREN
		statement					 
	;

traditionalForClause
	:
		forInit SEMI	
		forCond SEMI	
		forIter			
	;

forEachClause
	:
		p=parameterDeclaration COLON expression
	;

casesGroup
	:	(	
			
			
			
			aCase
		)+
		caseSList
	;

aCase
	:	('case' expression | 'default') COLON
	;

caseSList
	:	(statement)*
	;


forInit
		
	:	(declaration|	expressionList
		)?
	;

forCond
	:	(expression)?
	;

forIter
	:	(expressionList)?
	;


tryBlock
	:	'try' compoundStatement
		(handler)*
		( finallyClause )?
	;

finallyClause
	:	'finally' compoundStatement
	;


handler
	:	'catch' LPAREN parameterDeclaration RPAREN compoundStatement
	;





































expression
	:	assignmentExpression
	;



expressionList
	:	expression (COMMA expression)*
	;



assignmentExpression
	:	conditionalExpression
		(	(	ASSIGN
			|	PLUS_ASSIGN
			|	MINUS_ASSIGN
			|	STAR_ASSIGN
			|	DIV_ASSIGN
			|	MOD_ASSIGN
			|	SR_ASSIGN
			|	BSR_ASSIGN
			|	SL_ASSIGN
			|	BAND_ASSIGN
			|	BXOR_ASSIGN
			|	BOR_ASSIGN
			)
			assignmentExpression
		)?
	;



conditionalExpression
	:	logicalOrExpression
		( QUESTION assignmentExpression COLON conditionalExpression )?
	;



logicalOrExpression
	:	logicalAndExpression (LOR logicalAndExpression)*
	;



logicalAndExpression
	:	inclusiveOrExpression (LAND inclusiveOrExpression)*
	;



inclusiveOrExpression
	:	exclusiveOrExpression (BOR exclusiveOrExpression)*
	;



exclusiveOrExpression
	:	andExpression (BXOR andExpression)*
	;



andExpression
	:	equalityExpression (BAND equalityExpression)*
	;



equalityExpression
	:	relationalExpression ((NOT_EQUAL | EQUAL) relationalExpression)*
	;



relationalExpression
	:	shiftExpression
		(	(	(	LT
				|	GT
				|	LE
				|	GE
				)
				shiftExpression
			)*
		|	'instanceof' typeSpec
		)
	;



shiftExpression
	:	additiveExpression ((SL | SR | BSR) additiveExpression)*
	;



additiveExpression
	:	multiplicativeExpression ((PLUS | MINUS) multiplicativeExpression)*
	;



multiplicativeExpression
	:	unaryExpression ((STAR | DIV | MOD ) unaryExpression)*
	;

unaryExpression
	:	INC unaryExpression
	|	DEC unaryExpression
	|	MINUS unaryExpression
	|	PLUS unaryExpression
	|	unaryExpressionNotPlusMinus
	;

unaryExpressionNotPlusMinus
	:	BNOT unaryExpression
	|	LNOT unaryExpression
	|	(	
			lpb=LPAREN builtInTypeSpec RPAREN
		unaryExpression

		
		
		
	|	lp=LPAREN classTypeSpec RPAREN
		unaryExpressionNotPlusMinus|	postfixExpression
	)
	;


postfixExpression
	:
		primaryExpression

		(
			
			
			
			DOT (typeArguments)?
				(	IDENT
					(	lp=LPAREN
						argList
						RPAREN
					)?
				|	'super'
					(	
						lp3=LPAREN argList RPAREN
					|	DOT (typeArguments)? IDENT
						(	lps=LPAREN
							argList
							RPAREN
						)?
					)
				)
		|	DOT 'this'
		|	DOT newExpression
		|	lb=LBRACK expression RBRACK
		)*

		(	
			
			in=INC
	 	|	de=DEC
		)?
 	;


primaryExpression
	:	identPrimary ( DOT 'class' )?
	|	constant
	|	'true'
	|	'false'
	|	'null'
	|	newExpression
	|	'this'
	|	'super'
	|	LPAREN assignmentExpression RPAREN
		
	|	builtInType
		( lbt=LBRACK RBRACK )*
		DOT 'class'
	;





identPrimary
	:	(ta1=typeArguments)?
		IDENT
		
		
		(
			DOT (ta2=typeArguments)? IDENT
		|	EPSILON)*
		(
			(	lp=LPAREN
				argList RPAREN
			)
		|	( lbc=LBRACK RBRACK
			)+
		)?
	;


newExpression
	:	'new' (typeArguments)? type
		(	LPAREN argList RPAREN (classBlock)?

			
			
			
			
			
			
			

		|	newArrayDeclarator (arrayInitializer)?
		)
	;

argList
	:	(	expressionList
		|	EPSILON
			)
	;

newArrayDeclarator
	:	(
			
			
			
			
			
			lb=LBRACK
				(expression)?
			RBRACK
		)+
	;

constant
	:	NUM_INT
	|	CHAR_LITERAL
	|	STRING_LITERAL
	|	NUM_FLOAT
	|	NUM_LONG
	|	NUM_DOUBLE
	;
QUESTION		:	'?'		;
LPAREN			:	'('		;
RPAREN			:	')'		;
LBRACK			:	'['		;
RBRACK			:	']'		;
LCURLY			:	'{'		;
RCURLY			:	'}'		;
COLON			:	':'		;
COMMA			:	','		;
DOT				:	'.'		;
ASSIGN			:	'='		;
EQUAL			:	'=='	;
LNOT			:	'!'		;
BNOT			:	'~'		;
NOT_EQUAL		:	'!='	;
DIV				:	'/'		;
DIV_ASSIGN		:	'/='	;
PLUS			:	'+'		;
PLUS_ASSIGN		:	'+='	;
INC				:	'++'	;
MINUS			:	'-'		;
MINUS_ASSIGN	:	'-='	;
DEC				:	'--'	;
STAR			:	'*'		;
STAR_ASSIGN		:	'*='	;
MOD				:	'%'		;
MOD_ASSIGN		:	'%='	;
SR				:	'>>'	;
SR_ASSIGN		:	'>>='	;
BSR				:	'>>>'	;
BSR_ASSIGN		:	'>>>='	;
GE				:	'>='	;
GT				:	'>'		;
SL				:	'<<'	;
SL_ASSIGN		:	'<<='	;
LE				:	'<='	;
LT				:	'<'		;
BXOR			:	'^'		;
BXOR_ASSIGN		:	'^='	;
BOR				:	'|'		;
BOR_ASSIGN		:	'|='	;
LOR				:	'||'	;
BAND			:	'&'		;
BAND_ASSIGN		:	'&='	;
LAND			:	'&&'	;
SEMI			:	';'		;



WS	:	(	' '
		|	'\t'
		|	'\f'
			
		|	(	'\r\n'	
			|	'\r'	
			|	'\n'	
			)
		)+;




CHAR_LITERAL
	:	'\'' ( ESC | BGF_STRING ) '\''
	;


STRING_LITERAL
	:	'"' (ESC|BGF_STRING)* '"'
	;










ESC
	:	'\\'
		(	'n'
		|	'r'
		|	't'
		|	'b'
		|	'f'
		|	'"'
		|	'\''
		|	'\\'
		|	('u')+ HEX_DIGIT HEX_DIGIT HEX_DIGIT HEX_DIGIT
		|	('0'|'1'|'2'|'3')
			(
				('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7')
				(
					('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7')
				)?
			)?
		|	('4'|'5'|'6'|'7')
			(
				('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7')
			)?
		)
	;



HEX_DIGIT
	:	(('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9')|('A'|'B'|'C'|'D'|'E'|'F')|('a'|'b'|'c'|'d'|'e'|'f'))
	;






IDENT
	:	(('a'|'b'|'c'|'d'|'e'|'f'|'g'|'h'|'i'|'j'|'k'|'l'|'m'|'n'|'o'|'p'|'q'|'r'|'s'|'t'|'u'|'v'|'w'|'x'|'y'|'z')|('A'|'B'|'C'|'D'|'E'|'F'|'G'|'H'|'I'|'J'|'K'|'L'|'M'|'N'|'O'|'P'|'Q'|'R'|'S'|'T'|'U'|'V'|'W'|'X'|'Y'|'Z')|'_'|'$')
	(('a'|'b'|'c'|'d'|'e'|'f'|'g'|'h'|'i'|'j'|'k'|'l'|'m'|'n'|'o'|'p'|'q'|'r'|'s'|'t'|'u'|'v'|'w'|'x'|'y'|'z')|('A'|'B'|'C'|'D'|'E'|'F'|'G'|'H'|'I'|'J'|'K'|'L'|'M'|'N'|'O'|'P'|'Q'|'R'|'S'|'T'|'U'|'V'|'W'|'X'|'Y'|'Z')|'_'|('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9')|'$')*;



NUM_INT
	:	'.' 
			(
				((('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9'))+ (EXPONENT)? (f1=FLOAT_SUFFIX )?
				)
				|
				('..')
			)?

	|	(	'0' 
			(	('x'|'X')
				(	
					
					
					
					
					
					HEX_DIGIT
				)+

			|	
				(('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9'))+|	(('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'))+									
			)?
		|	(('1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9')) (('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9'))*)
		(	('l'|'L')

		
		|	
			(	'.' (('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9'))* (EXPONENT)? (f2=FLOAT_SUFFIX)?
			|	EXPONENT (f3=FLOAT_SUFFIX)?
			|	f4=FLOAT_SUFFIX
			)
		)?
	;


AT
	:	'@'
	;


EXPONENT
	:	('e'|'E') ('+'|'-')? (('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9'))+
	;


FLOAT_SUFFIX
	:	'f'|'F'|'d'|'D'
	;