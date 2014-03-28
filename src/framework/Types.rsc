@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module framework::Types

import List;
import String;

data ZooValue
	= keyvalue(str key, str val)
	| flag(str key)
	| struct(str key, list[ZooValue] inner)
	| zerror()
	;
// This is a kind of extended lrel[str,value]:
data ZooEntry
	= zentry(str where, list[ZooValue] meta, list[ZooEntry] inner)
	| noentry(str where)
	;

public list[ZooValue] getbykey(ZooEntry e, str key) = [ie | ZooValue ie <- e, ie.key == key];
public ZooValue get1bykey(ZooEntry e, str key) = getOneFrom([ie | ZooValue ie <- e, ie.key == key]);
public str txtbykey(ZooEntry e, str key) = txtbykey(e.meta, key);
public str txtbykey(list[ZooValue] es, str key) = safegetOneFrom([val | ZooValue kv <- es, keyvalue(key,str val) := kv]);

public bool isflagset(ZooEntry e, str key) = [ie | ZooValue ie <- e.meta, flag(key) := ie] != [];

public str safe4anchor(str s)
{
	for (weird <- [" ", "\t", "/", "#", "–", "—"])
		s = replaceAll(s,weird,"_");
	return s;
}

public str safegetOneFrom([]) = "";
public str safegetOneFrom([str x]) = x;
public default str safegetOneFrom(list[str] xs) = getOneFrom(xs);
