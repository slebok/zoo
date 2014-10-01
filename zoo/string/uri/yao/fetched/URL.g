/**
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
/*
 * This ANTLR grammar for HTTP URL is based on RFC 2396. But it does not 
 * strictly adhere to the RFC. It only handles common formats for HTTP URL. But 
 * it could be easily extended to handle all the URL formats specified by the 
 * RFC.
 */
 
grammar URL;

@header {
package org.jingguo.url;
}

@lexer::header {
package org.jingguo.url;
import java.io.*;
}

@lexer::members{
    public URLLexer(String s) throws IOException {
        this(new StringReader(s));
    }
    
    public URLLexer(Reader r) throws IOException {
        this(new ANTLRReaderStream(r));
    }
}

@members {
    URL url = new URL();
    public URL getURL() {
        return url;
    }
}

url: scheme ':' hier_part { url.protocol = $scheme.text; };
scheme: 'http';
hier_part: net_path ('?' query)? ('#' fragment_)? 
           { url.query = $query.text; url.ref = $fragment_.text; };
net_path: '//' server (abs_path)? 
          { url.path = $abs_path.text; };
abs_path: ('/' segment)+;

segment: (pchar)+;
pchar: escaped
    | unreserved
    | ':'
    | '@'
    | '&'
    | '='
    | '+'
    | '$'
    | ','
    ;

server: host (':' port)? 
        { url.host = $host.text; 
          if ($port.text != null)
            url.port = Integer.parseInt($port.text); 
        };
port: (DIGIT)+;
host: hostname | ipV4Address;

hostname: (domainlabel '.')* toplabel;
domainlabel: alphanum ((alphanum | '-')* alphanum)?;
toplabel: ALPHA ((alphanum | '-')? alphanum)?;

ipV4Address: (DIGIT)+ '.' (DIGIT)+ '.' (DIGIT)+ '.' (DIGIT)+;

fragment_: (uric)*;

query: param ('&' param)*;
param: pname '=' pvalue
       { url.params.put($pname.text, $pvalue.text); };
pname: (qc)+;
pvalue: (qc)+;

qc: escaped
 | Q_RESERVED
 | unreserved
 ;
uric: escaped
   | reserved
   | unreserved;

unreserved: alphanum | MARK;

escaped: '%' hex hex;
hex: DIGIT
  | HEX_LETTER
  ;
alphanum: DIGIT
        | ALPHA
        ;
reserved: Q_RESERVED | '=' | '&'; 

Q_RESERVED: ';' | '/' | '?' | ':' | '@' | '+' | '$' | ',';
MARK: '-' | '_' | '.' | '!' | '~' | '*' | '\'' | '(' | ')';
DIGIT: '0'..'9';
ALPHA: 'a'..'z' | 'A'..'Z' ;

fragment
HEX_LETTER: 'a'..'f' | 'A'..'F';
