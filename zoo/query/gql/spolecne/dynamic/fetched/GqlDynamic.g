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
grammar GqlDynamic;

import GqlLexer;

@lexer::header {
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
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.google.appengine.api.datastore.GeoPt;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query;

import com.google.appengine.api.users.User;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import static com.spoledge.audao.parser.gql.impl.ParserUtils.*;

}

@members {
    private static final HashMap<String, Query.FilterOperator> OPERANDS = new HashMap<String, Query.FilterOperator>();

    static {
        OPERANDS.put( "=", Query.FilterOperator.EQUAL );
        OPERANDS.put( ">", Query.FilterOperator.GREATER_THAN );
        OPERANDS.put( ">=", Query.FilterOperator.GREATER_THAN_OR_EQUAL );
        OPERANDS.put( "<", Query.FilterOperator.LESS_THAN );
        OPERANDS.put( "<=", Query.FilterOperator.LESS_THAN_OR_EQUAL );
        OPERANDS.put( "!=", Query.FilterOperator.NOT_EQUAL );
        OPERANDS.put( "IN", Query.FilterOperator.IN );
    }

    /**
     * The logger.
     */
    private Log log = LogFactory.getLog( getClass());

    private Query query;
    private Object[] args;
    private RecognitionException firstError;
    private Integer offset;
    private Integer limit;
    private boolean multipleQueries;
    private boolean keysOnly;


    ////////////////////////////////////////////////////////////////////////////
    // Manually created methods
    ////////////////////////////////////////////////////////////////////////////

    @Override
    public void reportError(RecognitionException e) {
        if (firstError == null) firstError = e;
        super.reportError( e );
    }


    /**
     * Returns the offset of the GQL query.
     */
    public Integer getOffset() {
        return offset;
    }


    /**
     * Returns the limit of the GQL query.
     */
    public Integer getLimit() {
        return limit;
    }


    /**
     * Returns true iff the last query was a multiple query ("!=" or "IN" operators).
     */
    public boolean wasMultipleQueries() {
        return multipleQueries;
    }


    /**
     * Returns true iff the last query returns keys only.
     */
    public boolean wasKeysOnly() {
        return keysOnly;
    }


    ////////////////////////////////////////////////////////////////////////////
    // Manually created methods - private
    ////////////////////////////////////////////////////////////////////////////

    private Object arg(int pos) {
        if (args == null) {
            // when passing 'null' - it is treated as (Object[])
            if (pos == 1) return null;
        }
        else if (pos <= args.length) return args[ pos - 1 ];

        log.error("arg(): no such parameter ':" + pos + "'");

        throw new RuntimeException("No such parameter ':" + pos + "'");
    }


    ////////////////////////////////////////////////////////////////////////////
    // Dynamically generated methods
    ////////////////////////////////////////////////////////////////////////////
}


gql[Object[\] args] returns[Query value]
@init{
    this.args = args;
    firstError = null;
    offset = limit = null;
    multipleQueries = false;
    keysOnly = false;
}
    :
    SELECT ('*'|iskey=KEYPROP) FROM kind {
        query = new Query( $kind.value );
        if (iskey != null) keysOnly = true;
    }
    where? orderby? limit? offset? {
        $gql.value = query;
        if (keysOnly && !multipleQueries) query.setKeysOnly();
    }
    ;
    finally {
        if (getNumberOfSyntaxErrors() != 0) throw firstError;
    }


gqlcond[Query query, Object[\] args] returns[Query value]
@init{
    this.query = query != null ? query : new Query();
    this.args = args;
    firstError = null;
    offset = limit = null;
    multipleQueries = false;
    keysOnly = false;
}
    :
    conditions orderby? {
        $gqlcond.value = query;
    }
    ;
    finally {
        if (getNumberOfSyntaxErrors() != 0) throw firstError;
    }


where: WHERE conditions;

conditions: condition (AND condition)*;


condition: cond | condkey | condancestor | condin | condkeyin;


cond:
    property oper vov=valorvarobj {
        Query.FilterOperator oper = OPERANDS.get( $oper.value );

        if (log.isDebugEnabled()) {
            if ($vov.value != null && ($vov.value instanceof Collection)) {
                Collection col = (Collection)$vov.value;

                if (col.size() == 0) {
                    log.debug("query.addFilter( \"" + $property.value
                        + "\", Query.FilterOperator." + oper.name() + ", null)");
                }
                else {
                    for (Object o : ((Collection)$vov.value)) {
                        log.debug("query.addFilter( \"" + $property.value
                            + "\", Query.FilterOperator." + oper.name() + ", "
                            + (o != null ?
                                o.getClass().getName() + '(' + o + ')'
                                : "null") + ')');
                    }

                }
            }
            else {
                log.debug("query.addFilter( \"" + $property.value
                    + "\", Query.FilterOperator." + oper.name() + ", "
                    + ($vov.value != null ?
                        $vov.value.getClass().getName() + '(' + $vov.value + ')'
                        : "null") + ')');
            }
        }

        if ($vov.value != null && ($vov.value instanceof Collection)) {
            Collection col = (Collection)$vov.value;

            if (col.size() == 0) {
                query.addFilter( $property.value, oper, null );
            }
            else {
                for (Object o : col) {
                    query.addFilter( $property.value, oper, o );
                }
            }
        }
        else query.addFilter( $property.value, oper, $vov.value );
    }
    ;


condkey:
    KEYPROP oper key {
        query.addFilter( $KEYPROP.text, OPERANDS.get( $oper.value ), $key.value );
    }
    ;


condancestor:
    ANCESTOR IS key {
        query.setAncestor( $key.value );
    }
    ;


condin:
    property IN
    (
        (
            '(' {
                ArrayList list = new ArrayList();
            }
            listitem[list] (',' listitem[list])* ')' {
                query.addFilter( $property.text, Query.FilterOperator.IN, list );
            }
        )
        | var {
            query.addFilter( $property.text, Query.FilterOperator.IN, $var.value );
        }
    )
    ;


condkeyin:
    KEYPROP IN
    (
        (
            '(' {
                ArrayList<Key> list = new ArrayList<Key>();
            }
            listitemkey[list] (',' listitemkey[list])* ')' {
                query.addFilter( $KEYPROP.text, Query.FilterOperator.IN, list );
            }
        )
        | var {
            query.addFilter( $KEYPROP.text, Query.FilterOperator.IN, $var.value );
        }
    )
    ;


oper returns[String value]:
    EQ {
        $value = $EQ.text;
    }
    | OPER {
        $value = $OPER.text;
    }
    ;


listitem[List list]:
    vov=valorvarobj {
        list.add( $vov.value );
    }
    ;


listitemkey[List<Key> list]:
    key {
        list.add( $key.value );
    }
    ;


key returns[Key value]:
    STRING {
        $value = KeyFactory.stringToKey( string( $STRING.text ));
    }
    | var {
        if ($var.value instanceof Key) {
            $value = (Key) $var.value;
        }
        else {
            $value = KeyFactory.stringToKey( argString( $var.value ));
        }
    }
    | keyfunc {
        $value = $keyfunc.value;
    }
    ;


keyfunc returns[Key value]:
    KEY '('
    (
        vov=stringorvar {
            $value = KeyFactory.stringToKey( $vov.value );
        }
        | keypath {
            $value = $keypath.value.getKey();
        }
    )
    ')'
    ;


keypath returns[KeyFactory.Builder value]:
    kin=STRING ','
    (
        name=STRING {
            $value = new KeyFactory.Builder( string( $kin.text ), string( $name.text ));
        }
        | id=INT {
            $value = new KeyFactory.Builder( string( $kin.text ), new Long( $id.text ));
        }
        | var {
            if ($var.value instanceof Number) {
                $value = new KeyFactory.Builder( string( $kin.text ), argLong( $var.value ));
            }
            else {
                $value = new KeyFactory.Builder( string( $kin.text ), argString( $var.value ));
            }
        }
    )
    keypathchild[$value] ?
    ;


keypathchild[KeyFactory.Builder builder]:
    ',' kin=STRING ','
    (
        name=STRING { builder.addChild( string( $kin.text ), string( $name.text )); }
        | id=INT { builder.addChild( string( $kin.text ), new Long( $id.text )); }
        | var { builder.addChild( string( $kin.text ), argLong( $var.value )); }
    )
    keypathchild[builder] ?
    ;


orderby: ORDER BY orderbyitem (',' orderbyitem)*;


orderbyitem:
    (
        property
        | KEYPROP
    )
    (
        ASC?  {
            query.addSort( $property.value != null ? $property.value : $KEYPROP.text,
                Query.SortDirection.ASCENDING );
        }
        | isdesc=DESC {
            query.addSort( $property.value != null ? $property.value : $KEYPROP.text,
                Query.SortDirection.DESCENDING );
        }
    )
    {
        if (log.isDebugEnabled()) {
            log.debug("query.addSort( \"" +  ($property.value != null ? $property.value : $KEYPROP.text)
                + "\", Query.SortDirection." + (isdesc != null ? "DESCENDING" : "ASCENDING") + " )");
        }
    }
    ;


limit:
    LIMIT
    (
        off=INT ',' {
            offset = new Integer( $off.text );
        }
    )?
    lim=INT {
         limit = new Integer( $lim.text );
    }
    ;


offset:
    OFFSET INT {
         offset = new Integer( $INT.text );
    }
    ;


valorvarobj returns[Object value]:
    STRING { $value = string( $STRING.text );}
    | t_long { $value = $t_long.value;}
    | t_double { $value = $t_double.value;}
    | TRUE { $value = Boolean.TRUE;}
    | FALSE { $value = Boolean.FALSE;}
    | NULL { $value = null; }
    | var { $value = $var.value;}
    | datetime { $value = $datetime.value;}
    | keyfunc { $value = $keyfunc.value;}
    | geopt { $value = $geopt.value;}
    | user { $value = $user.value;}
    ;


datetime returns[Date value]:
    DATE '(' sval=STRING ')' { $value = date( string($sval.text)); }
    | DATETIME '(' sval=STRING ')' { $value = ParserUtils.datetime( string($sval.text )); }
    | TIME '(' sval=STRING ')' { $value = time( string($sval.text )); }
    | DATE '(' year=intorvar ',' month=intorvar ',' day=intorvar ')'
        { $value = date( $year.value, $month.value, $day.value ); }
    | DATETIME '(' year=intorvar ',' month=intorvar ',' day=intorvar ',' hour=intorvar ',' minute=intorvar ',' second=intorvar ')'
        { $value = ParserUtils.datetime( $year.value, $month.value, $day.value, $hour.value, $minute.value, $second.value ); }
    | TIME '(' hour=intorvar ',' minute=intorvar ',' second=intorvar ')'
        { $value = time( $hour.value, $minute.value, $second.value ); }
    ;


geopt returns[GeoPt value]:
    GEOPT '(' lat=floatorvar ',' lon=floatorvar ')' {
        $value = new GeoPt( $lat.value, $lon.value );
    }
    ;

user returns[User value]:
    USER '(' email=stringorvar ')' {
        $value = new User( $email.value, "gmail.com" );
    }
    ;


intorvar returns[Integer value]:
    INT { $value = new Integer( $INT.text );}
    | var { $value = argInt( $var.value );}
    ;


floatorvar returns[Float value]:
    t_long { $value = new Float($t_long.value.floatValue());}
    | t_double { $value = new Float( $t_double.value.floatValue());}
    | var { $value = argFloat( $var.value );}
    ;



stringorvar returns[String value]:
    STRING { $value = string( $STRING.text );}
    | var { $value = argString( $var.value );}
    ;


t_long returns[Long value]:
    PLUS? INT {
        $value = new Long( $INT.text );
    }
    | MINUS INT {
        $value = new Long( "-" + $INT.text );
    };


t_double returns[Double value]:
    PLUS? FLOAT {
        $value = new Double( $FLOAT.text );
    }
    | MINUS FLOAT {
        $value = new Double( "-" + $FLOAT.text );
    };


var returns[Object value]:
    VARID { $value = arg( Integer.parseInt( $VARID.text.substring( 1 ))); }
    ;


property returns[String value]:
    ID {
        $value = $ID.text;
    }
    | STRING {
        $value = string( $STRING.text );
    }
    ;


kind returns[String value]:
    (
        id=ID {
            $value = $id.text;
        }
        (
            '.' id2=ID {
                $value += '.' + $id2.text;
            }
        )*
    )
    | STRING {
        $value = string( $STRING.text );
    }
    ;

