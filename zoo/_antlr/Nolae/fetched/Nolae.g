grammar Nolae;
options {language=C;}
//Tokens
NUMERO	:	('+'|'-') ? ('0'..'9')+ ('.' '0'..'9') ?;
IDENTIFICADOR
	:	(('a'..'z')|('A'..'Z')) (('a'..'z')|('A'..'Z')|'0'..'9')*;
TEXTO	:	'\"' ('a'..'z'|'A'..'Z'|'0'..'9'|' ')* '\"';
CARACTER:	'\'' ('a'..'z'|'A'..'Z'|'0'..'9'|' ') '\'';
FINLINEA:	'\r' ? '\n' {skip();};
//Producciones
programa:	(clase|funcion)* 'inicio'   instruccion* 'fin';
clase	:	'clase' IDENTIFICADOR ('herencia' listaherencia)? bloqueClase;
listaherencia:	tipoacceso IDENTIFICADOR (',' tipoacceso IDENTIFICADOR)*;
tipoacceso
	:	'publico'|'privado'|'protegido'|'virtual';
	
bloqueClase
	:	'{' (bloqueMetodo|bloqueAtributo)+ '}';  //Hacerle un comentario a Terrence Parr
bloqueAtributo
	:	'atributos:' iCrearAtributo*;
bloqueMetodo
	:	'metodos:' iCrearMetodo* ;
iCrearAtributo
	:	tipoacceso? (IDENTIFICADOR|tipo) IDENTIFICADOR ';' ;
iCrearMetodo
	:	tipoacceso? (tipo|IDENTIFICADOR|'proceso'|'constructor') IDENTIFICADOR '(' listaparametros? ')' bloque;
	
funcion	:	(tipo|'proceso') IDENTIFICADOR '(' listaparametros? ')'   bloque;
listaparametros: parametro (',' parametro)*;
parametro
	:	tipo IDENTIFICADOR ('=' (NUMERO|CARACTER|TEXTO))?;
instruccion
	:	
iImprimir|iPedir|iAsignar|iCrearObjeto|iCrearVariable|iSi|iMientras|iPara|iHaga|iSeleccion|iSalir|iContinuar|iRetornar|(iLlamarMetodo ';');
iImprimir
	:	'imprimir' (TEXTO|CARACTER|NUMERO|IDENTIFICADOR) ';' ;
iPedir	:	'pedir' IDENTIFICADOR ';';
iCrearVariable
	:	'variable' tipo IDENTIFICADOR ('=' (TEXTO|NUMERO|CARACTER))? ';';
iCrearObjeto
	:	'objeto' IDENTIFICADOR IDENTIFICADOR ('=' IDENTIFICADOR)? ';' ;
tipo	:	('real'|'caracter'|'booleano'|'entero'|'cadena');
iAsignar:	IDENTIFICADOR '=' expresion ';';
expresion
	:	suma (('+'|'-') suma)*;
suma	:	producto (('*'|'/') producto)*;
producto:	proposicion (('&&'|'||') proposicion)*;
proposicion
	:	'!'? comparacion;
comparacion:	factor (('>'|'>='|'<'|'<='|'=='|'!=') factor)? ;
factor	:	(CARACTER|NUMERO|IDENTIFICADOR|iLlamarMetodo);
iSi	:	'si' '(' expresion ')' 'entonces' bloque ('sino' bloque)? ;
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
iLlamarMetodo
	:	(IDENTIFICADOR '.' )? IDENTIFICADOR '(' listavalores? ')' ;
listavalores
	:	factor (',' factor) ;
