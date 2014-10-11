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
tree grammar GqlExtTree;

options {
    ASTLabelType = CommonTree;
    tokenVocab = GqlExtParser;
}

scope Query {
    Query query;
    SoftCondition softCondition;
    boolean isAllColumns;
    boolean isKeyOnly;
    SoftColumn softKeyColumn;
    ArrayList<SoftColumn> softColumns;
    Integer limit;
    Integer offset;
    Iterable<Entity> nestedEntityIterable;
    String[] nestedColumnNames;
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
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.GeoPt;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;

import com.google.appengine.api.users.User;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.spoledge.audao.parser.gql.impl.soft.*;
import static com.spoledge.audao.parser.gql.impl.ParserUtils.*;
import static com.spoledge.audao.parser.gql.impl.soft.SoftConstants.__KEY__;

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

    private RecognitionException firstError;
    private DatastoreService ds;
    private Object[] args;
    private int recordCounter;
    private Iterable<Entity> topEntityIterable;
    private String[] topColumnNames;


    ////////////////////////////////////////////////////////////////////////////
    // Manually created methods
    ////////////////////////////////////////////////////////////////////////////

    @Override
    public void reportError(RecognitionException e) {
        if (firstError == null) firstError = e;
        super.reportError( e );
    }


    /**
     * Returns the result iterable.
     * Only valid for SELECT QueryType.
     */
    public Iterable<Entity> getEntityIterable() {
        return topEntityIterable;
    }


    /**
     * Returns the known columns names.
     * Only valid for SELECT QueryType.
     * @return the column names or null if not known
     */
    public String[] getColumnNames() {
        return topColumnNames;
    }


    /**
     * Returns the number of records last updated/deleted.
     */
    public int getRecordCounter() {
        return recordCounter;
    }


    ////////////////////////////////////////////////////////////////////////////
    // Manually created methods - private
    ////////////////////////////////////////////////////////////////////////////

    private Iterable<Entity> dual() {
        return new Iterable<Entity>() {
            public Iterator<Entity> iterator() {
                return new Iterator<Entity>() {
                    private boolean hasNext = true;

                    public boolean hasNext() {
                        return hasNext;
                    }

                    public Entity next() {
                        if (!hasNext) throw new java.util.NoSuchElementException();
                        hasNext = false;

                        return new Entity("__DUAL__");
                    }

                    public void remove() {
                    }
                };
            }
        };
    }


    /**
     * Returns the FetchOptions.
     */
    private FetchOptions fetchOptions( Integer offset, Integer limit ) {
        FetchOptions ret = FetchOptions.Builder.withOffset( offset != null ? offset : 0);

        if (limit != null) {
            ret = ret.limit( limit );
        }

        return ret;
    }


    private boolean softFilter( SoftCondition softCondition, Entity ent ) {
        if (softCondition == null) return true;

        return softCondition.getConditionValue( args, ent );
    }


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


gqlext[DatastoreService ds, Object[\] args] returns[Query value]
    @init{
        this.ds = ds;
        this.args = args;
        topEntityIterable = null;
        topColumnNames = null;
        recordCounter = 0;
    }
    : gql_select {
        topEntityIterable = $gql_select.value;
        topColumnNames = $gql_select.columnNames;
    }
    | gql_insert | gql_update | gql_delete;
    finally {
        if (getNumberOfSyntaxErrors() != 0) throw firstError;
    }


gql_select returns [Iterable<Entity> value, String[\] columnNames]
    scope Query;
    :
    ^(SELECT kindorquery get_properties where? orderby? limit? offset?) {
        if ($Query::isKeyOnly && $Query::nestedEntityIterable == null) $Query::query.setKeysOnly();

        final Iterable<Entity> nestedEntityIterable = $Query::nestedEntityIterable;
        final PreparedQuery pq = nestedEntityIterable == null ? ds.prepare( $Query::query ) : null;
        final boolean isAllColumns = $Query::isAllColumns;
        final SoftColumn softKeyColumn = $Query::softKeyColumn;
        final ArrayList<SoftColumn> softColumns = $Query::softColumns;
        final SoftCondition softCondition = $Query::softCondition;
        final Integer offset = $Query::offset;
        final Integer limit = $Query::limit;

        $value = new Iterable<Entity>() {
            public Iterator<Entity> iterator() {
                return new SoftEntityIterator(
                                isAllColumns,
                                softKeyColumn,
                                softColumns,
                                pq != null ?
                                    pq.asIterator( fetchOptions( offset, limit)) :
                                    nestedEntityIterable.iterator(),
                                softCondition,
                                pq == null ? offset : null,
                                pq == null ? limit : null,
                                args );
            }
        };

        if (isAllColumns) {
            $columnNames = $Query::nestedColumnNames;
        }
        else if ($Query::isKeyOnly) {
            $columnNames = new String[]{ __KEY__ };
        }
        else if (softColumns != null) {
            $columnNames = new String[ softColumns.size() ];
            int i=0;
            for (SoftColumn sc : softColumns) {
                $columnNames[i++] = sc.getColumnName();
            }
        }
    };


gql_select_one returns [Iterable<?> value]
    scope Query;
    :
    ^(SELECT kindorquery get_properties where? orderby? limit? offset?) {
        if ($Query::isKeyOnly && $Query::nestedEntityIterable == null) $Query::query.setKeysOnly();

        final Iterable<Entity> nestedEntityIterable = $Query::nestedEntityIterable;
        final PreparedQuery pq = nestedEntityIterable == null ? ds.prepare( $Query::query ) : null;
        final boolean isAllColumns = $Query::isAllColumns;
        final SoftColumn softKeyColumn = $Query::softKeyColumn;
        final ArrayList<SoftColumn> softColumns = $Query::softColumns;
        final SoftCondition softCondition = $Query::softCondition;
        final Integer offset = $Query::offset;
        final Integer limit = $Query::limit;

        if ($Query::isKeyOnly) {
            $value = new Iterable<Key>() {
                public Iterator<Key> iterator() {
                    return new SoftKeyIterator(
                                    softKeyColumn,
                                    pq != null ?
                                        pq.asIterator( fetchOptions( offset, limit)) :
                                        nestedEntityIterable.iterator(),
                                    softCondition,
                                    pq == null ? offset : null,
                                    pq == null ? limit : null,
                                    args );
                }
            };
        }
        else {
            $value = new Iterable<Object>() {
                public Iterator<Object> iterator() {
                    return new SoftPropertyIterator(
                                    softColumns.get(0),
                                    pq != null ?
                                        pq.asIterator( fetchOptions( offset, limit)) :
                                        nestedEntityIterable.iterator(),
                                    softCondition,
                                    pq == null ? offset : null,
                                    pq == null ? limit : null,
                                    args );
                }
            };
        }
    };


gql_insert
    scope {
        ArrayList<SoftColumn> columns;
        ArrayList<SoftColumn> values;
        int keyIndex;
    }
    @init{
        $gql_insert::columns = new ArrayList<SoftColumn>();
        $gql_insert::values = new ArrayList<SoftColumn>();
        $gql_insert::keyIndex = -1;
    }
    :
    ^(INSERT kin=kindless columns values) {
        Entity ent = null;
        if ($gql_insert::keyIndex != -1) {
            ent = new Entity( $gql_insert::values.get($gql_insert::keyIndex).getValueKey( true, args, null ));
        }
        else ent = new Entity( $kindless.value );

        for (int i=0; i < $gql_insert::values.size(); i++) {
            if ( i == $gql_insert::keyIndex ) continue;
            SoftColumn sc = $gql_insert::values.get(i );
            String columnName = sc.getColumnName();
            Object val = sc.getValue( args );

            if (val == null) {
                if (sc.isUnindexed() || sc.isEmpty()) continue;
                ent.setProperty( columnName, null );
            }
            else if (sc.isUnindexed()) {
                ent.setUnindexedProperty( columnName, val );
            }
            else ent.setProperty( columnName, val );
        }

        ds.put( ent );

        recordCounter++;
    };


gql_update
    scope {
        ArrayList<SoftColumnExpr> changes;
    }
    scope Query;
    @init {
        $gql_update::changes = new ArrayList<SoftColumnExpr>();
    }
    :
    ^(UPDATE kindquery set_properties where? orderby? limit? offset?) {
        PreparedQuery pq = ds.prepare( $Query::query );

        for (Entity ent : pq.asIterable( fetchOptions( $Query::offset, $Query::limit ))) {
            if (!softFilter( $Query::softCondition, ent )) continue;

            for (SoftColumn sc : $gql_update::changes) {
                String columnName = sc.getColumnName();
                Object val = sc.getValue( args, ent );

                if (val == null) {
                    if (sc.isUnindexed() || sc.isEmpty()) ent.removeProperty( columnName );
                    else ent.setProperty( columnName, null );
                }
                else if (sc.isUnindexed()) {
                    ent.setUnindexedProperty( columnName, val );
                }
                else ent.setProperty( columnName, val );
            }

            ds.put( ent );

            recordCounter++;
        }
    };


gql_delete
    scope Query;
    :
    ^(DELETE kindquery where? orderby? limit? offset?) {
        $Query::query.setKeysOnly();
        PreparedQuery pq = ds.prepare( $Query::query );

        for (Entity ent : pq.asIterable( fetchOptions( $Query::offset, $Query::limit))) {
            if (!softFilter( $Query::softCondition, ent )) continue;
            ds.delete( ent.getKey());
            recordCounter++;
        }
    };


kindorquery:
    kindquery
    | DUAL {
        $Query::nestedEntityIterable = dual();
    }
    | gql_select {
        $Query::nestedEntityIterable = $gql_select.value;
        $Query::nestedColumnNames = $gql_select.columnNames;
    };


get_properties:
    ^(PROP get_property+);


get_property:
    ASTERISK {
        $Query::isAllColumns = true;
        $Query::isKeyOnly = false;
    }
    | KEYPROP {
        if (!$Query::isAllColumns && $Query::softColumns == null) $Query::isKeyOnly = true;
    }
    | property {
        if ($Query::softColumns == null) {
            $Query::softColumns = new ArrayList<SoftColumn>();
        }

        $Query::softColumns.add( new SoftColumn( $property.value ));
        $Query::isKeyOnly = false;
    }
    | ^(COLAS alias expr=.) {
        SoftColumnExpr sce = new SoftColumnExpr( $expr, $alias.value, $alias.isUnindexed, $alias.isEmpty );

        if (__KEY__.equals( $alias.value )) {
            if (!$Query::isAllColumns && $Query::softColumns == null) $Query::isKeyOnly = true;
            $Query::softKeyColumn = sce;
        }
        else {
            if ($Query::softColumns == null) {
                $Query::softColumns = new ArrayList<SoftColumn>();
            }

            $Query::softColumns.add( sce );
            $Query::isKeyOnly = false;
        }

        if (log.isDebugEnabled()) {
            log.debug("column(): alias=" + $alias.value + ", tree=" + $expr.toStringTree());
        }
    };


alias returns[String value, boolean isUnindexed, boolean isEmpty]:
    STRING {
        $value = string( $STRING.text );
        $isUnindexed = false;
    }
    | prop {
        $value = $prop.value;
        $isUnindexed = false;
        $isEmpty = false;
    }
    | ^(UNINDEXED STRING) {
        $value = string( $STRING.text );
        $isUnindexed = true;
        $isEmpty = false;
    }
    | ^(EMPTY STRING) {
        $value = string( $STRING.text );
        $isUnindexed = false;
        $isEmpty = true;
    };


columns:
    ^(COLAS column+);


values:
    ^(VALUES value+);


column: 
    alias {
        if (__KEY__.equals( $alias.value )) {
            $gql_insert::keyIndex = $gql_insert::columns.size();
        }
        $gql_insert::columns.add( new SoftColumn( $alias.value, $alias.isUnindexed, $alias.isEmpty));
    };


value: 
    expr=. {
        SoftColumn sc = $gql_insert::columns.get( $gql_insert::values.size());
        $gql_insert::values.add( new SoftColumnExpr( $expr, sc ));
        if (false) throw new RecognitionException(); // fake to fuck compiler
    };


set_properties:
    ^(SET set_property+);


set_property:
    ^(EQ alias expr=.) {
        $gql_update::changes.add( new SoftColumnExpr( $expr, $alias.value, $alias.isUnindexed, $alias.isEmpty ));
    };


where:
    ^(WHERE condition* softwhere?);


softwhere:
    SOFT sc=softcondition {
        $Query::softCondition = $sc.value;
    };


softcondition returns[SoftCondition value]:
    ^(AND sc1=softcondition sc2=softcondition) {
        $value = new SoftCondAnd( $sc1.value, $sc2.value );
    }
    | ^(OR sc1=softcondition sc2=softcondition) {
        $value = new SoftCondOr( $sc1.value, $sc2.value );
    }
    | ^(NOT sc=softcondition) {
        $value = new SoftCondNot( $sc.value );
    }
    | ^(oper expr1=. expr2=.) {
        $value = new SoftCondOper( new SoftColumnExpr( $expr1 ), new SoftColumnExpr( $expr2 ), $oper.value );
    }
    | ^(IN expr1=. gql_select_one) {
        $value = new SoftCondIn( new SoftColumnExpr( $expr1 ), $gql_select_one.value );
    }
    | ^(IN expr1=. ^(expr3=LIST .*)) {
        $value = new SoftCondIn( new SoftColumnExpr( $expr1 ), new SoftColumnExpr( $expr3 ));
    }
    | ^(IN expr1=. var) {
        $value = new SoftCondIn( new SoftColumnExpr( $expr1 ), $var.value);
    }
    | ^(ANCESTOR expr=.) {
        $value = new SoftCondAncestor( new SoftColumnExpr( $expr ));
    };


condition: cond | condkey | condancestor | condin;


cond:
    ^(oper property vov=valorvarobj) {
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
                $Query::query.addFilter( $property.value, oper, null );
            }
            else {
                for (Object o : col) {
                    $Query::query.addFilter( $property.value, oper, o );
                }
            }
        }
        else $Query::query.addFilter( $property.value, oper, $vov.value );
    }
    ;


oper returns[String value]:
    OPER { $value = $OPER.text; }
    | EQ { $value = $EQ.text; };


condkey:
    ^(oper KEYPROP key) {
        $Query::query.addFilter( $KEYPROP.text, OPERANDS.get( $oper.value ), $key.value );
    };


condancestor:
    ^(ANCESTOR key) {
        $Query::query.setAncestor( $key.value );
    };


condin:
    ^(IN prop inval) {
        $Query::query.addFilter( $prop.value, Query.FilterOperator.IN, $inval.value );
    };


inval returns[Object value]:
    var { $value = $var.value; }
    | inlist { $value = $inlist.value; }
    | gql_select_one {
        ArrayList<Object> ret = new ArrayList<Object>();
        for (Object o : $gql_select_one.value) {
            ret.add( o );
        }

        $value = ret;
    };
    

inlist returns[ArrayList value]
    scope {
        ArrayList list;
    }
    @init {
        $inlist::list = new ArrayList();
    }
    :
    ^(LIST listitem+) {
        $value = $inlist::list;
    };


listitem:
    vov=valorvarobj {
        $inlist::list.add( $vov.value );
    };


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


orderby:
    ^(ORDER orderbyitem+);


orderbyitem:
    ^(ASC prop) {
        $Query::query.addSort( $prop.value, Query.SortDirection.ASCENDING );
    }
    | ^(DESC prop) {
        $Query::query.addSort( $prop.value, Query.SortDirection.DESCENDING );
    };


limit:
    ^(LIMIT INT) {
         $Query::limit = new Integer( $INT.text );
    };


offset:
    ^(OFFSET INT) {
         $Query::offset = new Integer( $INT.text );
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


kindquery:
    kind {
        $Query::query = new Query( $kind.value );
    }
    | KIND {
        $Query::query = new Query();
        log.debug("kindquery(): <all>");
    };


kindless returns[String value]:
    kind {
        $value = $kind.value;
    }
    | KIND {
        $value = null;
    };


kind returns[String value]:
    ^(KIND ids) {
        $value = $ids.value;
    }
    | ^(KIND STRING) {
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
    

