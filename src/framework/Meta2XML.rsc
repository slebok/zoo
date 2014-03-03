@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module framework::Meta2XML

import framework::ZooTree;

import grammarlab::language::glue::abstract::Top;
import lang::json::ast::JSON;
import List;

str xmlheader() = "\<?xml version=\"1.0\" encoding=\"UTF-8\"?\>";

public str zoo2xml(Zoo zoo)
	= "\<?xml version=\"1.0\" encoding=\"UTF-8\"?\>
	'\<zoo xmlns:links=\"http://grammarware.net/links\" xmlns:xhtml=\"http://www.w3.org/1999/xhtml\"\>
	'	\<name\>added\</name\>
	'	<intercalate("\n",[zlan2xml(zlan) | ZooLanguage zlan <- zoo])>
	'\</zoo\>";
str zlan2xml(ZooLanguage zlan)
	= "\<language\>
	'	\<name\><zlan.name>\</name\>
	'	\<short\><zlan.short>\</short\>
	'	<intercalate("\n",[zver2xml(zver) | ZooVersion zver <- zlan.vs])>
	'\</language\>";
str zver2xml(ZooVersion zver)
	= "\<version\>
	'	\<name\><zver.name>\</name\>
	'	\<short\><zver.short>\</short\>
	'	<intercalate("\n",[zgra2xml(zgra) | ZooGrammar zgra <- zver.gs])>
	'\</version\>";

// TODO
//data ZooGrammar = zgrammar(str name, str handle, list[str] tags, GLUE glue);
str zgra2xml(ZooGrammar zgra) = glue2xml(zgra.glue);

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
