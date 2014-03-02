@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module framework::Meta2XML

import grammarlab::language::glue::abstract::Top;
import lang::json::ast::JSON;
import List;

str xmlheader() = "\<?xml version=\"1.0\" encoding=\"UTF-8\"?\>";
public str xmlfile(list[str] ss) = xmlheader() + intercalate("\n",[s | s <- ss, s!=""]);
public str glue2xmlfile(GLUE glue) = xmlheader() + glue2xml(glue);
public str meta2xmlfile(MetaInfo meta) = xmlheader() + meta2xml(meta);

public str glue2xml(GLUE glue)
	= intercalate("\n",[meta2xml(meta) | GLUEA ga <- glue, metadata(MetaInfo meta) := ga]);

public str meta2xml(MetaInfo meta) =
	"\<grammar\>
	'	\<name\>Extracted\</name\>
	'	\<source\>
	'		<mapmap(meta)>
	'	\</source\>
	'\</grammar\>";

str mapmap(MetaInfo meta)
{
	list[str] res = [];
	for (str k <- meta, k != "links")
		if (string(str s) := meta[k])
			res += "\<<k>\><s>\</<k>\>";
		elseif (array(list[Value] vs) := meta[k])
			res += ["\<<k>\><v>\</<k>\>" | string(str v) <- vs];
	if ("links" in meta)
		res +=
		[	"\<link\>
	    	'	<mapurl(k,meta["links"].members[k])>
	    	'	\<name\><k>\</name\>
	    	'\</link\>"
	    | str k <- meta["links"].members];
	return intercalate("\n",res);
}

str mapurl("GitHub",string(str x)) = "\<mu\><x>\</mu\>";
default str mapurl(str k, string(str x)) = "\<uri\><x>\</uri\>";
