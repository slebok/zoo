@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module framework::Meta2XML

import grammarlab::language::glue::abstract::Top;
import lang::json::ast::JSON;

str xmlheader() = "\<?xml version=\"1.0\" encoding=\"UTF-8\"?\>";

public str glue2xml(GLUE glue)
	= xmlheader()
	+ intercalate("\n",[meta2xml_pure(meta) | GLUEA ga <- glue, metadata(MetaInfo meta) := ga]);

public str meta2xml(MetaInfo meta)
	= xmlheader() + meta2xml_pure(meta);

str meta2xml_pure(MetaInfo meta) =
	"\<grammar\>
	'	\<name\>Extracted\</name\>
	'	\<source\>
	'		<mapmap(meta)>
	'	\</source\>
	'\</grammar\>";

str mapmap(MetaInfo meta)
{
	str res = "";
	for (str k <- meta, k != "links")
		if (string(str s) := meta[k]) res += "\<<k>\><s>\</<k>\>";
		elseif (array(list[Value] vs) := meta[k]) res += intercalate("\n",["\<<k>\><v>\</<k>\>" | string(str v) <- vs]);
	if ("links" in meta)
		for (str k <- meta["links"].members)
			res += "\<link\>
			       '	<mapurl(k,meta["links"].members[k])>
			       '	\<name\><k>\</name\>
			       '\</link\>";
	return res;
}

str mapurl("GitHub",string(str x)) = "\<mu\><x>\</mu\>";
default str mapurl(str k, string(str x)) = "\<uri\><x>\</uri\>";
