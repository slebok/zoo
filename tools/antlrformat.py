#!/usr/bin/python
# Add <format>ANTLR3</format> to all ANTLR grammars

dirs = ['DCM_2_0_grammar', 'FreeMPS', 'IEEE1451', 'Idl', 'InterpretVCDHeader', 'JPA', 'MicroXPath', 'Nolae', 'Nolae1', 'ObjectiveC2ansi', 'OracleSQL', 'PBM', 'PSharp', 'Pddl', 'Sexpr', 'StackTraceText', 'VCDSimulation', 'ValueChangeDump', 'ValueChangeDump1', 'Verilog3', 'aptlexer', 'download', 'download1', 'krl', 'nldb', 'parser', 'sparkle-g', 'sun-pdfimport', 'translatecim', 'v2kparse', 'vhdl', 'xqgrammar', 'xqgrammar1', 'zoneinfo-tz']

for d in dirs:
	f = open('%s/zoo.xml' % d, 'r')
	lines  = f.readlines()
	print 'Read',d,'successfully.'
	if lines[-1].strip() == '</entry>' and lines[-2].strip() == '</grammar>':
		lines.insert(-2,'\t\t<format>ANTLR3</format>\n')
	else:
		print 'invalid!'
		break
	f.close()
	f = open('%s/zoo.xml' % d, 'w')
	f.writelines(lines)
	f.close()
