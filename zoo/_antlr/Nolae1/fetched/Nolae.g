grammar Nolae;
options {language=Cpp;}
//Tokens
NUMERO	:	('+'|'-') ? ('0'..'9')+ ('.' '0'..'9') ?;
IDENTIFICADOR
	:	(('a'..'z')|('A'..'Z')) (('a'..'z')|('A'..'Z')|'0'..'9')*;
TEXTO	:	'\"' ('a'..'z'|'A'..'Z'|'0'..'9'|' ')* '\"';
CARACTER:	'\'' ('a'..'z'|'A'..'Z'|'0'..'9'|' ') '\'';
FINLINEA:	'\r' ? '\n' {skip();};
//Producciones
programa:	funcion* 'inicio'   instruccion* 'fin';
funcion
	:	(tipo|'proceso') IDENTIFICADOR '(' listaparametros? ')'   bloque;
listaparametros: parametro (',' parametro)*;
parametro
	:	tipo IDENTIFICADOR ('=' (NUMERO|CARACTER|TEXTO))?;
instruccion
	:	iImprimir|iPedir|iAsignar|iCrearVariable|iSi|iMientras|iPara|iHaga|iSeleccion|iSalir|iContinuar|iRetornar;
iImprimir
	:	'imprimir' (TEXTO|CARACTER|NUMERO|IDENTIFICADOR) ';' ;
iPedir	:	'pedir' IDENTIFICADOR ';';
iCrearVariable
	:	'variable' tipo IDENTIFICADOR ('=' (TEXTO|NUMERO|CARACTER))? ';';
tipo	:	('real'|'caracter'|'booleana'|'entera');
iAsignar:	IDENTIFICADOR '=' expresion ';';
expresion
	:	suma (('+'|'-') suma)*;
suma	:	producto (('*'|'/') producto)*;
producto:	proposicion (('&&'|'||') proposicion)*;
proposicion
	:	'!'? comparacion;
comparacion:	factor (('>'|'>='|'<'|'<='|'=='|'!=') factor)? ;
factor	:	(CARACTER|NUMERO|IDENTIFICADOR);
iSi	:	'si' '(' expresion ')' 'entonces' bloque sino;
sino	:	('sino' bloque)?;
bloque	:	(instruccion| ('{' (instruccion)* '}'));
iMientras
	:	'mientras' '(' expresion ')'   bloque;
iHaga	:	'haga'   bloque   'mientras' '(' expresion ')' ';';
iPara	:	'para' '(' (iCrearVariable|iAsignar) expresion ';' (IDENTIFICADOR '=' expresion) ')'   bloque;
iSeleccion
	:	'seleccion' '(' IDENTIFICADOR ')'   bloqueCasos ;
bloqueCasos
	:	'{' (caso)* '}';
caso	:	(('caso' (NUMERO|CARACTER)) | 'sino')   bloque;
iSalir	:	'salir' ';';
iContinuar
	:	'continuar' ';';
iRetornar
	:	'retornar' expresion? ';' ;
