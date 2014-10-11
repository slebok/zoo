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
lexer grammar GqlExtLexer;

import GqlLexer;

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

}


/*********************************************
 * KEYWORDS
 **********************************************/

AS: A S;
DELETE: D E L E T E;
DUAL: D U A L;
EMPTY: E M P T Y;
INSERT: I N S E R T;
INTO: I N T O;
KIND: K I N D;
NOT: N O T;
OR: O R;
PROP: P R O P;
SET: S E T;
SOFT: S O F T;
UNINDEXED: U N I N D E X E D;
UPDATE: U P D A T E;
VALUES: V A L U E S;


/*********************************************
 * MISC
 **********************************************/

ASTERISK: '*';
COMMA: ',';
DOT: '.';
LEFT_PAR: '(';
RIGHT_PAR: ')';
SLASH: '/';
