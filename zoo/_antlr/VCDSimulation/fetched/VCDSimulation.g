tree grammar VCDSimulation;

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
         myvar={'code':$id_code.text,'ref':$ref.text,'scope':$stack};
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


simulation_command [context]
    : ^(SIM_COMMAND sim_time [context])
    | ^(SIM_COMMAND value_change [context]) 
    ;

sim_time [context]
    : ^(TIME DEC_NUM)
        {
            context.note_time(int($DEC_NUM.text))
        }
    ;

value_change [context]
    : ^(SCALAR_CHANGE id=IDENTIFIER v=SCALAR_VALUE)
        {
            context.scalar_change($id.text, $v.text)
        }
    | ^(VECTOR_CHANGE id=IDENTIFIER BINVEC)
        {
            context.vector_change($id.text, $BINVEC.text)
        }
    ;

