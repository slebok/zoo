tree grammar InterpretVCDHeader;

options {
    language=Python;
    tokenVocab=ValueChangeDump;
    ASTLabelType=CommonTree;
}

@init {
    self.vars={};
    self.empty=[];
}

vcd_header returns [result]: ^(HEADER decl_command_list[stack=self.empty])
        {$result=self.vars}
    ;

decl_command_list [stack]
    :  ^(DECLS decl_command[stack=stack]+)
    ;

decl_command [stack]
    : ^(TIMESCALE DEC_NUM TIME_UNIT)
    | ^(NEWVAR type=. size=DEC_NUM id_code=IDENTIFIER ref=IDENTIFIER)
        {
         myvar={'code':$id_code.text,'ref':$ref.text,'scope':$stack,'size':int($size.text)};
         self.vars[$id_code.text]=myvar;
        }
    | vcd_scope[stack=stack]
    ;

vcd_decl_timescale
    :  ^(TIMESCALE DEC_NUM TIME_UNIT)
    ;

vcd_scope [stack]
    :  ^(NEWSCOPE vcd_decl_scope decl_command_list[stack=stack+list(($vcd_decl_scope.label,))])
    ;

vcd_decl_scope returns [label]
    : ^(DECLSCOPE type=. IDENTIFIER)
        {$label=$IDENTIFIER.text}   
    ;

