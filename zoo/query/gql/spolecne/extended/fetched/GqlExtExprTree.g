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
tree grammar GqlExtExprTree;

options {
    ASTLabelType = CommonTree;
    tokenVocab = GqlExtParser;
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
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.GeoPt;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

import com.google.appengine.api.users.User;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.spoledge.audao.parser.gql.impl.soft.SoftFunction;
import com.spoledge.audao.parser.gql.impl.soft.SoftFunctionFactory;
import static com.spoledge.audao.parser.gql.impl.ParserUtils.*;

}

@members {

    /**
     * The logger.
     */
    private Log log = LogFactory.getLog( getClass());

    private Object[] args;
    private Entity ent;
    private RecognitionException firstError;
    private SoftFunctionFactory softFunctionFactory;


    ////////////////////////////////////////////////////////////////////////////
    // Manually created methods - public
    ////////////////////////////////////////////////////////////////////////////

    @Override
    public void reportError(RecognitionException e) {
        if (firstError == null) firstError = e;
        super.reportError( e );
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


    private Object plus( Object o1, Object o2 ) {
        return func( "PLUS", Arrays.asList( o1, o2 ));
    }

    private Object minus( Object o1, Object o2 ) {
        return func( "MINUS", Arrays.asList( o1, o2 ));
    }

    private Object mul( Object o1, Object o2 ) {
        return func( "MUL", Arrays.asList( o1, o2 ));
    }

    private Object div( Object o1, Object o2 ) {
        return func( "DIV", Arrays.asList( o1, o2 ));
    }

    private Object func( String fname, List<Object> params ) {
        if (softFunctionFactory == null) {
            softFunctionFactory = SoftFunctionFactory.getDefaultFactory();
        }

        fname = fname.toUpperCase();

        return softFunctionFactory.getSoftFunction( fname ).getFunctionValue( params );
    }


    ////////////////////////////////////////////////////////////////////////////
    // Dynamically generated methods
    ////////////////////////////////////////////////////////////////////////////
}


expr[Object[\] args, Entity ent] returns[Object value]
    @init{
        this.args = args;
        this.ent = ent;
    }
    : exprimpl {
        $value = $exprimpl.value;
    };
    finally {
        if (getNumberOfSyntaxErrors() != 0) throw firstError;
    }


key returns[Key value]:
    ^(KEY STRING) {
        $value = KeyFactory.stringToKey( string( $STRING.text ));
    }
    | ^(KEY var) {
        if ($var.value instanceof Key) {
            $value = (Key) $var.value;
        }
        else {
            $value = KeyFactory.stringToKey( argString( $var.value ));
        }
    }
    | ^(KEY keypath) {
        $value = $keypath.value.getKey();
    }
    ;


keypath returns[KeyFactory.Builder value]:
    (
        ^(PATH kin=STRING name=STRING) {
            $value = new KeyFactory.Builder( string( $kin.text ), string( $name.text ));
        }
        | ^(PATH kin=STRING id=INT) {
            $value = new KeyFactory.Builder( string( $kin.text ), new Long( $id.text ));
        }
        | ^(PATH kin=STRING var) {
            if ($var.value instanceof Number) {
                $value = new KeyFactory.Builder( string( $kin.text ), argLong( $var.value ));
            }
            else {
                $value = new KeyFactory.Builder( string( $kin.text ), argString( $var.value ));
            }
        }
    )
    keypathchild[$value]*;


keypathchild[KeyFactory.Builder builder]:
    ^(PATH kin=STRING name=STRING) {
        builder.addChild( string( $kin.text ), string( $name.text ));
    }
    | ^(PATH kin=STRING id=INT) {
        builder.addChild( string( $kin.text ), new Long( $id.text ));
    }
    | ^(PATH kin=STRING var) {
        if ($var.value instanceof Number) {
            builder.addChild( string( $kin.text ), argLong( $var.value ));
        }
        else {
            builder.addChild( string( $kin.text ), argString( $var.value ));
        }
    };


valorvarobj returns[Object value]:
    STRING { $value = string( $STRING.text );}
    | INT { $value = new Long( $INT.text );}
    | FLOAT { $value = new Double( $FLOAT.text );}
    | TRUE { $value = Boolean.TRUE;}
    | FALSE { $value = Boolean.FALSE;}
    | NULL { $value = null; }
    | var { $value = $var.value;}
    | datetime { $value = $datetime.value;}
    | key { $value = $key.value;}
    | geopt { $value = $geopt.value;}
    | user { $value = $user.value;}
    ;


datetime returns[Date value]:
    ^(DATE sval=STRING) {
        $value = date( string($sval.text));
    }
    | ^(DATETIME sval=STRING) {
        $value = ParserUtils.datetime( string($sval.text ));
    }
    | ^(TIME sval=STRING) {
        $value = time( string($sval.text ));
    }
    | ^(DATE year=intorvar month=intorvar day=intorvar) {
        $value = date( $year.value, $month.value, $day.value );
    }
    | ^(DATETIME year=intorvar month=intorvar day=intorvar hour=intorvar minute=intorvar second=intorvar) {
        $value = ParserUtils.datetime( $year.value, $month.value, $day.value, $hour.value, $minute.value, $second.value );
    }
    | ^(TIME hour=intorvar minute=intorvar second=intorvar) {
        $value = time( $hour.value, $minute.value, $second.value );
    }
    ;


geopt returns[GeoPt value]:
    ^(GEOPT lat=floatorvar lon=floatorvar) {
        $value = new GeoPt( $lat.value, $lon.value );
    }
    ;


user returns[User value]:
    ^(USER email=stringorvar) {
        $value = new User( $email.value, "gmail.com" );
    }
    ;


intorvar returns[Integer value]:
    INT { $value = new Integer( $INT.text );}
    | var { $value = argInt( $var.value );}
    ;


floatorvar returns[Float value]:
    INT { $value = new Float( $INT.text );}
    | FLOAT { $value = new Float( $FLOAT.text );}
    | var { $value = argFloat( $var.value );}
    ;



stringorvar returns[String value]:
    STRING { $value = string( $STRING.text );}
    | var { $value = argString( $var.value );}
    ;


var returns[Object value]:
    VARID { $value = arg( Integer.parseInt( $VARID.text.substring( 1 ))); }
    ;


prop returns[String value]:
    property {
        $value = $property.value;
    }
    | KEYPROP {
        $value = $KEYPROP.text;
    };


property returns[String value]:
    ^(PROP ids) {
        $value = $ids.value;
    }
    | ^(PROP STRING) {
        $value = string( $STRING.text );
    };


ids returns[String value]
    scope {
        StringBuilder sb;
    }
    @init {
        $ids::sb = new StringBuilder();
    }
    :
    ID {
        $ids::sb.append( $ID.text );
    }
    ids2* {
        $value = $ids::sb.toString();
    };


ids2 returns[String value]:
    ID {
        $ids::sb.append( '.' ).append( $ID.text );
    };
    

exprimpl returns[Object value]:
    ^(PLUS e1=exprimpl e2=exprimpl) {
        $value = plus( $e1.value, $e2.value );
    }
    | ^(UMINUS e1=exprimpl) {
        $value = minus( 0, $e1.value );
    }
    | ^(MINUS e1=exprimpl e2=exprimpl) {
        $value = minus( $e1.value, $e2.value );
    }
    | ^(MUL e1=exprimpl e2=exprimpl) {
        $value = mul( $e1.value, $e2.value );
    }
    | ^(DIV e1=exprimpl e2=exprimpl) {
        $value = div( $e1.value, $e2.value );
    }
    | vov=valorvarobj {
        $value = $vov.value;
    }
    | KEYPROP {
        $value = ent.getKey();
    }
    | property {
        $value = ent.getProperty( $property.value );
    }
    | ^(FUNC fn=. list?) {
        $value = func( $fn.toString(), $list != null ? $list.value : null );
    }
    | ^(LIST list) {
        switch ($list.value.size()) {
            case 0: $value = null; break;
            case 1: $value = $list.value.get(0); break;
            default: $value = $list.value;
        }
    };


list returns[ArrayList<Object> value]
    scope {
        ArrayList<Object> values;
    }
    @init {
        $list::values = new ArrayList<Object>();
    }
    :
    listitem+ {
        $value = $list::values;
    }; 


listitem:
    exprimpl {
        $list::values.add( $exprimpl.value );
    };

