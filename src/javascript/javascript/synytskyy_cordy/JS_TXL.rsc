@contributor{GrammarLab Rascal syntax definition exporter}
module javascript::synytskyy_cordy::JS_TXL

start syntax Program
	= DeclarationOrStatement*
	;
syntax Subscope
	= DeclarationOrStatement*
	;
syntax DeclarationOrStatement
	= Declaration
	| (Label? Statement)
	| Comment
	;
syntax Label
	= Identifier ":"
	;
syntax Declaration
	= (VariableDeclaration ";"?)
	| (ConstantDeclaration ";"?)
	| (FunctionDeclaration ";"?)
	;
syntax VariableDeclaration
	= "var" {VariableDescription ","}*
	;
syntax VariableDescription
	= Identifier VariableInitialization?
	;
syntax VariableInitialization
	= "=" AssignmentExpn
	;
syntax ConstantDeclaration
	= "const" {ConstantDescription ","}*
	;
syntax ConstantDescription
	= Identifier VariableInitialization
	;
syntax FunctionDeclaration
	= "function" Identifier "(" {FormalParameter ","}* ")" "{" Subscope "}"
	;
syntax FunctionExpn
	= "function" Identifier? "(" {FormalParameter ","}* ")" "{" Subscope "}"
	;
syntax FormalParameter
	= Identifier
	;
syntax Expn
	= AssignmentExpn+
	;
syntax AssignmentExpn
	= ConditionalExpn AssignJsConditionalExpn*
	;
syntax AssignJsConditionalExpn
	= AssignmentOp ConditionalExpn
	;
syntax AssignmentOp
	= "="
	| "*="
	| ("/" "=")
	| "%="
	| "+="
	| "-="
	| "\<\<="
	| "\>\>="
	| "\>\>\>="
	| "&="
	| "^="
	| "|="
	;
syntax ConditionalExpn
	= LogicalOrExpn ConditionalClause?
	;
syntax ConditionalClause
	= "?" AssignmentExpn ":" AssignmentExpn
	;
syntax LogicalOrExpn
	= LogicalAndExpn LogicalOrLogicalAndExpn*
	;
syntax LogicalOrLogicalAndExpn
	= "||" LogicalAndExpn
	;
syntax LogicalAndExpn
	= BitwiseOrExpn LogicalAndBitwiseOrExpn*
	;
syntax LogicalAndBitwiseOrExpn
	= "&&" BitwiseOrExpn
	;
syntax BitwiseOrExpn
	= BitwiseXorExpn BitwiseOrBitwiseXorExpn*
	;
syntax BitwiseOrBitwiseXorExpn
	= "|" BitwiseXorExpn
	;
syntax BitwiseXorExpn
	= BitwiseAndExpn BitwiseXorBitwiseAndExpn*
	;
syntax BitwiseXorBitwiseAndExpn
	= "^" BitwiseAndExpn
	;
syntax BitwiseAndExpn
	= EqualityExpn BitwiseAndEqualityExpn*
	;
syntax BitwiseAndEqualityExpn
	= "&" EqualityExpn
	;
syntax EqualityExpn
	= RelationalExpn EqualityOpRelationalExpn*
	;
syntax EqualityOpRelationalExpn
	= EqualityOp RelationalExpn
	;
syntax EqualityOp
	= "=="
	| "!="
	| "==="
	| "!=="
	| "in"
	| "instanceof"
	;
syntax RelationalExpn
	= ShiftExpn RelationalOpShiftExpn*
	;
syntax RelationalOpShiftExpn
	= RelationalOp ShiftExpn
	;
syntax RelationalOp
	= "\<"
	| "\>"
	| "\<="
	| "\>="
	;
syntax ShiftExpn
	= AdditiveExpn ShiftOpAdditiveExpn*
	;
syntax ShiftOpAdditiveExpn
	= ShiftOp AdditiveExpn
	;
syntax ShiftOp
	= "\<\<"
	| "\>\>"
	| "\>\>\>"
	;
syntax AdditiveExpn
	= MultiplicativeExpn AdditiveOpMultiplicativeExpn*
	;
syntax AdditiveOpMultiplicativeExpn
	= AdditiveOp MultiplicativeExpn
	;
syntax AdditiveOp
	= "+"
	| "-"
	;
syntax MultiplicativeExpn
	= UnaryExpn MultiplicativeOpUnaryExpn*
	;
syntax MultiplicativeOpUnaryExpn
	= MultiplicativeOp UnaryExpn
	;
syntax MultiplicativeOp
	= "*"
	| "/"
	| "%"
	;
syntax UnaryExpn
	= UnaryOp* PostfixExpn
	;
syntax UnaryOp
	= "delete"
	| "void"
	| "typeof"
	| "++"
	| "--"
	| "+"
	| "-"
	| "~"
	| "!"
	;
syntax PostfixExpn
	= LefthandSideExpn PostfixOp?
	;
syntax PostfixOp
	= "++"
	| "--"
	;
syntax LefthandSideExpn
	= "new"? MemberExpn
	;
syntax MemberExpn
	= PrimaryExpn Selector*
	;
syntax Selector
	= Arguments
	| Subscripts
	| FieldSelector
	;
syntax Arguments
	= "(" {AssignmentExpn ","}* ")"
	;
syntax Subscripts
	= "[" Expn "]"
	;
syntax FieldSelector
	= "." Identifier
	;
syntax PrimaryExpn
	= "this"
	| "class"
	| Identifier
	| Literal
	| ArrayLiteral
	| ObjectLiteral
	| FunctionExpn
	| ("(" Expn ")")
	;
syntax Literal
	= "null"
	| "true"
	| "false"
	| NumericLiteral
	| StringLiteral
	| RegularExpnLiteral
	;
syntax NumericLiteral
	= Number
	| HexNumber
	;
syntax StringLiteral
	= StringLit
	| CharLit
	;
syntax RegularExpnLiteral
	= RegExp
	;
syntax ArrayLiteral
	= "[" {ArrayElement ","}* "]"
	;
syntax ArrayElement
	= AssignmentExpn?
	;
syntax ObjectLiteral
	= "{" {PropertyAssignment ","}* ","? "}"
	;
syntax PropertyAssignment
	= (PropertyName ":" Expn)
	| ("get" PropertyName "(" ")" "{" Subscope "}")
	| ("set" PropertyName "(" PropertySetParameter ")" "{" Subscope "}")
	;
syntax PropertyName
	= Identifier
	| StringLiteral
	| Number
	;
syntax PropertySetParameter
	= Identifier
	;
syntax Statement
	= (CompoundStatement ";"?)
	| (ExpressionStatement ";"?)
	| (IfStatement ";"?)
	| (ForStatement ";"?)
	| (WhileStatement ";"?)
	| (BreakStatement ";"?)
	| (ContinueStatement ";"?)
	| (ReturnStatement ";"?)
	| (WithStatement ";"?)
	| (SwitchStatement ";"?)
	| (DoStatement ";"?)
	| (TryCatchStatement ";"?)
	| (ThrowStatement ";"?)
	| (DebuggerStatement ";"?)
	| EmptyStatement
	;
syntax EmptyStatement
	= ";"
	;
syntax CompoundStatement
	= "{" Subscope "}"
	;
syntax ExpressionStatement
	= Expn
	;
syntax IfStatement
	= "if" "(" Expn ")" DeclarationOrStatement ElseClause?
	;
syntax ElseClause
	= "else" DeclarationOrStatement
	;
syntax ForStatement
	= ("for" "(" {DeclarationOrStatementNoNl ","}* ";" Expn? ";" Expn? ")" Statement)
	| ("for" "each"? "(" DeclarationOrStatementNoNl "in" Expn ")" Statement)
	;
syntax DeclarationOrStatementNoNl
	= Declaration
	| Statement
	;
syntax WhileStatement
	= "while" "(" Expn ")" Statement
	;
syntax BreakStatement
	= "break" Identifier?
	;
syntax ContinueStatement
	= "continue" Identifier?
	;
syntax ReturnStatement
	= "return" Expn?
	;
syntax WithStatement
	= "with" "(" Expn ")" Statement
	;
syntax SwitchStatement
	= "switch" "(" Expn ")" "{" CaseClause* "}"
	;
syntax CaseClause
	= CaseClauseValue Subscope
	;
syntax CaseClauseValue
	= ("case" Expn ":")
	| ("default" ":")
	;
syntax DoStatement
	= "do" Statement "while" "(" Expn ")"
	;
syntax TryCatchStatement
	= "try" CompoundStatement CatchClause? FinallyClause?
	;
syntax CatchClause
	= "catch" "(" Identifier ")" CompoundStatement
	;
syntax FinallyClause
	= "finally" CompoundStatement
	;
syntax ThrowStatement
	= "throw" Expn
	;
syntax DebuggerStatement
	= "debugger"
	;
