@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module framework::ZooTree

import grammarlab::language::glue::abstract::Top;
import lang::json::ast::JSON;

alias Zoo = list[ZooLanguage];
data ZooLanguage = zlanguage(str name, str short, list[ZooVersion] vs);
data ZooVersion = zversion(str name, str short, list[ZooGrammar] gs);
data ZooGrammar = zgrammar(str name, str handle, list[str] tags, GLUE glue);

public str getProp(str prop, GLUE glue)
{
	for (metadata(meta) <- glue, prop in meta, string(s) := meta[prop])
		return s;
	return "";
}