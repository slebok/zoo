module lang::dot::Dot
import IO;
import String;
import Set;
import Map;

alias Id = str;

data DotGraph =  graph(Id id, Stms stmts) | digraph(Id id, Stms stmts);

alias Stms = list[Stm];

alias NodeId = tuple[Id, PortId];

alias PortId = tuple[Id, CompassPt];

data CompassPt = N()|NE()|E()|SE()|S()|SW()|W()|NW()|C()|_();



data Stm = 
  N(Id id, Attrs attrs) | N(Id id) 
| N(NodeId nid, Attrs attrs) | N(NodeId nid)

|E(Id from, Id to, Attrs attrs) |   E(Id from, Id to) 
|E(NodeId nfrom, Id to, Attrs attrs) |   E(NodeId nfrom, Id to) 
|E(Stm sfrom, Id to, Attrs attrs) |   E(Stm sfrom, Id to) 

|E(Id from, NodeId nto, Attrs attrs) |   E(Id from, NodeId nto) 
|E(NodeId nfrom, NodeId nto, Attrs attrs) |   E(NodeId nfrom, NodeId nto) 
|E(Stm sfrom, NodeId nto, Attrs attrs) |   E(Stm sfrom, NodeId nto) 

|E(Id from, Stm sto, Attrs attrs) |   E(Id from, Stm sto) 
|E(NodeId nfrom, Stm sto, Attrs attrs) |   E(NodeId nfrom, Stm sto) 
|E(Stm sfrom, Stm sto, Attrs attrs) |   E(Stm sfrom, Stm sto)
 
|S(Id id, Stms stms)| S(Stms stms)| A(Id prop, Id val)|
GRAPH(Attrs attrs)|NODE(Attrs attrs)|EDGE(Attrs attrs);

alias Attr =  tuple[str prop,  Id val];

alias Attrs = list[Attr];

alias Outline = map[int key, list[str] args];

alias Dotline = tuple[DotGraph graph, Outline outline];


