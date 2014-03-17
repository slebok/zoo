@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module framework::Checker

import IO;
import framework::Types;
import framework::BackEnd;

void cmain()
{
	visit(traversebase())
	{
		case z:zentry(str where, list[ZooValue] meta, _):
		{
			validateReadmes(z);
		}
	}
}

void validateReadmes(ZooEntry z)
{
	here = exists(framework::BackEnd::basedir + z.where + "/README.txt");
	refd = flag("readme") in z.meta;
	if (here && refd)
		println("README validated in <z.where>");
	elseif (!here && refd)
		println("README broken in <z.where>");
	elseif (here && !refd)
		println("README forgotten in <z.where>");
}