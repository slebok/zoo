header {
//The MIT License
//
//Copyright (c) 2006-2010  Karl W. Pfalzer
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
package parser.v2k;
import  parser.v2k.tree.*;
}

class VlogParser extends Parser;
options {
	k=2;
}

//A.1.2 Verilog source text
source_text
:	(description)*
	EOF
;

description
{ ModuleDeclaration mdecl=null;}
:	mdecl=module_declaration	{getTree().moduleDeclaration(mdecl);}
//TODO| 	udp_declaration
//TODO| 	config_declaration
;

module_declaration returns [ModuleDeclaration mdecl]
{	mdecl=null; ModuleIdent mid=null; ListOf<ParameterDeclaration> lopd=null;
	ListOf<PortDeclaration> lports=null; 
	NonPortModuleItem npmi=null; ListOf<Port> lop=null;
	ModuleItem mi=null;
	boolean isAnsi=false;
}
: 	(attribute_instance)* 
		module_keyword mid=module_identifier 
			{getTree().addSymbol(mid);}
		(lopd=module_parameter_port_list)? 
			{mdecl = getTree().moduleDeclaration(mid,lopd);}
		(	
		 	((list_of_port_declarations)?)=>
		 		(lports=list_of_port_declarations)? SEMI {isAnsi=true;}
						{getTree().moduleDeclaration(mdecl,isAnsi,lports);}
					(npmi=non_port_module_item
						{getTree().moduleDeclaration(mdecl,npmi);}
					)*
		|	lop=list_of_ports SEMI 
					{getTree().moduleDeclaration(mdecl,lop);}
				(mi=module_item {getTree().moduleDeclaration(mdecl,mi);})*
		)
		"endmodule"
			{ getTree().popScope();}
;

module_keyword
:	"module" 
| 	"macromodule"
;

//A.1.3 Module parameters and ports
module_parameter_port_list returns [ListOf<ParameterDeclaration> lopd]
{ lopd=null;}
:	POUND LPAREN 
	lopd=parameter_declarations
	RPAREN
;

parameter_declarations returns [ListOf<ParameterDeclaration> lopd]
{lopd=null; ListOf<ParameterDeclaration> pd=null;}
:	pd=parameter_declaration            {lopd=getTree().addToList(lopd,pd);}
		(COMMA pd=parameter_declaration {lopd=getTree().addToList(lopd,pd);})*
;

/**
list_of_ports
:	(LPAREN port)=> LPAREN port (COMMA port)* RPAREN
|	LPAREN RPAREN
;
**/
list_of_ports returns [ListOf<Port> lop]
{ lop=null; Port port=null;}
:	LPAREN (options {greedy=true;}: 
		port=port        {lop=getTree().addToList(lop,port);}
		(COMMA port=port {lop=getTree().addToList(lop,port);})*
		)? RPAREN
;

list_of_port_declarations returns [ListOf<PortDeclaration> lopd]
{ lopd=null; ListOf<PortDeclaration> pd=null;}
:	LPAREN (lopd=port_declaration[true]    
		(COMMA pd=port_declaration[true] {lopd=getTree().addToList(lopd,pd);} )* 
		)? RPAREN
;

/**Dont support .id(expr) style
port returns [Port port]
{ port=null; PortExpression pexpr=null; PortIdent pid=null;}
:	(	(pexpr=port_expression)?
	|	DOT pid=port_identifier LPAREN (pexpr=port_expression)? RPAREN
	)
	{ port = getTree().port(pid,pexpr);}
;
**/
port returns [Port port]
{ port=null; PortIdent pid=null;}
:	(pid=port_identifier)?
	{ port = getTree().port(pid);}
;

port_expression returns [PortExpression pexpr]
{ pexpr=null; PortReference pref=null;}
//NOTE: the LRM has 0 or >=1.  However, usage always has port_expression?
//      so we"ll let that cover 0.
:	pref=port_reference        {pexpr = getTree().portExpression(null,pref);}
|	LCURLY pref=port_reference {pexpr = getTree().portExpression(null,pref);} 
		(COMMA pref=port_reference 
			{getTree().portExpression(pexpr,pref);})* RCURLY	
;

port_reference returns [PortReference pref]
{ pref=null; PortIdent pid=null; ConstRangeExpression rexpr=null;}
:	pid=port_identifier (LBRACK (rexpr=constant_range_expression)? RBRACK)?
		{pref = getTree().portReference(pid,rexpr);}
;

//isOnlyDefn==true when defined through list_of_port_declarations
port_declaration[boolean isOnlyDefn] returns [ListOf<PortDeclaration> pd]
{ pd=null;}
:	(attribute_instance)*
		(	pd=inout_declaration[isOnlyDefn]
		|	pd=input_declaration[isOnlyDefn]
		|	pd=output_declaration[isOnlyDefn]
		)
;

module_item returns [ModuleItem mi]
{ mi=null; ListOf<PortDeclaration> pd=null; NonPortModuleItem npi=null;}
:	(port_declaration[false])=> pd=port_declaration[false] SEMI
		{mi = getTree().moduleItem(pd);}
|	npi=non_port_module_item
		{mi = getTree().moduleItem(npi);}
;

module_or_generate_item returns [ModuleOrGenerateItem mi]
{ mi=null; Object o1=null;}
:	(attribute_instance)*
	(	o1=module_or_generate_item_declaration
			{mi = getTree().moduleOrGenItem((ModuleOrGenerateItemDecl)o1);}
	|	o1=local_parameter_declaration SEMI
			{mi = getTree().moduleOrGenItemLocalParam((ListOf<LocalParameterDecl>)o1);}
	|	o1=parameter_override
			{mi = getTree().moduleOrGenItemParam((ListOf<DefparamAssign>)o1);}
	|	o1=continuous_assign
			{mi = getTree().moduleOrGenItem((ContinuousAssign)o1);}
	//TODO|	gate_instantiation
	//TODO|	udp_instantiation
	|	o1=module_instantiation
			{mi = getTree().moduleOrGenItemInst((ListOf<ModuleInstance>)o1);}
	|	o1=initial_construct
			{mi = getTree().moduleOrGenItem((InitialConstruct)o1);}
	|	o1=always_construct
			{mi = getTree().moduleOrGenItem((AlwaysConstruct)o1);}
	|	o1=loop_generate_construct
			{mi = getTree().moduleOrGenItem((LoopGenerateConstruct)o1);}
	|	o1=conditional_generate_construct
			{mi = getTree().moduleOrGenItem((ConditionalGenerateConstruct)o1);}
	)
;

module_or_generate_item_declaration returns [ModuleOrGenerateItemDecl mogd]
{ mogd=null; Object o1=null;}
:	o1=net_declaration
		{mogd = getTree().moduleOrGenItemDeclNet((ListOf<NetDeclaration>)o1);}
|	o1=reg_declaration
		{mogd = getTree().moduleOrGenItemDeclReg((ListOf<RegDecl>)o1);}
|	o1=integer_declaration
		{mogd = getTree().moduleOrGenItemDeclInt((ListOf<IntegerDecl>)o1);}
|	o1=real_declaration
		{mogd = getTree().moduleOrGenItemDeclReal((ListOf<RealDecl>)o1);}
|	o1=time_declaration
		{mogd = getTree().moduleOrGenItemDeclTime((ListOf<TimeDecl>)o1);}
|	o1=realtime_declaration
		{mogd = getTree().moduleOrGenItemDeclRealtime((ListOf<RealtimeDecl>)o1);}
|	o1=event_declaration
		{mogd = getTree().moduleOrGenItemDeclEvent((ListOf<EventDecl>)o1);}
|	o1=genvar_declaration
		{mogd = getTree().moduleOrGenItemDeclGenvar((ListOf<GenvarIdent>)o1);}
|	o1=task_declaration
		{mogd = getTree().moduleOrGenItemDecl((TaskDeclaration)o1);}
|	o1=function_declaration
		{mogd = getTree().moduleOrGenItemDecl((FuncDecl)o1);}
;

non_port_module_item returns [NonPortModuleItem npmi]
{ npmi=null; Object o1=null;}
:	(module_or_generate_item)=> o1=module_or_generate_item
		{npmi = getTree().nonPortModuleItem((ModuleOrGenerateItem)o1);}
|	o1=generate_region
		{npmi = getTree().nonPortModuleItem((ListOf<ModuleOrGenerateItem>)o1);}
| 	(attribute_instance)* 
		(	o1=parameter_declaration SEMI
				{npmi = getTree().nonPortModuleItemParms((ListOf<ParameterDeclaration>)o1);}
		| 	o1=specparam_declaration
				{npmi = getTree().nonPortModuleItem((SpecparamDecl)o1);}
		)
;

parameter_override returns [ListOf<DefparamAssign> lopa]
{lopa=null;}
:	"defparam" lopa=list_of_defparam_assignments SEMI
;

//A.1.5 Configuration source text
//TODO

//A.2 Declarations
//A.2.1 Declaration types
//A.2.1.1 Module parameter declarations
local_parameter_declaration returns [ListOf<LocalParameterDecl> lpd]
{ lpd=null; Location isSigned=null; Range rng=null; 
  ListOf<ParamAssign> lopa=null; ParameterType pt=null;
}
:	(	"localparam" ("signed" {isSigned=Location.getCurrent();})? (rng=range)? 
			lopa=list_of_param_assignments
	|	"localparam" pt=parameter_type lopa=list_of_param_assignments
	)
	{ lpd = getTree().localParameterDecl(isSigned,rng,pt,lopa);}
;

parameter_declaration returns [ListOf<ParameterDeclaration> pd]
{ pd=null; Location isSigned=null; Range rng=null; 
  ListOf<ParamAssign> lopa=null; ParameterType pt=null;
}
:	(	"parameter" ("signed" {isSigned=Location.getCurrent();})? (rng=range)? 
			lopa=list_of_param_assignments
	|	"parameter" pt=parameter_type lopa=list_of_param_assignments
	)
	{ pd = getTree().parameterDecl(isSigned,rng,pt,lopa);}
;

specparam_declaration returns [SpecparamDecl spd]
{ spd=null; Range rng=null; ListOf<SpecparamAssign> spa=null; }
:	"specparam" (rng=range)? spa=list_of_specparam_assignments SEMI
	{ spd = getTree().specparamDecl(rng,spa);}
;

parameter_type returns [ParameterType pt]
{ pt = getTree().parameterType(LA(1));}
:	"integer"
|	"real"
|	"realtime"
|	"time"
;

//A.2.1.2 Port declarations
inout_declaration[boolean isOnlyDefn] returns [ListOf<PortDeclaration> pd]
{ pd=null; int dir=LA(1); NetType type=null; Range rng=null;
  Location isSigned=null; PortDirection pdir=null;
  ListOf<? extends PortIdent> ids = null;
}
:	"inout" {pdir=new PortDirection(dir);}
		(type=net_type)? ("signed" {isSigned=Location.getCurrent();})? 
		(rng=range)? ids=list_of_port_identifiers
	{ pd = getTree().portDecl(isOnlyDefn,pdir,type,rng,null,null,isSigned,ids);}
;

input_declaration[boolean isOnlyDefn] returns [ListOf<PortDeclaration> pd]
{ pd=null; int dir=LA(1); NetType type=null; Range rng=null;
  Location isSigned=null; PortDirection pdir=null;
  ListOf<? extends PortIdent> ids = null;
}
:	"input" {pdir=new PortDirection(dir);}
		(type=net_type)? ("signed" {isSigned=Location.getCurrent();})? 
		(rng=range)? ids=list_of_port_identifiers
	{ pd = getTree().portDecl(isOnlyDefn,pdir,type,rng,null,null,isSigned,ids);}
;

output_declaration[boolean isOnlyDefn] returns [ListOf<PortDeclaration> pd]
{ pd=null; int dir=LA(1); NetType type=null; Range rng=null;
  Location isSigned=null, isReg=null; PortDirection pdir=null;
  ListOf<? extends PortIdent> ids = null; OutputVarType ovt=null;
}
:	(	("output" output_variable_type)=> 
			"output" {pdir=new PortDirection(dir);} ovt=output_variable_type 
			ids=list_of_variable_port_identifiers
	|	("output" ("reg")? ("signed")? (range)? 
				list_of_variable_port_identifiers)=>
			"output" {pdir=new PortDirection(dir);} 
				("reg" {isReg=Location.getCurrent();})? ("signed" {isSigned=Location.getCurrent();})? 
				(rng=range)? ids=list_of_variable_port_identifiers
	|	"output" {pdir=new PortDirection(dir);} 
			(type=net_type)? ("signed" {isSigned=Location.getCurrent();})? (rng=range)? 
			ids=list_of_port_identifiers
	)
	{ pd = getTree().portDecl(isOnlyDefn,pdir,type,rng,ovt,isReg,isSigned,ids);}
;

//A.2.1.3 Type declarations
event_declaration returns [ListOf<EventDecl> ed]
{ ed=null; ListOf<EventIdentifiers> loei=null;}
:	"event" loei=list_of_event_identifiers SEMI
		{ed = getTree().eventDecl(loei);}
;

integer_declaration returns [ListOf<IntegerDecl> intd]
{ intd=null; ListOf<VariableType> lovt=null;}
:	"integer" lovt=list_of_variable_identifiers SEMI
	{ intd = getTree().integerDecl(lovt);}
;

//NOTE: greatly simplified
net_declaration returns [ListOf<NetDeclaration> nd]
{ nd=null; NetType type=null; Location isSigned=null; Range rng=null;
  Delay3 del3=null; ListOf<NetIdentifiers> nets=null; 
  ListOf<NetDeclAssign> decls=null;
}
:	type=net_type ("vectored" | "scalared")? ("signed" {isSigned=Location.getCurrent();})? 
		(rng=range)? (del3=delay3)?
		(	nets=list_of_net_identifiers
		|	decls=list_of_net_decl_assignments
		)
		SEMI
	{nd=getTree().netDeclaration(type,isSigned,rng,del3,nets,decls);}
;

real_declaration returns [ListOf<RealDecl> rd]
{ rd=null; ListOf<RealType> lort=null;}
:	"real" lort=list_of_real_identifiers SEMI
		{rd=getTree().realDecl(lort);}
;

realtime_declaration returns [ListOf<RealtimeDecl> rtd]
{ rtd=null; ListOf<RealType> lort=null;}
:	"realtime" lort=list_of_real_identifiers SEMI
		{rtd=getTree().realtimeDecl(lort);}
;

reg_declaration returns [ListOf<RegDecl> rd]
{ rd=null; Location isSigned=null, loc=null; Range rng=null; 
  ListOf<VariableType> vid=null;}
:	"reg" {loc=Location.getCurrent();} ("signed" {isSigned=Location.getCurrent();})? (rng=range)? 
		vid=list_of_variable_identifiers SEMI
			{rd=getTree().regDecl(loc,isSigned,rng,vid);}
;

time_declaration returns [ListOf<TimeDecl> td]
{ td=null; ListOf<VariableType> vid=null; }
:	"time" vid=list_of_variable_identifiers SEMI
		{td = getTree().timeDecl(vid);}
;

//A.2.2 Declaration data types
//A.2.2.1 Net and variable types
net_type returns [NetType nt]
{ nt=null; int type=LA(1); nt = getTree().netType(type);}
:	"supply0" 
|	"supply1"
|	"tri"
|	"triand"
|	"trior"
|	"tri0"
|	"tri1"
|	"uwire"
|	"wire"
|	"wand"
|	"wor"
;

output_variable_type returns [OutputVarType ovt]
{ ovt=null; int type=LA(1); ovt = getTree().outputVarType(type);}
:	"integer"
|	"time"
;

real_type returns [RealType rt]
{ rt=null; RealIdent id=null; 
  Dimension dim=null; ListOf<Dimension> lod=null; 
  ConstExpression expr=null;}
:	(	id=real_identifier 
			(dim=dimension {lod = getTree().addToList(lod, dim);} )*
	| 	id=real_identifier ASSIGN expr=constant_expression
	)
	{ rt = getTree().realType(id,lod,expr);}
;

variable_type returns [VariableType vt]
{ vt=null; VariableIdent id=null; 
  Dimension dim=null; ListOf<Dimension> lod=null; 
  ConstExpression expr=null;}
:	(	id=variable_identifier 
			(dim=dimension {lod = getTree().addToList(lod, dim);} )*
	| 	id=variable_identifier ASSIGN expr=constant_expression
	)
	{ vt = getTree().varType(id,lod,expr);}
;

//SKIP: A.2.2.2 Strengths

//A.2.2.3 Delays
delay3 returns [Delay3 d3]
{ d3=null; ListOf<DelayValue> lo=null; DelayValue dv=null;}
:	(	POUND dv=delay_value         {lo = getTree().addToList(lo, dv);}
	|	POUND LPAREN (dv=delay_value {lo = getTree().addToList(lo, dv);} 
			   (COMMA dv=delay_value {getTree().addToList(lo, dv);} )*) 
			   RPAREN
	)
	{d3 = getTree().delay3(lo);}
;
	
delay2 returns [Delay2 d2]
{ d2=null; Delay3 d3=null; }
:	d3=delay3 {d2 = getTree().delay2(d3); }
;

delay_value returns [DelayValue dv]
{ dv=null; Vnumber n=null; Ident id=null;}
:	n=number		{dv = getTree().delayValue(n);}
|	id=identifier	{dv = getTree().delayValue(id);}
;

//A.2.3 Declaration lists
list_of_defparam_assignments returns [ListOf<DefparamAssign> loda]
{ loda=null; DefparamAssign da=null;}
:	da=defparam_assignment            {loda=getTree().addToList(loda,da);}
		(COMMA da=defparam_assignment {loda=getTree().addToList(loda,da);} )*
;

list_of_event_identifiers returns [ListOf<EventIdentifiers> loei]
{ loei=null; EventIdentifiers ei=null;}
:	ei=event_identifiers            {loei=getTree().addToList(loei,ei);}
		(COMMA ei=event_identifiers {loei=getTree().addToList(loei,ei);} )*
;

event_identifiers returns [EventIdentifiers eis]
{ eis=null; EventIdent ei=null; Dimension dim=null;}
:	ei=event_identifier	{eis=getTree().eventIdentifiers(null,ei,null);}
		(dim=dimension  {eis=getTree().eventIdentifiers(eis,null,dim);} )*
;

list_of_net_decl_assignments returns [ListOf<NetDeclAssign>	loda]
{ loda=null; NetDeclAssign nda=null;}
:	nda=net_decl_assignment            {loda=getTree().addToList(loda,nda);}
		(COMMA nda=net_decl_assignment {loda=getTree().addToList(loda,nda);} )*
;

list_of_net_identifiers returns [ListOf<NetIdentifiers> loni]
{ loni=null; NetIdentifiers ni=null;}
:	ni=net_identifiers            {loni=getTree().addToList(loni,ni);}
		(COMMA ni=net_identifiers {loni=getTree().addToList(loni,ni);} )*
;

net_identifiers returns [NetIdentifiers nis]
{ nis=null; NetIdent ni=null; Dimension dim=null;}
:	ni=net_identifier 	{nis=getTree().netIdentifiers(null,ni,null);}
		(dim=dimension  {nis=getTree().netIdentifiers(nis,null,dim);} )*
;

list_of_param_assignments returns [ListOf<ParamAssign> lopa]
{ lopa=null; ParamAssign pa=null;}
:	pa=param_assignment 			  {lopa=getTree().addToList(lopa,pa);}
		(options{greedy=true;}: 
			COMMA pa=param_assignment {lopa=getTree().addToList(lopa,pa);})*
;

list_of_port_identifiers returns [ListOf<PortIdent> lop]
{ lop=null; PortIdent pi=null;}
:	pi=port_identifier {lop = getTree().addToList(lop,pi);}
		(options{greedy=true;}: COMMA pi=port_identifier
			{lop = getTree().addToList(lop,pi);}
		)*
;

list_of_real_identifiers returns [ListOf<RealType> lort]
{ lort=null; RealType rt=null;}
:	rt=real_type            {lort=getTree().addToList(lort,rt);}
		(COMMA rt=real_type {lort=getTree().addToList(lort,rt);} )*
;

list_of_specparam_assignments returns [ListOf<SpecparamAssign> spa]
{ spa=null; SpecparamAssign sa=null; }
:	sa=specparam_assignment            {spa=getTree().addToList(spa,sa);}
		(COMMA sa=specparam_assignment {spa=getTree().addToList(spa,sa);} )*
;

list_of_variable_identifiers returns [ListOf<VariableType> lovt]
{ lovt=null; VariableType vt=null; }
:	vt=variable_type	        {lovt = getTree().addToList(lovt,vt);} 
		(COMMA vt=variable_type {lovt = getTree().addToList(lovt,vt);} )*
;

list_of_variable_port_identifiers returns [ListOf<PortIdents> lopi]
{ lopi=null; PortIdents pis=null;}
:	pis=port_identifiers  {lopi=getTree().addToList(lopi,pis);}
		(options{greedy=true;}: COMMA 
		pis=port_identifiers {lopi=getTree().addToList(lopi,pis);} )*
;

port_identifiers returns [PortIdents pis]
{ pis=null; PortIdent id=null; ConstExpression expr=null;}
:	id=port_identifier (ASSIGN expr=constant_expression)?
		{pis = getTree().portIdents(id, expr);}
;

//A.2.4 Declaration assignments
defparam_assignment returns [DefparamAssign dpa]
{ dpa=null; HierParameterIdent hpi=null; ConstMinTypMaxExpression mtm=null;}
:	hpi=hierarchical_parameter_identifier ASSIGN 
		mtm=constant_mintypmax_expression
			{dpa = getTree().defparamAssign(hpi,mtm);}
;

net_decl_assignment returns [NetDeclAssign nda]
{ nda=null; NetIdent id=null; Expression exp=null;}
:	id=net_identifier ASSIGN exp=expression
		{nda = getTree().netDeclAssign(id,exp);}
;

param_assignment returns [ParamAssign pa]
{ pa=null; ParameterIdent id=null; ConstMinTypMaxExpression mtm=null;}
:	id=parameter_identifier ASSIGN mtm=constant_mintypmax_expression
		{pa = getTree().paramAssign(id,mtm);}
;

specparam_assignment returns [SpecparamAssign spa]
{ spa=null; SpecparamIdent id=null; ConstMinTypMaxExpression mtm=null;}
:	id=specparam_identifier ASSIGN mtm=constant_mintypmax_expression
		{spa = getTree().specparamAssign(id,mtm);}
//TODO| pulse_control_specparam
;

//A.2.5 Declaration ranges
//NOTE: dimension usage appears as (dimension)?* so we"ll skip the optional here
dimension returns [Dimension dim]
{ dim=null; ConstExpression msb=null, lsb=null;}
:	LBRACK msb=dimension_constant_expression 
		COLON lsb=dimension_constant_expression RBRACK
			{dim = getTree().dimension(msb,lsb);}
;

//NOTE: range usage appears as (range)?* so we"ll skip the optional here
range returns [Range rng]
{ rng=null; ConstExpression msb=null, lsb=null;}
:	LBRACK msb=msb_constant_expression COLON lsb=lsb_constant_expression RBRACK
		{rng = getTree().range(msb,lsb);}
;

//A.2.6 Function declarations
function_declaration returns [FuncDecl fd]
{fd=null; boolean isAuto=false; FuncType ft=null; FuncIdent id=null;
	FuncItemDecl fid=null; ListOf<FuncItemDecl> lofid=null;
	ListOf<TfPortDeclaration> lop=null; 
	BlockItemDecl bid=null; ListOf<BlockItemDecl> lobid=null;
	FuncStatement stmt=null;
}
:	"function" ("automatic" {isAuto=true;})? 
		(ft=function_range_or_type)? id=function_identifier 
			{getTree().addSymbol(id);}
		(	SEMI (fid=function_item_declaration 
					{lofid=getTree().addToList(lofid,fid);})+
		| 	LPAREN lop=function_port_list RPAREN SEMI 
				(bid=block_item_declaration 
					{lobid=getTree().addToList(lobid,bid);}
				)*
		)
		stmt=function_statement "endfunction"
			{	fd = getTree().funcDecl(isAuto,ft,id,lofid,lop,lobid,stmt);
			 	getTree().popScope();
			}
;

function_item_declaration returns [FuncItemDecl fid]
{ fid=null; TfPortDeclaration tpd=null; BlockItemDecl bid=null;}
: 	(	((attribute_instance)* tf_input_declaration)=>
	 		(attribute_instance)* tpd=tf_input_declaration SEMI
	|	bid=block_item_declaration
	)
	{ fid = getTree().funcItemDecl(tpd,bid);}
;

function_port_list returns [ListOf<TfPortDeclaration> lop]
{ lop=null; TfPortDeclaration tpd=null;}
:	(attribute_instance)* tpd=tf_input_declaration 
			{lop = getTree().addToList(lop,tpd);}
		(COMMA (attribute_instance)* tpd=tf_input_declaration
			{getTree().addToList(lop,tpd);}
		)*
;

function_range_or_type returns [FuncType ft]
{ ft=null; int tok=LA(1); Range rng=null;}
:	(	("signed")? {tok=-1;} (rng=range)?
	|	"integer"
	|	"real"
	|	"realtime"
	|	"time"
	)
	{ft = getTree().funcType(tok, rng);}
;

//A.2.7 Task declarations
task_declaration returns [TaskDeclaration td]
{ td=null; TaskIdent id=null; boolean isAuto=false;
  TaskItemDecl tid=null; BlockItemDecl bid=null;
  ListOf<TfPortDeclaration> lop=null; Statement st=null;
}
:	"task" ("automatic" {isAuto=true;})? id=task_identifier 
				{	getTree().addSymbol(id);
					td = getTree().taskDecl(isAuto, id);
				}
		( 	SEMI 
				(options {greedy=true;}: tid=task_item_declaration
					{getTree().taskDecl(td, tid);}
				)*
		|	LPAREN (lop=task_port_list {getTree().taskDecl(td,lop);})? 
				RPAREN SEMI 
				(options {greedy=true;}: bid=block_item_declaration
					{getTree().taskDecl(td, bid);}
				)*
		)
		st=statement_or_null
			{getTree().taskDecl(td, st);}
		"endtask"
		 	{getTree().popScope();}
;

task_item_declaration returns [TaskItemDecl tid]
{ tid=null; BlockItemDecl bid=null; TfPortDeclaration tpd=null;}
:	(block_item_declaration)=> bid=block_item_declaration
		{tid = getTree().taskItemDecl(bid,null);}
|	(attribute_instance)*
		(	tpd=tf_input_declaration SEMI
		|	tpd=tf_output_declaration SEMI
		|	tpd=tf_inout_declaration SEMI
		)
		{tid = getTree().taskItemDecl(null,tpd);}
;

task_port_list returns [ListOf<TfPortDeclaration> lop]
{ lop=null; TfPortDeclaration tpd=null;}
:	tpd=task_port_item  {lop = getTree().addToList(lop,tpd);}
		(COMMA tpd=task_port_item {lop = getTree().addToList(lop,tpd);} )*
;

task_port_item returns [TfPortDeclaration tpd]
{ tpd=null;}
:	(attribute_instance)*
		(	tpd=tf_input_declaration
		|	tpd=tf_output_declaration
		|	tpd=tf_inout_declaration
		)
;

tf_inout_declaration returns [TfPortDeclaration tfp]
{ tfp=null; int dir=LA(1); TaskPortType tpt=null; ListOf<PortIdent> lop=null;
  PortDirection pdir=null;}
:	"inout" {pdir=new PortDirection(dir);} 
		tpt=task_port_type lop=list_of_port_identifiers
		{tfp = getTree().tfPortDecl(pdir, tpt, lop);}
;

tf_input_declaration returns [TfPortDeclaration tfp]
{ tfp=null; int dir=LA(1); TaskPortType tpt=null; ListOf<PortIdent> lop=null;
  PortDirection pdir=null;}
:	"input" {pdir=new PortDirection(dir);} 
		tpt=task_port_type lop=list_of_port_identifiers
		{tfp = getTree().tfPortDecl(pdir, tpt, lop);}
;

tf_output_declaration returns [TfPortDeclaration tfp]
{ tfp=null; int dir=LA(1); TaskPortType tpt=null; ListOf<PortIdent> lop=null;
  PortDirection pdir=null;}
:	"output" {pdir=new PortDirection(dir);} 
		tpt=task_port_type lop=list_of_port_identifiers
		{tfp = getTree().tfPortDecl(pdir, tpt, lop);}
;

task_port_type returns [TaskPortType tpt]
{ tpt=null; int la=LA(1); Location isReg=null;
  Location isSigned=null; Range rng=null;
}
:	(	"integer"
	|	"real"
	|	"realtime"
	|	"time"
	)	{tpt = getTree().taskPortType(la);}
|	("reg" {isReg=Location.getCurrent();})? ("signed" {isSigned=Location.getCurrent();})? (rng=range)?
		{tpt = getTree().taskPortType(isReg, isSigned, rng);}
;

//A.2.8 Block item declarations
block_item_declaration returns [BlockItemDecl bid] //TODO
{ bid=null; int la=LA(1); Location isSigned=null; Range rng=null;
  ListOf<BlockVariableType> lov=null; ListOf<BlockRealType> lor=null;
  ListOf<EventDecl> ed=null; ListOf<? extends ParameterDeclaration> pd=null;
}
: 	(attribute_instance)* 
	(	"reg" ("signed" {isSigned=Location.getCurrent();})? 
			(rng=range)? lov=list_of_block_variable_identifiers SEMI
				{bid = getTree().blockItemDecl(isSigned, rng, lov);}
	|	"integer" lov=list_of_block_variable_identifiers SEMI
			{bid = getTree().blockItemDecl(la, lov);}
	|	"time" lov=list_of_block_variable_identifiers SEMI
			{bid = getTree().blockItemDecl(la, lov);}
	|	"real" lor=list_of_block_real_identifiers SEMI
			{bid = getTree().blockItemDecl(la, lor, true);}
	|	"realtime" lor=list_of_block_real_identifiers SEMI
			{bid = getTree().blockItemDecl(la, lor, true);}
	|	ed=event_declaration
			{bid = getTree().blockItemDeclEvent(ed);}
	|	pd=local_parameter_declaration SEMI
			{bid = getTree().blockItemDecl(pd);}
	|	pd=parameter_declaration SEMI
			{bid = getTree().blockItemDecl(pd);}
	)
;

list_of_block_variable_identifiers returns [ListOf<BlockVariableType> lob]
{ lob=null; BlockVariableType bvt=null;}
:	bvt=block_variable_type            {lob = getTree().addToList(lob,bvt);}
		(COMMA bvt=block_variable_type {lob = getTree().addToList(lob,bvt);} )*
;

list_of_block_real_identifiers returns [ListOf<BlockRealType> lob]
{ lob=null; BlockRealType brt=null;}
:	brt=block_real_type            {lob = getTree().addToList(lob,brt);}
		(COMMA brt=block_real_type {lob = getTree().addToList(lob,brt);} )*
;

block_variable_type returns [BlockVariableType bvt]
{ bvt=null; VariableIdent id=null; Dimension dim=null; 
	ListOf<Dimension> lod=null;
}
:	id=variable_identifier (dim=dimension {lod=getTree().addToList(lod,dim);} )*
		{bvt = getTree().blockVariableType(id,lod);}			
;

block_real_type returns [BlockRealType brt]
{ brt=null; RealIdent id=null; Dimension dim=null; ListOf<Dimension> lod=null;}
:	id=real_identifier (dim=dimension {lod=getTree().addToList(lod,dim);} )*
		{brt = getTree().blockRealType(id,lod);}			
;

//SKIP altogether: A.3 Primitive instances

//A.4 Module instantiation and generate construct
//A.4.1 Module instantiation
module_instantiation returns [ListOf<ModuleInstance> lom]
{	lom=null; Ident refNm = null; ParameterValueAssignment pva=null;
	ModuleInstance mi=null;
}
:	refNm=module_identifier
		//Deal w/ ambiguity of #delay and #(delay,...) by catching latter
		//in pva.
		//TODO: throw out delays for now.
		//TODO: does not catch case of #(delay,...) #(params)
		(	(POUND delay_value)=> POUND delay_value
		|	pva=parameter_value_assignment	//also catches delay3
		)?
		mi=module_instance 	   
			{lom = getTree().moduleInstantiation(lom,refNm,pva,mi);}
		(COMMA mi=module_instance
			{lom = getTree().moduleInstantiation(lom,refNm,pva,mi);}
		)* 
		SEMI
;

parameter_value_assignment returns [ParameterValueAssignment pva]
{ pva=null; ListOf<ParameterAssignment> lopa=null;}
:	POUND LPAREN lopa=list_of_parameter_assignments RPAREN
		{pva = getTree().parameterValueAssignment(lopa);}
;

list_of_parameter_assignments returns [ListOf<ParameterAssignment> lopa]
{ lopa=null; Expression exp=null; NamedParamAssignment npa=null;}
:	exp=ordered_parameter_assignment 
			{lopa = getTree().listOfParamAssigns(lopa,exp,null);}
		(COMMA exp=ordered_parameter_assignment
			{getTree().listOfParamAssigns(lopa,exp,null);}
		)* 
|	npa=named_parameter_assignment 
			{lopa = getTree().listOfParamAssigns(lopa,null,npa);}
		(COMMA npa=named_parameter_assignment
			{getTree().listOfParamAssigns(lopa,null,npa);}
		)*
;

ordered_parameter_assignment returns [Expression exp]
{ exp=null;}
:	exp=expression
;

named_parameter_assignment returns [NamedParamAssignment npa]
{ npa=null; ParameterIdent id=null; MinTypMaxExpression exp=null;}
:	DOT id=parameter_identifier LPAREN (exp=mintypmax_expression)? RPAREN
		{npa = getTree().namedParameterAssignment(id,exp);}
;

module_instance returns [ModuleInstance inst]
{ inst=null; ListOf<PortConnection> lopc=null;}
:		{inst = getTree().moduleInstance();}	
	name_of_module_instance[inst] LPAREN 
	(options{greedy=true;}: lopc=list_of_port_connections)? RPAREN
		{getTree().moduleInstance(inst,lopc);}
;

name_of_module_instance [ModuleInstance inst]
{	ModuleInstanceIdent nm=null; Range rng=null;}
:	(nm=module_instance_identifier (rng=range)?)?
		{getTree().moduleInstance(inst, nm, rng);}
;

list_of_port_connections returns [ListOf<PortConnection> lopc]
{ lopc=null; Expression exp=null; NamedPortConnection npc=null;}
:	(ordered_port_connection)=>	
		exp=ordered_port_connection 
				{lopc = getTree().listOfPortConnections(lopc, exp, null);}
			(COMMA exp=ordered_port_connection
				{lopc = getTree().listOfPortConnections(lopc, exp, null);}
			)*
|	npc=named_port_connection 
				{lopc = getTree().listOfPortConnections(lopc, null, npc);}
			(COMMA npc=named_port_connection
				{lopc = getTree().listOfPortConnections(lopc, null, npc);}
			)*
;

ordered_port_connection returns [Expression exp]
{ exp=null;}
:	(attribute_instance)* (exp=expression)?
;

named_port_connection returns [NamedPortConnection npc]
{ npc=null; PortIdent pi=null; Expression exp=null;}
:	(attribute_instance)* DOT pi=port_identifier 
		(LPAREN (exp=expression)? RPAREN)?
			{npc = getTree().namedPortConnection(pi, exp);}
;

//A.4.2 Generate construct
generate_region returns [ListOf<ModuleOrGenerateItem> loi]
{ loi=null; ModuleOrGenerateItem mi=null; }
:	"generate" 
		//TODO: was: (mi=module_or_generate_item {loi = getTree().addToList(loi, mi);})* 
		(generate_block)*  //TODO: hoist return returns [GenerateBlock gb]
		"endgenerate"
;

genvar_declaration returns [ListOf<GenvarIdent> loi]
{ loi=null;}
:	"genvar" loi=list_of_genvar_identifiers SEMI
;

list_of_genvar_identifiers returns [ListOf<GenvarIdent> loi]
{ loi=null; GenvarIdent id=null;}
:	id=genvar_identifier            {loi = getTree().addToList(loi, id);}
		(COMMA id=genvar_identifier {getTree().addToList(loi, id);} )*
;

loop_generate_construct returns [LoopGenerateConstruct lgc]
{ lgc=null; GenvarInit init=null; GenvarExpression test=null;
  GenvarIteration iter=null; GenerateBlock blk=null;}
:	"for" LPAREN init=genvar_initialization SEMI test=genvar_expression 
		SEMI iter=genvar_iteration RPAREN blk=generate_block
			{lgc = getTree().loopGenerateConstruct(init,test,iter,blk);}
;

genvar_initialization returns [GenvarInit gi]
{ gi=null; GenvarIdent lhs=null; ConstExpression rhs=null;}
:	lhs=genvar_identifier ASSIGN rhs=constant_expression
		{gi = getTree().genvarInit(lhs,rhs);}
;

/**REMOVE LEFT RECURSION
genvar_expression
:	genvar_primary
| 	unary_operator (attribute_instance)* genvar_primary
| 	genvar_expression binary_operator (attribute_instance)* genvar_expression
| 	genvar_expression QMARK (attribute_instance)* 
		genvar_expression COLON genvar_expression
;
**/
genvar_expression returns [GenvarExpression ge]	//TODO
{ ge=null; Object e1=null, e2=null;}
:	e1=genvar_expression_1 e2=genvar_expression_2
;

genvar_expression_1 returns [Object e1]
{ e1=null; GenvarPrimary gp=null; UnaryOp uop=null;}
:	(	gp=genvar_primary
	| 	uop=unary_operator (attribute_instance)* gp=genvar_primary
	)
	{ e1 = getTree().genvarExpression(uop,gp);}
;

genvar_expression_2 returns [Object ge2]
{ ge2=null; BinaryOp bop=null; GenvarExpression gv1=null, gv2=null;
  Object e2=null; boolean isNull = false;
}
:	(options{warnWhenFollowAmbig=false;}:
		bop=binary_operator (attribute_instance)* 
			gv1=genvar_expression e2=genvar_expression_2
	|	QMARK (attribute_instance)* gv1=genvar_expression 
			COLON gv2=genvar_expression e2=genvar_expression_2
	|	/*empty*/ {isNull=true;}
	)
	{ ge2 = (isNull) ? null : getTree().genvarExpression(bop,gv1,gv2,e2);}
;


genvar_iteration returns [GenvarIteration gi]
{ gi=null; GenvarIdent gv=null; GenvarExpression ge=null;}
:	gv=genvar_identifier ASSIGN ge=genvar_expression
		{gi = getTree().genvarIteration(gv,ge);}
;

genvar_primary returns [GenvarPrimary gp]
{ gp=null; ConstPrimary cp=null; GenvarIdent gi=null;}
:	(	(constant_primary)=> cp=constant_primary
	| 	gi=genvar_identifier
	)
	{gp = getTree().genvarPrimary(cp,gi);}
;

conditional_generate_construct returns [ConditionalGenerateConstruct cgc]
{ cgc=null; IfGenerateConstruct igc=null; CaseGenerateConstruct cg=null;}
:	(	igc=if_generate_construct
	| 	cg=case_generate_construct
	)
	{cgc = getTree().conditionalGenerateConstruct(igc,cg);}
;

if_generate_construct returns [IfGenerateConstruct igs]
{ igs=null; ConstExpression ifExpr=null; GenerateBlock ifb=null, elb=null;}
:	"if" LPAREN ifExpr=constant_expression RPAREN ifb=generate_block_or_null
		(
			options {
				warnWhenFollowAmbig = false;
			}
			:	"else" elb=generate_block_or_null
		)?
		{ igs = getTree().ifGenerateConstruct(ifExpr, ifb, elb);}
;

case_generate_construct returns [CaseGenerateConstruct cgc]
{ cgc=null; ConstExpression ce=null; CaseGenerateItem cgi=null;}
:	"case" LPAREN ce=constant_expression RPAREN
			{cgc = getTree().caseGenerateConstruct(cgc,ce,null);}
		cgi=case_generate_item 
			{getTree().caseGenerateConstruct(cgc,null,cgi);}
		(cgi=case_generate_item 
			{getTree().caseGenerateConstruct(cgc,null,cgi);} )* 
		"endcase"
;

case_generate_item returns [CaseGenerateItem cgi]
{ cgi=null; ConstExpression ce=null; GenerateBlock gb=null;}
:	ce=constant_expression {cgi = getTree().caseGenerateItem(null,ce,null);} 
		(COMMA ce=constant_expression 
			{getTree().caseGenerateItem(cgi,ce,null);} )* 
		COLON gb=generate_block_or_null
			{getTree().caseGenerateItem(cgi,null,gb);}	
| 	"default" (COLON)? gb=generate_block_or_null
			{cgi = getTree().caseGenerateItem(null,null,gb);}	
;

generate_block returns [GenerateBlock gb]
{ gb=null; ModuleOrGenerateItem mi=null; GenerateBlockIdent bi=null;}
:	mi=module_or_generate_item	{gb = getTree().generateBlock(gb,mi);}
| 	loc1:"begin" (COLON bi=generate_block_identifier )? 
		{gb = getTree().generateBlock(bi,mi,loc1);}
		(mi=module_or_generate_item {getTree().generateBlock(gb,mi);})* 
		"end"
		{	if (null != mi) { 
				getTree().popScope();
			}
		}
;

generate_block_or_null returns [GenerateBlock gb]
{ gb=null;}
:	gb=generate_block
| 	SEMI
;

//SKIP altogether: A.5 UDP declaration and instantiation

//A.6 Behavioral statements
//A.6.1 Continuous assignment statements
continuous_assign returns [ContinuousAssign ca]
{ ca=null; Object d3=null, na=null;}
:	"assign" /*TODO(drive_strength)?*/ (d3=delay3)? 
		na=list_of_net_assignments SEMI
			{ca = getTree().continuousAssign(d3, na);}
;

list_of_net_assignments returns [ListOf<NetAssign> lo]
{ lo=null; NetAssign na=null;}
:	na=net_assignment 		 {lo = getTree().addToList(lo, na);}
	(COMMA na=net_assignment {getTree().addToList(lo, na);} )*
;

net_assignment returns [NetAssign na]
{ na=null; Lvalue lv=null;  Expression exp=null;}
:	lv=lvalue ASSIGN exp=expression
		{na = getTree().netAssignment(lv,exp);}
;

//A.6.2 Procedural blocks and assignments
initial_construct returns [InitialConstruct inc]
{ inc=null; Statement st=null;}
:	"initial" st=statement
		{inc = getTree().initialConstruct(st);}
;

always_construct returns [AlwaysConstruct awc]
{ awc=null; Statement st=null;}
:	"always" st=statement
		{awc = getTree().alwaysConstruct(st);}
;

blocking_assignment returns [BlockingAssign ba]
{ ba=null; Lvalue lv=null; DelayOrEventControl dec=null; Expression exp=null;}
:	lv=lvalue ASSIGN (dec=delay_or_event_control)? exp=expression
		{ba = getTree().blockingAssignment(lv,dec,exp);}
;

nonblocking_assignment returns [NonBlockingAssign nba]
{ nba=null; Lvalue lv=null; DelayOrEventControl dec=null; Expression exp=null;}
:	lv=lvalue LE (dec=delay_or_event_control)? exp=expression
		{nba = getTree().nonBlockingAssignment(lv,dec,exp);}
;

procedural_continuous_assignments returns [ProceduralContinuousAssign pca]
{ pca=null; VariableAssignment vas=null; Lvalue lv=null;}
:	"assign" vas=variable_assignment
		{pca = getTree().procContAssign(vas, true);}
|	"deassign" lv=lvalue
		{pca = getTree().procContAssign(lv, true);}
|	"force" vas=variable_assignment
		{pca = getTree().procContAssign(vas, false);}
//|	"force" net_assignment
|	"release" lv=lvalue
		{pca = getTree().procContAssign(lv, false);}
;

variable_assignment returns [VariableAssignment va]
{ va=null; Lvalue lv=null; Expression exp=null;}
:	lv=lvalue ASSIGN exp=expression
		{va = getTree().variableAssignment(lv,exp);}
;

//A.6.3 Parallel and sequential blocks
par_block returns [ParBlock pb]
{ pb=null; BlockIdent bid=null; BlockItemDecl decl=null; Statement st=null;}
:	loc1:"fork"
		(COLON bid=block_identifier 
			(options{greedy=true;}: 
			decl=block_item_declaration 
				{pb = getTree().parBlock(pb,bid,decl);} )*
		)? 
		{	//In case of no bid, then still need to push scope
			if (null == bid) {
				pb = getTree().parBlock(pb,bid,loc1);
			}
		}
		(	st=statement {pb = getTree().parBlock(pb,bid,st);} )* 
		"join"
		{	if (null != pb) { 
				getTree().popScope();
			}
		}
;

seq_block returns [SeqBlock sb]
{ sb=null; BlockIdent bid=null; BlockItemDecl decl=null; Statement st=null;
}
:	loc1:"begin" 
		(COLON bid=block_identifier 
				{sb = getTree().seqBlock(sb,bid,loc1);}
			(options{greedy=true;}: 
			decl=block_item_declaration 
	      		{sb = getTree().seqBlock(sb,bid,decl);} )*
		)? 
		{	//In case of no bid, then still need to push scope
			if (null == bid) {
				sb = getTree().seqBlock(sb,bid,loc1);
			}
		}
		(	st=statement {sb = getTree().seqBlock(sb,bid,st);} )* 
		"end"
		{
			if (null != sb) {	//catch "begin end", where no push done
				getTree().popScope();
			}
		}
;

//A.6.4 Statements
statement returns [Statement stmt]
{ stmt=null; Object o1=null;}
:	(attribute_instance)* 
		(	(blocking_assignment SEMI)=> o1=blocking_assignment SEMI
				{stmt = getTree().statement((BlockingAssign)o1);}
		|	o1=case_statement
				{stmt = getTree().statement((CaseStatement)o1);}
		|	o1=conditional_statement
				{stmt = getTree().statement((ConditionalStatement)o1);}
		|	o1=disable_statement
				{stmt = getTree().statement((DisableStmt)o1);}
		|	o1=event_trigger
				{stmt = getTree().statement((EventTrigger)o1);}
		|	o1=loop_statement
				{stmt = getTree().statement((LoopStatement)o1);}
		|	o1=nonblocking_assignment SEMI
				{stmt = getTree().statement((NonBlockingAssign)o1);}
		|	o1=par_block
				{stmt = getTree().statement((ParBlock)o1);}
		|	o1=procedural_continuous_assignments SEMI
				{stmt = getTree().statement((ProceduralContinuousAssign)o1);}
		|	o1=procedural_timing_control_statement
				{stmt = getTree().statement((ProceduralTimingControlStatement)o1);}
		|	o1=seq_block
				{stmt = getTree().statement((SeqBlock)o1);}
		|	o1=system_task_enable
				{stmt = getTree().statement((SystemTaskEnable)o1);}
		|	o1=task_enable
				{stmt = getTree().statement((TaskEnable)o1);}
		|	o1=wait_statement
				{stmt = getTree().statement((WaitStatement)o1);}
		)
;

statement_or_null returns [Statement stmt]
{ stmt=null;}
: 	((attribute_instance)* SEMI)=>
	 	(attribute_instance)* SEMI
|	stmt=statement
;

function_statement returns [FuncStatement fc]
{ fc=null; Statement st=null;}
:	st=statement	{fc = getTree().functionStatement(st);}
;

//A.6.5 Timing control statements
delay_control returns [DelayControl dc]
{ dc=null; DelayValue dv=null; MinTypMaxExpression mtm=null;}
:	POUND dv=delay_value	{dc = getTree().delayControl(dv);}
| 	POUND LPAREN mtm=mintypmax_expression RPAREN
		{dc = getTree().delayControl(mtm);}
;

delay_or_event_control returns [DelayOrEventControl dec]
{ dec=null; DelayControl dc=null; EventControl ec=null; Expression exp=null;}
:	dc=delay_control	{dec = getTree().delayOrEventControl(dc);}
| 	ec=event_control	{dec = getTree().delayOrEventControl(ec);}
| 	"repeat" LPAREN exp=expression RPAREN ec=event_control
		{dec = getTree().delayOrEventControl(exp,ec);}
;

disable_statement returns [DisableStmt ds]
{ ds=null; HierIdent hi=null;}
:	"disable" hi=hierarchical_identifier SEMI
		{ds = getTree().disableStatement(hi);}
;

event_control returns [EventControl ec]
{ ec=null; HierEventIdent hei=null; EventExpression ee=null;}
:	AT hei=hierarchical_event_identifier
		{ec = getTree().eventControl(hei);}
| 	AT LPAREN 
		(	STAR 				{ec = getTree().eventControl(true);}
		| 	ee=event_expression {ec = getTree().eventControl(ee);}
		)
		RPAREN
| 	AT STAR {ec = getTree().eventControl(true);}
;

event_trigger returns [EventTrigger et]
{ et=null; HierEventIdent hei=null; Expression exp=null;}
:	TRIGGER	hei=hierarchical_event_identifier 
		{et = getTree().eventTrigger(hei);}
	(LBRACK exp=expression RBRACK {getTree().eventTrigger(et, exp);} )* SEMI
;

/**REMOVE LEFT RECURSION
event_expression
:	expression
|	"posedge" expression
|	"negedge" expression
|	event_expression "or" event_expression
|	event_expression COMMA event_expression
;
**/

event_expression returns [EventExpression ee]
{ ee=null; Object e1=null, e2=null;}
:	e1=event_expression_1 e2=event_expression_2
		{ee = getTree().eventExpression(e1,e2);}
;

event_expression_1 returns [Object e1]
{ e1=null; Expression exp=null; int tk=LA(1);}
:	(	exp=expression {tk=-1;}
	|	"posedge" exp=expression
	|	"negedge" exp=expression
	)
	{ e1 = getTree().event_expression_1(tk, exp);}
;

event_expression_2 returns [Object e2]
{ e2=null; EventExpression ee=null; Object ee2=null;}
:	(options{warnWhenFollowAmbig=false;}:
		"or" ee=event_expression ee2=event_expression_2
			{e2 = getTree().event_expression_2(true, ee, ee2);}
	|	COMMA ee=event_expression ee2=event_expression_2
			{e2 = getTree().event_expression_2(false, ee, ee2);}
	|	//empty
	)
;

procedural_timing_control returns [ProceduralTimingControl ptc]
{ ptc=null; DelayControl dc=null; EventControl ec=null;}
:	dc=delay_control	{ptc = getTree().proceduralTimingControl(dc);}
|	ec=event_control	{ptc = getTree().proceduralTimingControl(ec);}
;

procedural_timing_control_statement 
		returns [ProceduralTimingControlStatement pcs]
{ pcs=null; ProceduralTimingControl pt=null; Statement st=null;}
:	pt=procedural_timing_control st=statement_or_null
		{pcs = getTree().procTimingControlStmt(pt, st);}
;

wait_statement returns [WaitStatement ws]
{ ws=null; Expression exp=null; Statement st=null;}
:	"wait" LPAREN exp=expression RPAREN st=statement_or_null
		{ws = getTree().waitStatement(exp, st);}
;

//A.6.6 Conditional statements
conditional_statement returns [ConditionalStatement cs]
{ cs=null; Expression exp=null; Statement s1=null, s2=null;}
:	"if" LPAREN exp=expression RPAREN
		s1=statement_or_null 
		(
			options {
				warnWhenFollowAmbig = false;
			}
			:	"else" s2=statement_or_null
		)?
		{ cs = getTree().conditionalStatement(exp, s1, s2);}
;

//A.6.7 Case statements
case_statement returns [CaseStatement cs]
{ cs=null; int tk=LA(1); Expression exp=null; CaseItem ci=null;}
:	("case" | "casex" | "casez") LPAREN exp=expression RPAREN
			{cs = getTree().caseStatement(tk, exp);}
		 ci=case_item {getTree().caseStatement(cs, ci);}
		(ci=case_item {getTree().caseStatement(cs, ci);} )* 
		"endcase"
;

case_item returns [CaseItem ci]
{ ci=null; Expression exp=null; Statement stmt=null;}
:	exp=expression 
			{ci = getTree().caseItem(exp);}
		(COMMA exp=expression {getTree().caseItem(ci, exp);} )* 
		COLON stmt=statement_or_null
			{getTree().caseItem(ci, stmt);}
| 	"default" (COLON)? stmt=statement_or_null
		{ci = getTree().caseItem(stmt);}
;

//A.6.8 Looping statements
loop_statement returns [LoopStatement lst]
{ lst=null; Statement st=null; Expression exp=null; 
  VariableAssignment va1=null,va2=null; int tk=LA(1);}
:	"forever" st=statement
		{lst = getTree().loopStatement(st);}
| 	"repeat" LPAREN exp=expression RPAREN st=statement
		{lst = getTree().loopStatement(tk, exp, st);}
| 	"while" LPAREN exp=expression RPAREN st=statement
		{lst = getTree().loopStatement(tk, exp, st);}
| 	"for" LPAREN va1=variable_assignment SEMI exp=expression 
		SEMI va2=variable_assignment RPAREN
		st=statement
			{lst = getTree().loopStatement(va1, exp, va2, st);}
;

//A.6.9 Task enable statements
system_task_enable returns [SystemTaskEnable ste]
{ ste=null; SystemTaskIdent sti=null; Expression exp=null;}
:	sti=system_task_identifier 
			{ste = getTree().systemTaskEnable(sti);}
		(LPAREN (exp=expression)? 
			{getTree().systemTaskEnable(ste,exp); exp=null;}
		(COMMA (exp=expression)? 
			{getTree().systemTaskEnable(ste,exp); exp=null;}
		)* RPAREN)? SEMI
;

task_enable returns [TaskEnable te]
{ te=null; HierTaskIdent hti=null; Expression exp=null;}
:	hti=hierarchical_task_identifier 
			{te = getTree().taskEnable(hti);}
		(LPAREN exp=expression {getTree().taskEnable(te,exp);}
		(COMMA exp=expression {getTree().taskEnable(te,exp);} )* RPAREN)? SEMI
;

//SKIP altogether A.7 Specify section

//A.8 Expressions
//A.8.1 Concatenations
concatenation returns [Concatenation cc]
{ cc=null; Expression exp=null;}
:	LCURLY exp=expression {cc=getTree().concatenation(null, exp);}
		(COMMA exp=expression {getTree().concatenation(cc, exp);} )* RCURLY
;

multiple_concatenation returns [MultConcatenation mc]
{ mc=null; ConstExpression ce=null; Concatenation cc=null;}
:	LCURLY ce=constant_expression cc=concatenation RCURLY
		{mc = getTree().multipleConcatenation(ce, cc);}
;

//A.8.2 Function calls
function_call returns [FunctionCall fc]
{ fc=null; HierFunctionIdent hfi=null; Expression exp=null;}
:	hfi=hierarchical_function_identifier (attribute_instance)*
		LPAREN exp=expression {fc = getTree().functionCall(hfi, exp);}
		(COMMA exp=expression {getTree().functionCall(fc, exp);} )* 
		RPAREN
;

system_function_call returns [SystemFunctionCall sfc]
{ sfc=null; SystemFunctionIdent sfi=null; Expression exp=null;}
:	sfi=system_function_identifier
			{sfc = getTree().systemFunctionCall(sfi);}
		(LPAREN exp=expression {getTree().systemFunctionCall(sfc, exp);}
		(COMMA exp=expression  {getTree().systemFunctionCall(sfc, exp);} 
			)* RPAREN)?
;

//A.8.3 Expressions
base_expression returns [Expression exp]
{ exp=null;}
:	exp=expression
;

constant_base_expression returns [ConstExpression cexp]
{ cexp=null;}
:	cexp=constant_expression
;

constant_expression returns [ConstExpression ce]
{ ce=null; Expression exp=null; }
:	exp=expression
		{ce = getTree().constantExpression(exp);}
;

constant_mintypmax_expression returns [ConstMinTypMaxExpression cmtm]
{ cmtm=null; ConstExpression c0=null,c1=null,c2=null;}
:	c0=constant_expression 
		(COLON c1=constant_expression COLON c2=constant_expression)?
			{cmtm = getTree().constantMinTypeMaxExpression(c0,c1,c2);}
;

constant_range_expression returns [ConstRangeExpression cre]
{ cre=null; ConstExpression ce1=null, ce2=null; int op=-1;}
:	ce1=constant_expression 
		( {op=LA(1);} (PLUS_COLON | MINUS_COLON | COLON) 
		  ce2=constant_expression)?
				{cre = getTree().constantRangeExpression(ce1,op,ce2);}
;

dimension_constant_expression returns [ConstExpression ce]
{ ce=null;}
:	ce=constant_expression
;

/**REMOVE LEFT RECURSION
expression
:	primary
| 	unary_operator (attribute_instance)* primary
|	expression binary_operator (attribute_instance)* expression
|	expression QMARK (attribute_instance)* expression COLON expression
;
**/
expression returns [Expression expr]
{ expr=null; Object e1=null, e2=null;}
:	e1=expression_1 e2=expression_2
		{expr = getTree().expression(e1, e2);}
;

expression_1 returns [Object expr]
{	expr=null; Object uop=null, prim=null;}
:	(	prim=primary
	| 	uop=unary_operator (attribute_instance)* prim=primary
	)
		{expr = getTree().expression_1(uop, prim);}
;

expression_2 returns [Object expr]
{ expr=null; Object e1=null, e2=null, e3=null; boolean isTernary=false;}
:	(options{warnWhenFollowAmbig=false;}:
		e1=binary_operator (attribute_instance)* e2=expression e3=expression_2
	|	QMARK (attribute_instance)* e1=expression 
			COLON e2=expression e3=expression_2 {isTernary=true;}
	|	//empty
	)
		{expr = getTree().expression_2(isTernary, e1, e2, e3);}
;

msb_constant_expression returns [ConstExpression cexp]
{ cexp=null;}
:	cexp=constant_expression
;

lsb_constant_expression returns [ConstExpression cexp]
{ cexp=null;}
:	cexp=constant_expression
;

mintypmax_expression returns [MinTypMaxExpression mtm]
{ mtm=null; Expression mtms[] = {null,null,null}; Expression exp=null;}
: 	exp=expression {mtms[0]=exp;}
		(COLON exp=expression {mtms[1]=exp;}
		 COLON exp=expression {mtms[2]=exp;} )?
		{mtm=getTree().minTypMaxExpression(mtms);}
;

range_expression returns [RangeExpression rexp]
{ rexp=null; Expression lhs=null; ConstExpression rhs=null; int tk=LA(2);}
: 	(	(msb_constant_expression COLON)=>
			lhs=msb_constant_expression COLON rhs=lsb_constant_expression
	|	(base_expression PLUS_COLON)=>
	 		lhs=base_expression PLUS_COLON rhs=width_constant_expression
	| 	(base_expression MINUS_COLON)=>
			lhs=base_expression MINUS_COLON rhs=width_constant_expression
	|	lhs=expression {tk=-1;}
	)
	{ rexp = getTree().rangeExpression(lhs, tk, rhs);}
;

width_constant_expression returns [ConstExpression cexp]
{ cexp=null;}
:	cexp=constant_expression
;

//A.8.4 Primaries
constant_primary returns [ConstPrimary cp]
{ cp=null; Primary p=null;}
:	p=primary	{cp = getTree().constantPrimary(p);}
;

//add part-select to handle the nuances of ambiguity of
// [expression]* [range_expression]
//since an alternative of range_expression => expression.
//TODO: we'll cheat and allow [range_expression]*
//needs to be: [expression]* [range_expression]
part_select returns [PartSelect ps]
{ ps=null; RangeExpression rexp=null;}               
:	(LBRACK rexp=range_expression {ps = getTree().partSelect(ps, rexp);}
		RBRACK)+
;

primary returns [Primary prim]
{ prim=null; Object o1=null; HierIdent id=null;}
:	o1=number
		{prim = getTree().primary((Vnumber)o1);}
|	id=hierarchical_identifier (o1=part_select)?
		{prim = getTree().primary(id, (PartSelect)o1);}
| 	(function_call)=> o1=function_call
		{prim = getTree().primary((FunctionCall)o1);}
| 	(multiple_concatenation)=> o1=multiple_concatenation
		{prim = getTree().primary((MultConcatenation)o1);}
| 	o1=concatenation
		{prim = getTree().primary((Concatenation)o1);}
| 	o1=system_function_call
		{prim = getTree().primary((SystemFunctionCall)o1);}
| 	LPAREN o1=mintypmax_expression RPAREN
		{prim = getTree().primary((MinTypMaxExpression)o1);}
| 	o1=string
		{prim = getTree().primary((Vstring)o1);}
;

//A.8.5 Expression left-side values
//NOTE: combine net/value_lvalue
lvalue returns [Lvalue lv]
{ lv=null; Object o1=null; Lvalue olv=null; ListOf<Lvalue> lof=null;}
:	o1=lvalue2            {lv  = getTree().lvalue(o1);}
|	LCURLY olv=lvalue     {lof = getTree().lvalue(lof, olv);}
		(COMMA olv=lvalue {getTree().lvalue(lof, olv);} )* 
		RCURLY            {lv = getTree().lvalue(lof);}
;

lvalue2 returns [Object o1]
{ o1=null; HierIdent hi=null; PartSelect ps=null;}
:	hi=hierarchical_identifier (ps=part_select)?
		{o1 = getTree().lvalue2(hi,ps);}
;

//A.8.7 Numbers
number returns [Vnumber n]
{ n = null; }
:	tk:NUMBER {n = getTree().number(tk);}
;

string returns [Vstring v]
{ v = null; }
:	tk:STRING {v = getTree().string(tk);}
;

identifier returns [Ident id]
{	id=null; }
:	tk:IDENT 			{id = new Ident(tk);}
|	tk2:ESCAPED_IDENT 	{id = new Ident(tk2);}
;

attribute_instance
:	LPAREN STAR attr_spec (COMMA attr_spec)* STAR RPAREN
;

attr_spec
{ ConstExpression unused=null;}
:	attr_name (ASSIGN unused=constant_expression)?
;

attr_name
{ Ident unused=null;}
:	unused=identifier
;

//A.9.3 Identifiers
block_identifier returns [BlockIdent rid]
{ rid=null; Ident id=null;}
:	id=identifier 
		{	rid = getTree().blockIdentifier(id);
		}
;

event_identifier returns [EventIdent rid]
{ rid=null; Ident id=null;}
:	id=identifier {rid = getTree().eventIdentifier(id);}
;

function_identifier returns [FuncIdent rid]
{ rid=null; Ident id=null;}
:	id=identifier 
		{	rid = getTree().funcIdentifier(id);
		}
;

hierarchical_identifier returns [HierIdent hid]
{ hid = null; Object hi=null; Ident id=null;}
:	(identifier (LBRACK constant_expression RBRACK)? DOT)=>
		hi=hierarchical_identifier2
			{hid = getTree().hierarchicalIdentifier(hi);}
|	id=identifier
		{hid = getTree().hierarchicalIdentifier(id);}
;

hierarchical_identifier2 returns [Object hid]
{ hid=null; Ident id=null; ConstExpression cex=null; HierIdent hid2=null;}
:	id=identifier (LBRACK cex=constant_expression RBRACK)? 
			{hid = getTree().hierarchicalIdentifier2(id, cex);}
		DOT (hid2=hierarchical_identifier 
				{getTree().hierarchicalIdentifier2(hid, hid2);} )+
;

system_function_identifier returns [SystemFunctionIdent rid]
{ rid=null; }
:	tk:SYSTEM_TASK_NAME {rid = getTree().systemFunctionIdentifier(tk);}
;

system_task_identifier returns [SystemTaskIdent rid]
{ rid=null; }
:	tk:SYSTEM_TASK_NAME {rid = getTree().systemTaskIdentifier(tk);}
;

generate_block_identifier returns [GenerateBlockIdent rid]
{ rid=null; Ident id=null;}
:	id=identifier {rid = getTree().generateBlockIdentifier(id);}
;

genvar_identifier returns [GenvarIdent rid]
{ rid=null; Ident id=null;}
:	id=identifier {rid = getTree().genvarIdentifier(id);}
;

hierarchical_event_identifier returns [HierEventIdent rid]
{ rid=null; HierIdent id=null;}
:	id=hierarchical_identifier 
		{rid = getTree().hierarchicalEventIdentifier(id);}
;

hierarchical_function_identifier returns [HierFunctionIdent rid]
{ rid=null; HierIdent id=null;}
:	id=hierarchical_identifier 
		{rid = getTree().hierarchicalFunctionIdentifier(id);}
;

hierarchical_parameter_identifier returns [HierParameterIdent rid]
{ rid=null; HierIdent id=null;}
:	id=hierarchical_identifier 
		{rid = getTree().hierarchicalParameterIdentifier(id);}
;

hierarchical_task_identifier returns [HierTaskIdent rid]
{ rid=null; HierIdent id=null;}
:	id=hierarchical_identifier 
		{rid = getTree().hierarchicalTaskIdentifier(id);}
;

module_identifier returns [ModuleIdent rid]
{ rid=null; Ident id=null; Token la1 = LT(1);}
:	(	("and"|"nand"|"nor"|"or"|"xor"|"xnor")  
			{la1.setType(IDENT); id = new Ident(la1);		}
	|	id=identifier 
	)
	{rid = getTree().moduleIdentifier(id);}
;

module_instance_identifier returns [ModuleInstanceIdent rid]
{ rid=null; Ident id=null;}
:	id=identifier {rid = getTree().moduleInstanceIdentifier(id);}
;

net_identifier returns [NetIdent rid]
{ rid=null; Ident id=null;}
:	id=identifier {rid = getTree().netIdentifier(id);}
;

parameter_identifier returns [ParameterIdent rid]
{ rid=null; Ident id=null;}
:	id=identifier {rid = getTree().parameterIdentifier(id);}
;

port_identifier returns [PortIdent rid]
{ rid=null; Ident id=null;}
:	id=identifier {rid = getTree().portIdentifier(id);}
;

real_identifier returns [RealIdent rid]
{ rid=null; Ident id=null;}
:	id=identifier {rid = getTree().realIdentifier(id);}
;

specparam_identifier returns [SpecparamIdent rid]
{ rid=null; Ident id=null;}
:	id=identifier {rid = getTree().specparamIdentifier(id);}
;

variable_identifier returns [VariableIdent rid]
{ rid=null; Ident id=null;}
:	id=identifier {rid = getTree().variableIdentifier(id);}
;

task_identifier returns [TaskIdent rid]
{ rid=null; Ident id=null;}
:	id=identifier {rid = getTree().taskIdentifier(id);}
;

unary_operator returns [UnaryOp rop]
{	rop=null; int op=LA(1); }
:	(MINUS
|	PLUS
|	LNOT
|	BNOT
|	BAND
|	RNAND
|	BOR
|	RNOR
|	BXOR
|	RXNOR)
		{ rop = getTree().unaryOp(op);}
;

binary_operator returns [BinaryOp rop]
{	rop=null; int op=LA(1); }
:	(MINUS
|	PLUS
|	BAND
|	BOR
|	BXOR
|	RXNOR
|	STAR
|	DIV
|	MOD
|	EQUAL
|	NOT_EQ
|	NOT_EQ_CASE
|	EQ_CASE
|	LAND
|	LOR
|	LT_
|	LE
|	GT
|	GE
|	SR
|	SL
|	SR3
|	SL3
|	STAR2)
		{ rop = getTree().binaryOp(op);}
;

class VlogLexer extends Lexer;
options {
	k=3;
	charVocabulary='\u0000'..'\u00FF';
	testLiterals=false;
}
{
    /**Print message unless it was already handled.*/
    public void reportError(RecognitionException ex) {
        if (false == v2k.message.ExceptionBase.class.isInstance(ex)) {
            Message.message(ex);
        }
    }

    public void reportError(String s) {
        Message.syntaxError(s);
    }

    public void reportWarning(String s) {
		Message.syntaxWarning(s);
    }

	static Parser getParser() {
		return Parser.getTheOne();
	}

	private static ASTreeBase getTree() {
		return Parser.getTheTree();
	}

}

  // Operators
AT	    	: '@'   ;
COLON	    : ':'   ;
COMMA	    : ','   ;
DOT	    	: '.'   ;
ASSIGN	    : '='   ;
MINUS	    : '-'   ;
LBRACK	    : '['   ;
RBRACK	    : ']'   ;
LCURLY	    : '{'   ;
RCURLY	    : '}'   ;
LPAREN	    : '('   ;
RPAREN	    : ')'   ;
POUND	    : '#'   ;
QMARK		: '?'   ;
SEMI	    : ';'   ;
PLUS        : '+'   ;
PLUS_COLON	: "+:"	;
MINUS_COLON	: "-:"	;
LNOT        : '!'   ;
BNOT        : '~'   ;
BAND        : '&'   ;
RNAND       : "~&"  ;
BOR         : '|'   ;
RNOR        : "~|"  ;
BXOR        : '^'   ;
RXNOR       : "~^" | "^~" ;
STAR        : '*'   ;
STAR2       : "**"   ;
DIV         : '/'   ;
MOD         : '%'   ;
EQUAL       : "=="  ;
NOT_EQ      : "!="  ;
NOT_EQ_CASE : "!==" ;
EQ_CASE     : "===" ;
LAND        : "&&"  ;
LOR         : "||"  ;
LT_         : '<'   ;
LE          : "<="  ;
GT          : '>'   ;
GE          : ">="  ;
SR          : ">>"  ;
SL          : "<<"  ;
SR3         : ">>>"  ;
SL3         : "<<<"  ;
TRIGGER     : "->"  ;
PPATH       : "=>"  ;
FPATH       : "*>"  ;

TIC_DIRECTIVE
	:	'`' id:IDENT 
			( 	{id.getText().equals("line")}?  TIC_LINE
			)
			{$setType(Token.SKIP);}
	;

protected
TIC_LINE
	:	(WS2)+ lnum:UNSIZED_NUMBER (WS2)+ fname:STRING 
			(WS2)+ UNSIZED_NUMBER (WS2)* '\n'
		{
			setFilename(fname.getText().replace("\"",""));
			setLine(Integer.parseInt(lnum.getText()));
			$setType(Token.SKIP);
		}
	;

IDENT 
	options {testLiterals=true;}
	:	 ('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'_'|'$'|'0'..'9')*
	;

ESCAPED_IDENT :
        '\\' (~ (' '|'\r'|'\t'|'\n'))+
        ;

SYSTEM_TASK_NAME :
        '$' IDENT
        ;

    // string literals
STRING :
        '"' (~('"'|'\n'))* '"'
        ;

   // a numeric literal
NUMBER :
	( (SIZE (WS)*)? BASE (WS)* SIZED_DIGIT ) => SIZED_NUMBER 
	| UNSIZED_NUMBER
	;

protected
SIZED_NUMBER :
	(SIZE (WS)*)? BASE (WS)* SIZED_DIGIT (SIZED_DIGIT | '_')*
	;

protected
SIZE :
	(DIGIT)+
	;

protected
BASE :
	'\'' ( 'd' | 'D' | 'h' | 'H' | 'o' | 'O' | 'b' | 'B' )
	;

protected
SIZED_DIGIT :
	DIGIT | HEXDIGIT | 'x' | 'X' | 'z' | 'Z' | '?'
	;

protected
UNSIZED_NUMBER :
	DIGIT (DIGIT | '_')* ( '.' (DIGIT | '_')* )? (EXPONENT)?
        ;

protected
DIGIT :
        ('0'..'9')
        ;

protected
HEXDIGIT :
        ('A'..'F'|'a'..'f')
        ;

protected
EXPONENT :
        ('e'|'E') ('+'|'-')? ('0'..'9')+
        ;

protected
WS2	:  (CNTRL |' '|'\r'|'\t')
	;

WS  :  (WS2 |'\n' {newline();})
        {$setType(Token.SKIP);}
    ;

protected
CNTRL
	: '\u0000'..'\u0008'
	| '\u000B'..'\u000C'
	| '\u000E'..'\u001F'
	| '\u007F'..'\u00FF'
	;

// Single-line comments
SL_COMMENT
    :   "//"
        (~('\n'|'\r'))* ('\n'|'\r'('\n')?)?
        {newline(); $setType(Token.SKIP);}
    ;

// multiple-line comments
ML_COMMENT
    :   "/*"
        (   /*  '\r' '\n' can be matched in one alternative or by matching
                '\r' in one iteration and '\n' in another.  I am trying to
                handle any flavor of newline that comes in, but the language
                that allows both "\r\n" and "\r" and "\n" to all be valid
                newline is ambiguous.  Consequently, the resulting grammar
                must be ambiguous.  I'm shutting this warning off.
             */
            options {
                generateAmbigWarnings=false;
            }
        :
            { LA(2)!='/' }? '*'
        |   '\r' '\n'       {newline();}
        |   '\r'            {newline();}
        |   '\n'            {newline();}
        |   ~('*'|'\n'|'\r')
        )*
        "*/"
        {$setType(Token.SKIP);}
    ;

