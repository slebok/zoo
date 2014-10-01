/*
 * Sql.g
 * Copyright (C) 2009-2013 TMate Software Ltd
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 2 of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * For information on how to redistribute this software under
 * the terms of a license other than GNU General Public License
 * contact TMate Software at support@sqljet.com
 *
 * @author TMate Software Ltd.
 * @author Dmitry Stadnik (dtrace@seznam.cz)
 */
grammar Sql;

options {
	language = Java;
	output = AST;
	k = 4;
}

tokens {
	ALIAS; // replaces AS
	BIND; // bind parameter, maybe with position
	BIND_NAME; // bind parameter by name
	BLOB_LITERAL;
	COLUMN_CONSTRAINT; // root for column_constraint
	COLUMN_EXPRESSION;
	COLUMNS;
	CONSTRAINTS; // groups all constraints
	CREATE_INDEX;
	CREATE_TABLE;
    CREATE_VIEW;
    CREATE_TRIGGER;
	DROP_INDEX;
	DROP_TABLE;
	FLOAT_LITERAL;
	FUNCTION_LITERAL;
	FUNCTION_EXPRESSION;
	ID_LITERAL;
	IN_VALUES;
	IN_TABLE;
	INTEGER_LITERAL;
	IS_NULL;
    IS_NOT;
	NOT_NULL;
	OPTIONS;
	ORDERING; // root for ordering_term
	SELECT_CORE; // root for simple select statement, part of a compound select
	STRING_LITERAL;
	STATEMENT;
	TABLE_CONSTRAINT; // root for table constraint
	TYPE; // root for type_name
	TYPE_PARAMS; // root for numbers in type_name
}

@header {
  package org.tmatesoft.sqljet.core.internal.lang;
}

@lexer::header {
  package org.tmatesoft.sqljet.core.internal.lang;
}

@members {

// Disable error recovery.
protected Object recoverFromMismatchedToken(IntStream input, int ttype, BitSet follow) throws RecognitionException {
    throw new MismatchedTokenException(ttype, input);
}

// Delegate error reporting to caller.
public void displayRecognitionError(String[] tokenNames, RecognitionException e) {
    final StringBuilder buffer = new StringBuilder();
    buffer.append("[").append(getErrorHeader(e)).append("] ");
    buffer.append(getErrorMessage(e, tokenNames));
    if(e.token!=null) {
      final CharStream stream = e.token.getInputStream();
      if(stream!=null) {
        int size = stream.size();
        if(size>0) {
          buffer.append("\n").append(stream.substring(0, size-1));
        }
      }
    }
    throw new SqlJetParserException(buffer.toString(), e);
}

    // unquotes identifier
public static String unquoteId(String id) {
  if(id==null) {
    return null;
  }
  int len = id.length();
  if(len==0) {
    return "";
  }
  char first = id.charAt(0);
  char last = id.charAt(len-1);
  switch(first) {
    case '[' :
      first = ']';
    case '\'' :
    case '"' :
    case '`' :
      if(first==last) {
        return id.substring(1,len-1);
      }
    default:
      return id;
  }
}


public static String quotedId(final CommonTree ast) {
  if(ast instanceof QuotedId) {
    return ((QuotedId)ast).quotedId();
  }
  return ast.getText();
}

public static class QuotedId extends CommonTree {
    public QuotedId(Token t) { token=t;}
    public QuotedId(QuotedId node) { super(node); }
    public Tree dupNode() { return new QuotedId(this); }
    public String toString() { return token.getText();}
    public String getText() { return unquoteId(super.getText()); }
    public String quotedId() { return super.getText(); }
}

}

@lexer::members {

public void displayRecognitionError(String[] tokenNames, RecognitionException e) {
     final StringBuilder buffer = new StringBuilder();
     buffer.append("[").append(getErrorHeader(e)).append("] ");
     buffer.append(getErrorMessage(e, tokenNames));
     if(e.input!=null && e.input instanceof CharStream) {
        final CharStream stream = (CharStream) e.input;
          int size = stream.size();
          if(size>0) {
             buffer.append("\n").append(stream.substring(0, size-1));
          }
       }
     throw new SqlJetParserException(buffer.toString(), e);
}

}

// Input is a list of statements.
sql_stmt_list: sql_stmt (SEMI! (sql_stmt SEMI!)* )? EOF!;

sql_stmt_itself: sql_stmt (SEMI!)? EOF!;

sql_stmt: (EXPLAIN (QUERY PLAN)?)? sql_stmt_core;

sql_stmt_core
  : pragma_stmt
  | attach_stmt
  | detach_stmt
  | analyze_stmt
  | reindex_stmt
  | vacuum_stmt

  | select_stmt
  | insert_stmt
  | update_stmt
  | delete_stmt
  | begin_stmt
  | commit_stmt
  | rollback_stmt
  | savepoint_stmt
  | release_stmt

  | create_virtual_table_stmt
  | create_table_stmt
  | drop_table_stmt
  | alter_table_stmt
  | create_view_stmt
  | drop_view_stmt
  | create_index_stmt
  | drop_index_stmt
  | create_trigger_stmt
  | drop_trigger_stmt
  ;

schema_create_table_stmt: create_virtual_table_stmt | create_table_stmt;

qualified_table_name: (database_name=id DOT)? table_name=id (INDEXED BY index_name=id | NOT INDEXED)?;

expr: or_subexpr (OR^ or_subexpr)*;

or_subexpr: and_subexpr (AND^ and_subexpr)*;

and_subexpr: eq_subexpr cond_expr^?;

cond_expr
  : NOT? match_op match_expr=eq_subexpr (ESCAPE escape_expr=eq_subexpr)? -> ^(match_op $match_expr NOT? ^(ESCAPE $escape_expr)?)
  | NOT? IN LPAREN expr (COMMA expr)* RPAREN -> ^(IN_VALUES NOT? ^(IN expr+))
  | NOT? IN (database_name=id DOT)? table_name=id -> ^(IN_TABLE NOT? ^(IN ^($table_name $database_name?)))
  | NOT? IN^ LPAREN! select_stmt? RPAREN!
  | NOT? EQUALS^ LPAREN! select_stmt? RPAREN!
  | (ISNULL -> IS_NULL | NOTNULL -> NOT_NULL | IS NULL -> IS_NULL | NOT NULL -> NOT_NULL | IS NOT NULL -> NOT_NULL)
  | IS NOT^ eq_subexpr
  | NOT? BETWEEN e1=eq_subexpr AND e2=eq_subexpr -> ^(BETWEEN NOT? ^(AND $e1 $e2))
  | ((EQUALS | EQUALS2 | NOT_EQUALS | NOT_EQUALS2)^ eq_subexpr)+ /* order of the eq subexpressions is reversed! */
  ;

match_op: LIKE | GLOB | REGEXP | MATCH;

eq_subexpr: neq_subexpr ((LESS | LESS_OR_EQ | GREATER | GREATER_OR_EQ)^ neq_subexpr)*;

neq_subexpr: bit_subexpr ((SHIFT_LEFT | SHIFT_RIGHT | AMPERSAND | PIPE)^ bit_subexpr)*;

bit_subexpr: add_subexpr ((PLUS | MINUS)^ add_subexpr)*;

add_subexpr: mul_subexpr ((ASTERISK | SLASH | PERCENT)^ mul_subexpr)*;

mul_subexpr: con_subexpr (DOUBLE_PIPE^ con_subexpr)*;

con_subexpr: unary_subexpr | unary_op unary_subexpr -> ^(unary_op unary_subexpr);

unary_op: PLUS | MINUS | TILDA | NOT;

unary_subexpr: atom_expr (COLLATE^ collation_name=ID)?;

atom_expr
  : literal_value
  | bind_parameter
  | ((database_name=id DOT)? table_name=id DOT)? column_name=ID -> ^(COLUMN_EXPRESSION ^($column_name ^($table_name $database_name?)?))
  | name=ID LPAREN (DISTINCT? args+=expr (COMMA args+=expr)* | ASTERISK)? RPAREN -> ^(FUNCTION_EXPRESSION $name DISTINCT? $args* ASTERISK?)
  | LPAREN! expr RPAREN!
  | CAST^ LPAREN! expr AS! type_name RPAREN!
  | ((NOT)? EXISTS)? LPAREN select_stmt RPAREN
  | CASE (case_expr=expr)? when_expr+ (ELSE else_expr=expr)? END -> ^(CASE $case_expr? when_expr+ $else_expr?)
  | raise_function
  ;

when_expr: WHEN e1=expr THEN e2=expr -> ^(WHEN $e1 $e2);

literal_value
  : INTEGER -> ^(INTEGER_LITERAL INTEGER)
  | FLOAT -> ^(FLOAT_LITERAL FLOAT)
  | STRING -> ^(STRING_LITERAL STRING)
  | BLOB -> ^(BLOB_LITERAL BLOB)
  | NULL
  | CURRENT_TIME -> ^(FUNCTION_LITERAL CURRENT_TIME)
  | CURRENT_DATE -> ^(FUNCTION_LITERAL CURRENT_DATE)
  | CURRENT_TIMESTAMP -> ^(FUNCTION_LITERAL CURRENT_TIMESTAMP)
  | bool
  ;

bind_parameter
  : QUESTION -> BIND
  | QUESTION position=INTEGER -> ^(BIND $position)
  | COLON name=id -> ^(BIND_NAME $name)
  | AT name=id -> ^(BIND_NAME $name)
// tcl bindings are not supported for now
//  | DOLLAR name=TCL_ID
  ;

raise_function: RAISE^ LPAREN! (IGNORE | (ROLLBACK | ABORT | FAIL) COMMA! error_message=STRING) RPAREN!;

type_name: names+=ID+ (LPAREN size1=signed_number (COMMA size2=signed_number)? RPAREN)?
-> ^(TYPE ^(TYPE_PARAMS $size1? $size2?) $names+);

signed_number: (PLUS | MINUS)? (INTEGER | FLOAT);

// PRAGMA
pragma_stmt: PRAGMA (database_name=id DOT)? pragma_name=id (EQUALS pragma_value | LPAREN pragma_value RPAREN)?
-> ^(PRAGMA ^($pragma_name $database_name?) pragma_value?);

pragma_value
	: signed_number -> ^(FLOAT_LITERAL signed_number)
	| ID -> ^(ID_LITERAL ID)
	| STRING -> ^(STRING_LITERAL STRING)
	| bool
	;

// ATTACH
attach_stmt: ATTACH (DATABASE)? filename=id AS database_name=id;

// DETACH
detach_stmt: DETACH (DATABASE)? database_name=id;

// ANALYZE
analyze_stmt: ANALYZE (database_or_table_name=id | database_name=id DOT table_name=id)?;

// REINDEX
reindex_stmt: REINDEX (database_name=id DOT)? collation_or_table_or_index_name=id;

// VACUUM
vacuum_stmt: VACUUM;

//
// DML
//

operation_conflict_clause: OR (ROLLBACK | ABORT | FAIL | IGNORE | REPLACE);

ordering_term: expr /* {ambiguous; part of expr} (COLLATE collation_name=ID)? */ (ASC | DESC)?
-> ^(ORDERING expr (ASC)? (DESC)?);

operation_limited_clause:
  (ORDER BY ordering_term (COMMA ordering_term)*)?
  LIMIT limit=INTEGER ((OFFSET | COMMA) offset=INTEGER)?;

// SELECT
select_stmt: select_list
  (ORDER BY ordering_term (COMMA ordering_term)*)?
  (LIMIT limit=INTEGER ((OFFSET | COMMA) offset=INTEGER)?)?
-> ^(
  SELECT select_list ^(ORDER ordering_term+)? ^(LIMIT $limit $offset?)?
);

select_list:
  select_core (select_op^ select_core)*;

select_op: UNION^ (ALL)? | INTERSECT | EXCEPT;

select_core:
  SELECT (ALL | DISTINCT)? result_column (COMMA result_column)* (FROM join_source)? (WHERE where_expr=expr)?
  ( GROUP BY ordering_term (COMMA ordering_term)* (HAVING having_expr=expr)? )?
-> ^(
  SELECT_CORE (DISTINCT)? ^(COLUMNS result_column+) ^(FROM join_source)? ^(WHERE $where_expr)?
  ^(GROUP ordering_term+ ^(HAVING $having_expr)?)?
);

result_column
  : ASTERISK
  | table_name=id DOT ASTERISK -> ^(ASTERISK $table_name)
  | expr ((AS)? column_alias=id)? -> ^(ALIAS expr $column_alias?);

join_source: single_source (join_op^ single_source (join_constraint)?)*;

single_source
  : (database_name=id DOT)? table_name=ID ((AS)? table_alias=ID)? (INDEXED BY index_name=id | NOT INDEXED)?
  -> ^(ALIAS ^($table_name $database_name?) $table_alias? ^(INDEXED NOT? $index_name?)?)
  | LPAREN select_stmt RPAREN ((AS)? table_alias=ID)?
  -> ^(ALIAS select_stmt $table_alias?)
  | LPAREN! join_source RPAREN!;

join_op
  : COMMA
  | (NATURAL)? ((LEFT)? (OUTER)? | INNER | CROSS) JOIN^;

join_constraint
  : ON^ expr
  | USING LPAREN column_names+=id (COMMA column_names+=id)* RPAREN -> ^(USING $column_names+);

// INSERT
insert_stmt: (INSERT (operation_conflict_clause)? | REPLACE) INTO (database_name=id DOT)? table_name=id
  ( (LPAREN column_names+=id (COMMA column_names+=id)* RPAREN)?
    (VALUES LPAREN values+=expr (COMMA values+=expr)* RPAREN | select_stmt)
  | DEFAULT VALUES );

// UPDATE
update_stmt: UPDATE (operation_conflict_clause)? qualified_table_name
  SET values+=update_set (COMMA values+=update_set)* (WHERE expr)? (operation_limited_clause)?;

update_set: column_name=id EQUALS expr;

// DELETE
delete_stmt: DELETE FROM qualified_table_name (WHERE expr)? (operation_limited_clause)?;

// BEGIN TRANSACTION
begin_stmt: BEGIN (DEFERRED | IMMEDIATE | EXCLUSIVE)? (TRANSACTION)?;

// COMMIT TRANSACTION
commit_stmt: (COMMIT | END) (TRANSACTION)?;

// ROLLBACK TRANSACTION
rollback_stmt: ROLLBACK (TRANSACTION)? (TO (SAVEPOINT)? savepoint_name=id)?;

// SAVEPOINT
savepoint_stmt: SAVEPOINT savepoint_name=id;

// RELEASE
release_stmt: RELEASE (SAVEPOINT)? savepoint_name=id;


//
// DDL
//

table_conflict_clause: ON! CONFLICT^ (ROLLBACK | ABORT | FAIL | IGNORE | REPLACE);

// CREATE VIRTUAL TABLE
// TODO: replace column defs by arbitrary text with balanced parens
create_virtual_table_stmt: CREATE VIRTUAL TABLE (database_name=id DOT)? table_name=id
  USING module_name=id (LPAREN column_def (COMMA column_def)* RPAREN)?
  -> ^(CREATE_TABLE ^(OPTIONS VIRTUAL) ^($table_name $database_name?) ^($module_name) ^(COLUMNS column_def+)?);

// CREATE TABLE
create_table_stmt: CREATE TEMPORARY? TABLE (IF NOT EXISTS)? (database_name=id DOT)? table_name=id
  ( LPAREN column_def (COMMA column_def)* (COMMA? table_constraint)* RPAREN
  | AS select_stmt)
-> ^(CREATE_TABLE ^(OPTIONS TEMPORARY? EXISTS?) ^($table_name $database_name?)
  ^(COLUMNS column_def+)? ^(CONSTRAINTS table_constraint*)? select_stmt?);

column_def: name=id_column_def type_name? column_constraint*
-> ^($name ^(CONSTRAINTS column_constraint*) type_name?);

column_constraint: (CONSTRAINT name=id)?
  ( column_constraint_pk
  | column_constraint_not_null
  | column_constraint_null
  | column_constraint_unique
  | column_constraint_check
  | column_constraint_default
  | column_constraint_collate
  | fk_clause)
-> ^(COLUMN_CONSTRAINT
  column_constraint_pk?
  column_constraint_not_null?
  column_constraint_null?
  column_constraint_unique?
  column_constraint_check?
  column_constraint_default?
  column_constraint_collate?
  fk_clause?
  $name?);

column_constraint_pk: PRIMARY^ KEY! (ASC | DESC)? table_conflict_clause? (AUTOINCREMENT)?;

column_constraint_not_null: NOT NULL table_conflict_clause? -> ^(NOT_NULL table_conflict_clause?);

column_constraint_null: NULL table_conflict_clause? -> ^(IS_NULL table_conflict_clause?);

column_constraint_unique: UNIQUE^ table_conflict_clause?;

column_constraint_check: CHECK^ LPAREN! expr RPAREN!;

numeric_literal_value
  : INTEGER -> ^(INTEGER_LITERAL INTEGER)
  | FLOAT -> ^(FLOAT_LITERAL FLOAT)
  ;

signed_default_number: (PLUS | MINUS)^ numeric_literal_value;

// Expand signed_number to avoid collisions with literal_value
column_constraint_default: DEFAULT^ (signed_default_number | literal_value | LPAREN! expr RPAREN! );

column_constraint_collate: COLLATE^ collation_name=id; // collation_name: (BINARY|NOCASE|RTRIM)

table_constraint: (CONSTRAINT name=id)?
  ( table_constraint_pk
  | table_constraint_unique
  | table_constraint_check
  | table_constraint_fk)
-> ^(TABLE_CONSTRAINT
  table_constraint_pk?
  table_constraint_unique?
  table_constraint_check?
  table_constraint_fk?
  $name?);

table_constraint_pk: PRIMARY KEY
  LPAREN indexed_columns+=id (COMMA indexed_columns+=id)* RPAREN table_conflict_clause?
-> ^(PRIMARY ^(COLUMNS $indexed_columns+) table_conflict_clause?);

table_constraint_unique: UNIQUE
  LPAREN indexed_columns+=id (COMMA indexed_columns+=id)* RPAREN table_conflict_clause?
-> ^(UNIQUE ^(COLUMNS $indexed_columns+) table_conflict_clause?);

table_constraint_check: CHECK^ LPAREN! expr RPAREN!;

table_constraint_fk: FOREIGN KEY LPAREN column_names+=id (COMMA column_names+=id)* RPAREN fk_clause
-> ^(FOREIGN ^(COLUMNS $column_names+) fk_clause);

fk_clause: REFERENCES foreign_table=id (LPAREN column_names+=id (COMMA column_names+=id)* RPAREN)?
  fk_clause_action* fk_clause_deferrable?
-> ^(REFERENCES $foreign_table ^(COLUMNS $column_names+) fk_clause_action* fk_clause_deferrable?);

fk_clause_action
  : ON^ (DELETE | UPDATE | INSERT) (SET! NULL | SET! DEFAULT | CASCADE | RESTRICT)
  | MATCH^ id;

fk_clause_deferrable: (NOT)? DEFERRABLE^ (INITIALLY! DEFERRED | INITIALLY! IMMEDIATE)?;

// DROP TABLE
drop_table_stmt: DROP TABLE (IF EXISTS)? (database_name=id DOT)? table_name=id
-> ^(DROP_TABLE ^(OPTIONS EXISTS?) ^($table_name $database_name?));

// ALTER TABLE
alter_table_stmt: ALTER TABLE (database_name=id DOT)? table_name=id (RENAME TO new_table_name=id | ADD (COLUMN)? column_def);

// CREATE VIEW
create_view_stmt: CREATE TEMPORARY? VIEW (IF NOT EXISTS)? (database_name=id DOT)? view_name=id AS t=select_stmt
-> ^(CREATE_VIEW ^(OPTIONS TEMPORARY? EXISTS?) ^($view_name $database_name?) ^(STATEMENT $t));


// DROP VIEW
drop_view_stmt: DROP VIEW (IF EXISTS)? (database_name=id DOT)? view_name=id;

// CREATE INDEX
create_index_stmt: CREATE (UNIQUE)? INDEX (IF NOT EXISTS)? (database_name=id DOT)? index_name=id
  ON table_name=id LPAREN columns+=indexed_column (COMMA columns+=indexed_column)* RPAREN
-> ^(CREATE_INDEX ^(OPTIONS UNIQUE? EXISTS?) ^($index_name $database_name?) $table_name ^(COLUMNS $columns+)?);

indexed_column: column_name=id (COLLATE collation_name=id)? (ASC | DESC)?
-> ^($column_name ^(COLLATE $collation_name)? ASC? DESC?);

// DROP INDEX
drop_index_stmt: DROP INDEX (IF EXISTS)? (database_name=id DOT)? index_name=id
-> ^(DROP_INDEX ^(OPTIONS EXISTS?) ^($index_name $database_name?));

// CREATE TRIGGER
create_trigger_stmt: CREATE TEMPORARY? TRIGGER (IF NOT EXISTS)? (database_name=id DOT)? trigger_name=id
  (BEFORE | AFTER | INSTEAD OF)? (DELETE | INSERT | UPDATE (OF column_names+=id (COMMA column_names+=id)*)?)
  ON table_name=id (FOR EACH ROW)? (WHEN expr)?
  BEGIN ((update_stmt | insert_stmt | delete_stmt | select_stmt) SEMI)+ END
-> ^(CREATE_TRIGGER ^(OPTIONS TEMPORARY?) ^($trigger_name $table_name $database_name?));

// DROP TRIGGER
drop_trigger_stmt: DROP TRIGGER (IF EXISTS)? (database_name=id DOT)? trigger_name=id;

// identifiers core
id_core: str=( ID<QuotedId> | STRING<QuotedId> );

// Special rules that allow to use certain keywords as identifiers.

id: id_core | keyword;

keyword: (
    ABORT
  | ADD
  | AFTER
  | ALL
  | ALTER
  | ANALYZE
  | AND
  | AS
  | ASC
  | ATTACH
  | AUTOINCREMENT
  | BEFORE
  | BEGIN
  | BETWEEN
  | BY
  | CASCADE
  | CASE
  | CAST
  | CHECK
  | COLLATE
  | COLUMN
  | COMMIT
  | CONFLICT
  | CONSTRAINT
  | CREATE
  | CROSS
  | CURRENT_TIME
  | CURRENT_DATE
  | CURRENT_TIMESTAMP
  | DATABASE
  | DEFAULT
  | DEFERRABLE
  | DEFERRED
  | DELETE
  | DESC
  | DETACH
  | DISTINCT
  | DROP
  | EACH
  | ELSE
  | END
  | ESCAPE
  | EXCEPT
  | EXCLUSIVE
  | EXISTS
  | EXPLAIN
  | FAIL
  | FOR
  | FOREIGN
  | FROM
//  | GLOB
  | GROUP
  | HAVING
  | IF
  | IGNORE
  | IMMEDIATE
//  | IN
  | INDEX
  | INDEXED
  | INITIALLY
  | INNER
  | INSERT
  | INSTEAD
  | INTERSECT
  | INTO
  | IS
//  | ISNULL
  | JOIN
  | KEY
  | LEFT
//  | LIKE
  | LIMIT
//  | MATCH
  | NATURAL
//  | NOT
//  | NOTNULL
  | NULL
  | OF
  | OFFSET
  | ON
  | OR
  | ORDER
  | OUTER
  | PLAN
  | PRAGMA
  | PRIMARY
  | QUERY
  | RAISE
  | REFERENCES
//  | REGEXP
  | REINDEX
  | RELEASE
  | RENAME
  | REPLACE
  | RESTRICT
  | ROLLBACK
  | ROW
  | SAVEPOINT
  | SELECT
  | SET
  | TABLE
  | TEMPORARY
  | THEN
  | TO
  | TRANSACTION
  | TRIGGER
  | UNION
  | UNIQUE
  | UPDATE
  | USING
  | VACUUM
  | VALUES
  | VIEW
  | VIRTUAL
  | WHEN
  | WHERE
  );

id_column_def: id_core | keyword_column_def;

keyword_column_def: (
    ABORT
  | ADD
  | AFTER
  | ALL
  | ALTER
  | ANALYZE
  | AND
  | AS
  | ASC
  | ATTACH
  | AUTOINCREMENT
  | BEFORE
  | BEGIN
  | BETWEEN
  | BY
  | CASCADE
  | CASE
  | CAST
  | CHECK
  | COLLATE
//  | COLUMN
  | COMMIT
  | CONFLICT
//  | CONSTRAINT
  | CREATE
  | CROSS
  | CURRENT_TIME
  | CURRENT_DATE
  | CURRENT_TIMESTAMP
  | DATABASE
  | DEFAULT
  | DEFERRABLE
  | DEFERRED
  | DELETE
  | DESC
  | DETACH
  | DISTINCT
  | DROP
  | EACH
  | ELSE
  | END
  | ESCAPE
  | EXCEPT
  | EXCLUSIVE
  | EXISTS
  | EXPLAIN
  | FAIL
  | FOR
  | FOREIGN
  | FROM
  | GLOB
  | GROUP
  | HAVING
  | IF
  | IGNORE
  | IMMEDIATE
  | IN
  | INDEX
  | INDEXED
  | INITIALLY
  | INNER
  | INSERT
  | INSTEAD
  | INTERSECT
  | INTO
  | IS
  | ISNULL
  | JOIN
  | KEY
  | LEFT
  | LIKE
  | LIMIT
  | MATCH
  | NATURAL
  | NOT
  | NOTNULL
  | NULL
  | OF
  | OFFSET
  | ON
  | OR
  | ORDER
  | OUTER
  | PLAN
  | PRAGMA
  | PRIMARY
  | QUERY
  | RAISE
  | REFERENCES
  | REGEXP
  | REINDEX
  | RELEASE
  | RENAME
  | REPLACE
  | RESTRICT
  | ROLLBACK
  | ROW
  | SAVEPOINT
  | SELECT
  | SET
  | TABLE
  | TEMPORARY
  | THEN
  | TO
  | TRANSACTION
  | TRIGGER
  | UNION
  | UNIQUE
  | UPDATE
  | USING
  | VACUUM
  | VALUES
  | VIEW
  | VIRTUAL
  | WHEN
  | WHERE
  );

//
// Lexer
//

EQUALS:        '=';
EQUALS2:       '==';
NOT_EQUALS:    '!=';
NOT_EQUALS2:   '<>';
LESS:          '<';
LESS_OR_EQ:    '<=';
GREATER:       '>';
GREATER_OR_EQ: '>=';
SHIFT_LEFT:    '<<';
SHIFT_RIGHT:   '>>';
AMPERSAND:     '&';
PIPE:          '|';
DOUBLE_PIPE:   '||';
PLUS:          '+';
MINUS:         '-';
TILDA:         '~';
ASTERISK:      '*';
SLASH:         '/';
BACKSLASH:     '\\';
PERCENT:       '%';
SEMI:          ';';
DOT:           '.';
COMMA:         ',';
LPAREN:        '(';
RPAREN:        ')';
QUESTION:      '?';
COLON:         ':';
AT:            '@';
DOLLAR:        '$';
QUOTE_DOUBLE:  '"';
QUOTE_SINGLE:  '\'';
APOSTROPHE:    '`';
LPAREN_SQUARE: '[';
RPAREN_SQUARE: ']';
UNDERSCORE:    '_';

// http://www.antlr.org/wiki/pages/viewpage.action?pageId=1782
fragment A:('a'|'A');
fragment B:('b'|'B');
fragment C:('c'|'C');
fragment D:('d'|'D');
fragment E:('e'|'E');
fragment F:('f'|'F');
fragment G:('g'|'G');
fragment H:('h'|'H');
fragment I:('i'|'I');
fragment J:('j'|'J');
fragment K:('k'|'K');
fragment L:('l'|'L');
fragment M:('m'|'M');
fragment N:('n'|'N');
fragment O:('o'|'O');
fragment P:('p'|'P');
fragment Q:('q'|'Q');
fragment R:('r'|'R');
fragment S:('s'|'S');
fragment T:('t'|'T');
fragment U:('u'|'U');
fragment V:('v'|'V');
fragment W:('w'|'W');
fragment X:('x'|'X');
fragment Y:('y'|'Y');
fragment Z:('z'|'Z');

ABORT: A B O R T;
ADD: A D D;
AFTER: A F T E R;
ALL: A L L;
ALTER: A L T E R;
ANALYZE: A N A L Y Z E;
AND: A N D;
AS: A S;
ASC: A S C;
ATTACH: A T T A C H;
AUTOINCREMENT: A U T O I N C R E M E N T;
BEFORE: B E F O R E;
BEGIN: B E G I N;
BETWEEN: B E T W E E N;
BY: B Y;
CASCADE: C A S C A D E;
CASE: C A S E;
CAST: C A S T;
CHECK: C H E C K;
COLLATE: C O L L A T E;
COLUMN: C O L U M N;
COMMIT: C O M M I T;
CONFLICT: C O N F L I C T;
CONSTRAINT: C O N S T R A I N T;
CREATE: C R E A T E;
CROSS: C R O S S;
CURRENT_TIME: C U R R E N T '_' T I M E;
CURRENT_DATE: C U R R E N T '_' D A T E;
CURRENT_TIMESTAMP: C U R R E N T '_' T I M E S T A M P;
DATABASE: D A T A B A S E;
DEFAULT: D E F A U L T;
DEFERRABLE: D E F E R R A B L E;
DEFERRED: D E F E R R E D;
DELETE: D E L E T E;
DESC: D E S C;
DETACH: D E T A C H;
DISTINCT: D I S T I N C T;
DROP: D R O P;
EACH: E A C H;
ELSE: E L S E;
END: E N D;
ESCAPE: E S C A P E;
EXCEPT: E X C E P T;
EXCLUSIVE: E X C L U S I V E;
EXISTS: E X I S T S;
EXPLAIN: E X P L A I N;
FAIL: F A I L;
FOR: F O R;
FOREIGN: F O R E I G N;
FROM: F R O M;
GLOB: G L O B;
GROUP: G R O U P;
HAVING: H A V I N G;
IF: I F;
IGNORE: I G N O R E;
IMMEDIATE: I M M E D I A T E;
IN: I N;
INDEX: I N D E X;
INDEXED: I N D E X E D;
INITIALLY: I N I T I A L L Y;
INNER: I N N E R;
INSERT: I N S E R T;
INSTEAD: I N S T E A D;
INTERSECT: I N T E R S E C T;
INTO: I N T O;
IS: I S;
ISNULL: I S N U L L;
JOIN: J O I N;
KEY: K E Y;
LEFT: L E F T;
LIKE: L I K E;
LIMIT: L I M I T;
MATCH: M A T C H;
NATURAL: N A T U R A L;
NOT: N O T;
NOTNULL: N O T N U L L;
NULL: N U L L;
OF: O F;
OFFSET: O F F S E T;
ON: O N;
OR: O R;
ORDER: O R D E R;
OUTER: O U T E R;
PLAN: P L A N;
PRAGMA: P R A G M A;
PRIMARY: P R I M A R Y;
QUERY: Q U E R Y;
RAISE: R A I S E;
REFERENCES: R E F E R E N C E S;
REGEXP: R E G E X P;
REINDEX: R E I N D E X;
RELEASE: R E L E A S E;
RENAME: R E N A M E;
REPLACE: R E P L A C E;
RESTRICT: R E S T R I C T;
ROLLBACK: R O L L B A C K;
ROW: R O W;
SAVEPOINT: S A V E P O I N T;
SELECT: S E L E C T;
SET: S E T;
TABLE: T A B L E;
TEMPORARY: T E M P ( O R A R Y )?;
THEN: T H E N;
TO: T O;
TRANSACTION: T R A N S A C T I O N;
TRIGGER: T R I G G E R;
UNION: U N I O N;
UNIQUE: U N I Q U E;
UPDATE: U P D A T E;
USING: U S I N G;
VACUUM: V A C U U M;
VALUES: V A L U E S;
VIEW: V I E W;
VIRTUAL: V I R T U A L;
WHEN: W H E N;
WHERE: W H E R E;
TRUE: T R U E;
FALSE: F A L S E;

bool: (TRUE|FALSE);

fragment STRING_ESCAPE_SINGLE: (BACKSLASH QUOTE_SINGLE);
fragment STRING_ESCAPE_DOUBLE: (BACKSLASH QUOTE_DOUBLE);
fragment STRING_CORE: ~(QUOTE_SINGLE | QUOTE_DOUBLE);
fragment STRING_CORE_SINGLE: ( STRING_CORE | QUOTE_DOUBLE | STRING_ESCAPE_SINGLE )*;
fragment STRING_CORE_DOUBLE: ( STRING_CORE | QUOTE_SINGLE | STRING_ESCAPE_DOUBLE )*;
fragment STRING_SINGLE: (QUOTE_SINGLE STRING_CORE_SINGLE QUOTE_SINGLE);
fragment STRING_DOUBLE: (QUOTE_DOUBLE STRING_CORE_DOUBLE QUOTE_DOUBLE);
STRING: (STRING_SINGLE | STRING_DOUBLE);

fragment ID_START: ('a'..'z'|'A'..'Z'|UNDERSCORE);
fragment ID_CORE: (ID_START|'0'..'9'|DOLLAR);
fragment ID_PLAIN: ID_START (ID_CORE)*;

fragment ID_QUOTED_CORE: ~(APOSTROPHE | LPAREN_SQUARE | RPAREN_SQUARE);
fragment ID_QUOTED_CORE_SQUARE: (ID_QUOTED_CORE | APOSTROPHE)*;
fragment ID_QUOTED_CORE_APOSTROPHE: (ID_QUOTED_CORE | LPAREN_SQUARE | RPAREN_SQUARE)*;
fragment ID_QUOTED_SQUARE: (LPAREN_SQUARE ID_QUOTED_CORE_SQUARE RPAREN_SQUARE);
fragment ID_QUOTED_APOSTROPHE: (APOSTROPHE ID_QUOTED_CORE_APOSTROPHE APOSTROPHE);
fragment ID_QUOTED: ID_QUOTED_SQUARE | ID_QUOTED_APOSTROPHE;

ID: ID_PLAIN | ID_QUOTED;

//TCL_ID: ID_START (ID_START|'0'..'9'|'::')* (LPAREN ( options {greedy=false;} : . )* RPAREN)?;

INTEGER: ('0'..'9')+;
fragment FLOAT_EXP : ('e'|'E') ('+'|'-')? ('0'..'9')+ ;
FLOAT
    :   ('0'..'9')+ DOT ('0'..'9')* FLOAT_EXP?
    |   DOT ('0'..'9')+ FLOAT_EXP?
    |   ('0'..'9')+ FLOAT_EXP
    ;
BLOB: ('x'|'X') QUOTE_SINGLE ('0'..'9'|'a'..'f'|'A'..'F')+ QUOTE_SINGLE;

fragment COMMENT: '/*' ( options {greedy=false;} : . )* '*/';
fragment LINE_COMMENT: '--' ~('\n'|'\r')* ('\r'? '\n'|EOF);
WS: (' '|'\r'|'\t'|'\u000C'|'\n'|COMMENT|LINE_COMMENT) {$channel=HIDDEN;};
