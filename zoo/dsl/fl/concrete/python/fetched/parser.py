from pyparsing import *
_Literal = Literal
import fltypes as t


def parseProgram(prog):
    return program.parseString(prog).pop()

def parseApply(app):
    return apply.parseString(app).pop()

class ArgumentCollector(object):
    __existing = dict()
    __list = list()
    __tainted = False

    @classmethod
    def append(cls, tok):
        name = str(tok[0])
        if not name in cls.__existing:
            cls.__list.append(t.Argument(name))
            cls.__existing[name] = cls.__list[-1]
        return cls.__existing[name]

    @classmethod
    def get(cls):
        return tuple(cls.__list)

    @classmethod
    def reset(cls):
        cls.__existing, result, cls.__tainted, cls.__list = dict(), cls.__tainted, False, list()
        return result

    @classmethod
    def bind(cls, tok):
        #TODO: handle invalid arguments
        name = str(tok[0])
        arg = cls.__existing.get(name, t.Argument(name, True))
        cls.__tainted = arg.Tainted
        return arg


def _lassoc(tok):
    l = tok.pop(0)
    for op, r in tok:
        l = t.Operator(l, op, r)
    return l


defaultWhitespace = ParserElement.DEFAULT_WHITE_CHARS
ParserElement.setDefaultWhitespaceChars(ParserElement.DEFAULT_WHITE_CHARS.replace("\n", ""))

expr = Forward()

_IF, _THEN, _ELSE = (Keyword(i).suppress() for i in "if then else".split())

name = NotAny(_IF | _THEN | _ELSE)+Word(
        alphas
        ).setParseAction(lambda tok: str(tok[0]))
literal = (
        Optional("-") + Word(nums)
        ).setParseAction(lambda tok: t.Literal("".join(tok)))
atom = name ^ literal ^ (Suppress("(") + expr + Suppress(")"))

ifThenElse = (
        _IF + expr + _THEN + expr + _ELSE + expr
        ).setParseAction(lambda tok: t.IfThenElse(*tok))

operators = oneOf("== + -")

binary = (
        atom + ZeroOrMore((operators + atom).setParseAction(lambda tok: (tok[0], tok[1])))
        ).setParseAction(_lassoc)
apply = (
        name.copy() + Group(OneOrMore(atom))
        ).setParseAction(lambda tok: t.Apply(tok[0], *(i for i in tok[1])))

expr << (binary ^ apply ^ ifThenElse)

function = (
        name.copy() + OneOrMore(name.copy().setParseAction(ArgumentCollector.append)) + Suppress("=") + expr
        ).setParseAction(lambda tok: t.Function(tok[0], ArgumentCollector.get(), tok[-1], ArgumentCollector.reset()))

name.setParseAction(ArgumentCollector.bind)

program = OneOrMore(
        function
        ).setParseAction(lambda tok: t.Program(list(tok))) + StringEnd().setWhitespaceChars(defaultWhitespace)

for i in (program, function):
    i.setWhitespaceChars(defaultWhitespace)
###################################################################################

__all__ = "parseProgram parseApply".split()
