/*
 * Copyright 2010 Spolecne s.r.o. (www.spoledge.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
parser grammar GqlExtParser;

options {
    output = AST;
    tokenVocab = GqlExtLexer;
}

tokens {
    COLAS;
    DIV;
    FUNC;
    LIST;
    MUL;
    PATH;
    UMINUS;
}

scope Expr {
    boolean hasEntity;
    boolean isNestedQueryAllowed;
}

scope Query {
    boolean hasNestedQuery;
}


@header {
/*
 * Copyright 2010 Spolecne s.r.o. (www.spoledge.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.spoledge.audao.parser.gql.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

}

@members {
    public enum QueryType {
        SELECT, INSERT, UPDATE, DELETE
    }

    /**
     * The logger.
     */
    private Log log = LogFactory.getLog( getClass());

    private List<String> errors;
    private QueryType queryType;


    ////////////////////////////////////////////////////////////////////////////
    // Manually created methods
    ////////////////////////////////////////////////////////////////////////////

    @Override
    public void displayRecognitionError(String[] tokenNames, RecognitionException e) {
        String hdr = getErrorHeader(e);
        String msg = getErrorMessage(e, tokenNames);

        if (errors == null) errors = new ArrayList<String>();
        errors.add( hdr + " " + msg );
    }


    public List<String> getErrors() {
        return errors;
    }


    public QueryType getQueryType() {
        return queryType;
    }


    ////////////////////////////////////////////////////////////////////////////
    // Dynamically generated methods
    ////////////////////////////////////////////////////////////////////////////
}


gqlext
    @init{
        errors = null;
        queryType = null;
    }
    : gql_select | gql_insert | gql_update | gql_delete;


gql_select
    scope Query;
    :
    SELECT get_properties FROM kindorquery where? orderby? limit? offset?  {
        queryType = QueryType.SELECT;
    }
    -> ^(SELECT kindorquery get_properties where? orderby? limit? offset?);


gql_insert
    scope {
        int columnCount;
        int valueCount;
    }
    :
    INSERT INTO kind columns values {
        queryType = QueryType.INSERT;

        if ($gql_insert::columnCount != $gql_insert::valueCount)
            throw new RuntimeException("Number of columns and values does not match");
    }
    -> ^(INSERT kind columns values);


gql_update:
    UPDATE kind set_properties where? orderby? limit? offset? {
        queryType = QueryType.UPDATE;
    }
    -> ^(UPDATE kind set_properties where? orderby? limit? offset?);


gql_delete:
    DELETE FROM? kind where? orderby? limit? offset? {
        queryType = QueryType.DELETE;
    }
    -> ^(DELETE kind where? orderby? limit? offset?);


kindorquery:
    kind -> kind
    | DUAL -> DUAL
    | LEFT_PAR gql_select RIGHT_PAR {
        $Query::hasNestedQuery = true;
    } -> gql_select;


get_properties
    scope Expr;
    @init {
        $Expr::hasEntity = true;
    }
    :
    get_property (COMMA get_property)*
    -> ^(PROP get_property+);


get_property: ASTERISK | prop | get_property_expr;

get_property_expr:
    expr AS? alias -> ^(COLAS alias expr);


alias: KEYPROP | aliasnokey;

aliasnokey:
    STRING 
    | property
    | (UNINDEXED LEFT_PAR STRING RIGHT_PAR -> ^(UNINDEXED STRING))
    | (EMPTY LEFT_PAR STRING RIGHT_PAR -> ^(EMPTY STRING));


columns:
    LEFT_PAR column (COMMA column)* RIGHT_PAR
    -> ^(COLAS column+);


column:
    alias {
        $gql_insert::columnCount++;
    };


values
    scope Expr;
    @init {
        $Expr::hasEntity = false;
    }
    :
    VALUES LEFT_PAR value (COMMA value)* RIGHT_PAR
    -> ^(VALUES value+);


value:
    expr {
        $gql_insert::valueCount++;
    };


set_properties
    scope Expr;
    @init {
        $Expr::hasEntity = true;
    }
    :
    SET set_property (COMMA set_property)*
    -> ^(SET set_property+);


set_property:
    aliasnokey EQ expr
    -> ^(EQ aliasnokey expr);


where:
    WHERE condition (AND condition)* softwhere? -> ^(WHERE condition+ softwhere?)
    | WHERE softwhere -> ^(WHERE softwhere);


softwhere
    scope Expr;
    @init {
        $Expr::hasEntity = true;
    }
    :
    SOFT softcondmul (OR^ softcondmul)*;


condition: cond | condkey | condancestor | condin | condkeyin;


cond:
    property oper valorvarobj
    -> ^(oper property valorvarobj);


condkey:
    KEYPROP oper key
    -> ^(oper KEYPROP key);


condancestor:
    ANCESTOR IS key
    -> ^(ANCESTOR key);


condin:
    property IN LEFT_PAR listitem (COMMA listitem)* RIGHT_PAR -> ^(IN property ^(LIST listitem+))
    | property IN var -> ^(IN property var)
    | property IN LEFT_PAR gql_select RIGHT_PAR -> ^(IN property gql_select);


condkeyin:
    KEYPROP IN LEFT_PAR key (COMMA key)* RIGHT_PAR -> ^(IN KEYPROP ^(LIST key+))
    | KEYPROP IN var -> ^(IN KEYPROP var)
    | KEYPROP IN LEFT_PAR gql_select RIGHT_PAR -> ^(IN KEYPROP gql_select);


softcondmul:
    softcondat (AND^ softcondat)*;


softcondat
    scope Expr;
    @init {
        $Expr::hasEntity = true;
    }
    :
    NOT softcondat -> ^(NOT softcondat)
    | ANCESTOR IS expr -> ^(ANCESTOR expr)
    | expr operin expr -> ^(operin expr+);


oper: OPER | EQ;

operin: OPER | EQ | IN { $Expr::isNestedQueryAllowed = true; };


listitem: valorvarobj;


key: (STRING -> ^(KEY STRING))
    | (var -> ^(KEY var))
    | keyfunc;


keyfunc:
    KEY LEFT_PAR stringorvar RIGHT_PAR -> ^(KEY stringorvar)
    | KEY LEFT_PAR keypath RIGHT_PAR -> ^(KEY keypath);


keypath:
    kin=STRING COMMA intstringorvar (COMMA keypath)?
    -> ^(PATH $kin intstringorvar) keypath?;


orderby:
    ORDER BY orderbyitem (COMMA orderbyitem)* softorderby? -> ^(ORDER orderbyitem+ softorderby?)
    | ORDER BY softorderby -> ^(ORDER softorderby);


softorderby:
    SOFT orderbyitem (COMMA orderbyitem)*
    -> ^(SOFT orderbyitem+);


orderbyitem:
    prop -> ^(ASC prop)
    | prop ASC -> ^(ASC prop)
    | prop DESC -> ^(DESC prop);


limit:
    LIMIT off=INT COMMA lim=INT -> ^(LIMIT $lim) ^(OFFSET $off)
    | LIMIT lim=INT -> ^(LIMIT $lim);


offset:
    OFFSET INT
    -> ^(OFFSET INT);


valorvarobj:
    STRING
    | INT
    | FLOAT
    | TRUE
    | FALSE
    | NULL
    | var
    | datetime
    | keyfunc
    | geopt
    | user
    ;


datetime:
    DATE LEFT_PAR sval=STRING RIGHT_PAR -> ^(DATE $sval)
    | DATETIME LEFT_PAR sval=STRING RIGHT_PAR -> ^(DATETIME $sval)
    | TIME LEFT_PAR sval=STRING RIGHT_PAR -> ^(TIME $sval)
    | DATE LEFT_PAR year=intorvar COMMA month=intorvar COMMA day=intorvar RIGHT_PAR
        -> ^(DATE $year $month $day)
    | DATETIME LEFT_PAR year=intorvar COMMA month=intorvar COMMA day=intorvar COMMA hour=intorvar COMMA minute=intorvar COMMA second=intorvar RIGHT_PAR
        -> ^(DATETIME $year $month $day $hour $minute $second)
    | TIME LEFT_PAR hour=intorvar COMMA minute=intorvar COMMA second=intorvar RIGHT_PAR
        -> ^(TIME $hour $minute $second);


geopt:
    GEOPT LEFT_PAR lat=floatorvar COMMA lon=floatorvar RIGHT_PAR
    -> ^(GEOPT $lat $lon);


user:
    USER LEFT_PAR email=stringorvar RIGHT_PAR
    -> ^(USER $email);


intorvar: INT | var;


floatorvar: INT | FLOAT | var;


intstringorvar: INT | STRING | var;


stringorvar: STRING | var;


var: VARID;


prop: (property | KEYPROP);


property:
    id+=ID (DOT id+=ID)* -> ^(PROP $id+)
    | PROP LEFT_PAR STRING RIGHT_PAR -> ^(PROP STRING);


kind:
    id+=ID (DOT id+=ID)* -> ^(KIND $id+)
    | KIND LEFT_PAR STRING? RIGHT_PAR -> ^(KIND STRING?);


expr:
    mul ((PLUS | MINUS)^ mul)*
    | MINUS mul -> ^(UMINUS mul)
    | PLUS mul -> mul;


mul:
    atom (muloper^ atom)*;


muloper:
    ASTERISK -> MUL
    | SLASH -> DIV;


atom:
    valorvarobj
    | prop {
        if (!$Expr::hasEntity) throw new RuntimeException("Inproper use of property/key names");
    }
    | LEFT_PAR exprlist RIGHT_PAR -> exprlist
    | ID LEFT_PAR RIGHT_PAR -> ^(FUNC ID)
    | ID LEFT_PAR e+=expr (COMMA e+=expr)* RIGHT_PAR -> ^(FUNC ID expr+);


exprlist:
    expr (COMMA expr)* -> ^(LIST expr*)
    | gql_select {
        if (!$Expr::isNestedQueryAllowed) throw new RuntimeException("Nested query is not allowed here");
    };

