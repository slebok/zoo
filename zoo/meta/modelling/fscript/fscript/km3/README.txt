http://wiki.eclipse.org/TCS/Zoo
 ↳  http://git.eclipse.org/c/mmt/org.eclipse.atl.tcs.git/tree/syntaxes/FScript/

FScript is a Domain-Specific Language (DSL) to program dynamic reconfigurations of Fractal architectures. FScript includes the FPath notation to navigate inside Fractal architectures, which can be used by itself as a query language for Fractal.
The FPath notation is inspired by the XPath language for XML navigation and query. If you have some notions of XPath, learning FPath should be easy. FPath makes it trivial to navigate inside even large and complex Fractal architecture with simple and readable queries, where the raw Fractal APIs would requires pages of code.
FScript itself can be thought of as a scripting language dedicated to Fractal components architectural reconfigurations. It builds upon FPath but adds the possibility to define reconfiguration scripts to modify the architecture of a Fractal application. Like FPath, FScript is much more concise the direct API usage. In addition, the FScript interpreter can provide transactional support for architectural reconfigurations by seamlessly integrating with an extended version of Julia (this work is done by Marc Léger at France Télécom).

-- @name		FScript
-- @version		1.0
-- @authors		Fr�d�ric Jouault
-- @date		20080205
-- @description	Metamodel of the FScript Fractal action language. This metamodel includes the FPath metamodel.
-- @see			http://fractal.objectweb.org/fscript/fscript_manual.pdf

Grammar in a broad sense fetched on 13 April 2014 by Vadim Zaytsev, http://grammarware.net
