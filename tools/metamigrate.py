#!/usr/local/bin/python3
# Migration of all remaining metamodels
import os.path

dirs = ['AnyLogic', 'BPEL', 'BPMN', 'Book', 'Bossa', 'CADM', 'CDE', 'COBOL', 'CORBAComponent', 'CPL', 'CWMCore', 'CWMRelationalData', 'ChocoModel', 'Class', 'ClassDiagram', 'CompanyStructure', 'Contact', 'ControllerUML', 'Cristal', 'DTMP', 'DeploymentReport', 'DiagramInterchange', 'DoDAF', 'DoDAF-OV5', 'DoDAF-SV4', 'DoDAF-SV5', 'DotNET_SystemReflection', 'EAI', 'EQN', 'EXPRESS', 'EXPRESSb', 'Family', 'FeatureDiagrams', 'FiniteStateMachine', 'FlatSignalFlow', 'GenericEditor', 'GenericOutline', 'GeoTrans', 'Grafcet', 'HAL', 'HPROF', 'HierarchicalSignalFlow', 'HierarchicalStateMachine', 'IEEE1471ConceptualModel', 'IEEE1471ViewpointM2', 'IMSTransactionMessage', 'IRL', 'Jess', 'KDM', 'KDMSimplified', 'KM3', 'Klaper', 'LQN', 'M', 'METAH', 'MSOfficeExcel_SpreadsheetMLBasicDef', 'MSOfficeExcel_SpreadsheetMLPrintingSetup', 'MSOfficeExcel_SpreadsheetMLSimplified', 'MSOfficeExcel_SpreadsheetMLStyles', 'MSOfficeExcel_SpreadsheetMLWorkbookProp', 'MSOfficeExcel_SpreadsheetMLWorksheetOpt', 'MSOfficeWord_WordprocessingMLBasicDef', 'MSOfficeWord_WordprocessingMLSimplified', 'MSOfficeWord_WordprocessingMLStyles', 'MSOfficeWord_WordprocessingMLTableElts', 'MTRANS', 'Marte', 'Matlab', 'Maude', 'Measure', 'Metrics', 'MiningMart', 'MiningMart_SimplifiedMetamodel', 'MiningMart_ViewCaseRepresentation', 'MiningMart_ViewDataRepresentation', 'MoDAF-AV', 'MoMM', 'MonitorProgram', 'MySQL', 'News', 'OpenQVT', 'PIF', 'PRR', 'Parameters', 'PathExp', 'Perceptory', 'Person', 'ProMarte', 'Problem', 'Program', 'Promenade', 'PtolemyII', 'Publication', 'QVT', 'QVT_SimpleRDBMS', 'QoS', 'QoS_Characteristic', 'QoS_Profile', 'QoS_Statement', 'Relational', 'RelationalDBContent', 'RelationalDBSchema', 'Repository', 'Reqtify', 'Requirement', 'RequisitePro', 'SCADE', 'SEE_Design', 'SPEM', 'SQLDDL', 'SQLDML', 'Scilab', 'SecureUML', 'SeminarSchedulingSystem', 'Sharengo', 'SignalFlow', 'SimpleAirlineDomain', 'SimulinkStateFlow', 'SoftwareQualityControl', 'SyncCharts', 'Table', 'Trace', 'TroposActorConcept', 'TroposGoalAndPlanConcepts', 'TroposIntegratingActorConcept', 'UDDI_meta-model_fragment', 'UEML', 'UEMLExtended', 'UEMLExtensionCapturingAgents', 'UEMLExtensionCapturingSocialEffects', 'UEMLExtensionDynamicAspects', 'UEMLExtensionModelingAspects', 'USECASE1', 'USECASE2', 'UnixFS', 'WSLink', 'WTIP_SimpleClass', 'WTIP_SimpleRDBMS', 'WebApplications_AbstractModel', 'WebApplications_ConceptualModel', 'WfMC', 'WorkDefinitions', 'XMorphLanguage_abstractSyntax', 'deployment', 'ifc2x3', 'mlhim2', 'useCase']

def getcontent(x):
	# <author>Julien Bernier</author>
	return x.split('>')[1].split('<')[0]

def auth2handle(x):
	# ['Bob Smith', 'Jon Doe']
	return ' — '.join(list(map(lambda x:x.split(' ')[-1],x)))

fetched = 0
extracted = 0
s = ''
for d in dirs:
	print (d)
	x = False
	try:
		f = open('metamodels/%s/zoo.xml' % d, 'r')
	except IOError:
		print ('\tZOO: FAIL!')
		break
	print ('\tZOO: CHECK')
	lines  = f.readlines()
	f.close()
	if lines[2].find('Atlantic')>0:
		print ('\tATL: CHECK')
	else:
		print ('\tATL: FAIL!')
		break
	fetched += 1
	if os.path.isfile('metamodels/%s/grammar.bgf' % d):
		print ('\tBGF: CHECK')
		extracted += 1
		x = True
	else:
		print ('\tBGF: FAIL!')
		# break
	authors = []
	title = ''
	filename = ''
	date = ''
	i = 3
	while lines[i].find('<author>')>-1:
		authors.append(getcontent(lines[i]))
		i += 1
	if len(authors)==0:
		print('\tAUT: FAIL!')
	elif len(authors)==1:
		print ('\tAUT: CHECK')
	else:
		print ('\tAUT: MANY')
	if lines[i].find('<title>')>-1:
		print ('\tTIT: CHECK')
		title = getcontent(lines[i])
		i +=1
	else:
		g = open('metamodels/%s/README.txt' %d,'r')
		glines = g.readlines()
		g.close()
		title = glines[3].strip()
		if title != '':
			print ('\tTIT: FIX[',title,']')
		else:
			print ('\tTIT: FAIL!')
	if lines[i].find('<file>')>-1:
		print ('\tFIL: CHECK')
		filename = getcontent(lines[i])
		i +=1
	else:
		print ('\tFIL: FAIL!')
		break
	if lines[i].find('<date')>-1:
		print ('\tDAT: CHECK')
		date = getcontent(lines[i])
		i +=1
	else:
		print ('\tDAT: FAIL!')
		print(lines[i])
		break
	f = open('metamodels/%s/zoo.xml2' % d, 'w')
	aut = ''
	for a in authors:
		aut += '\t\t<author>%s</author>\n' % a
	if title != '':
		tof = title
	else:
		tof = filename.replace('.ecore','')
	if filename != '':
		fname = '\t\t<file>'+ filename + '</file>\n'
	if title != '':
		title = '\t\t<title>'+ title + '</title>\n'
	if date != '':
		date = '\t\t<date>'+ date + '</date>\n'
	if x:
		grammar = '''
	<grammar>
		<of>%s</of>
		<dir>extracted</dir>
		<level>1</level>
		<method>automatic</method>
		<derivedFrom>fetched</derivedFrom>
		<!--  -->
		<toolused>ecore2bgf</toolused>
	</grammar>''' % tof
	else:
		grammar = ''
	f.write('''<?xml version="1.0" encoding="UTF-8"?>
<entry>
	<name>%s</name>
	<source>
%s%s%s%s	</source>
	<readme/>
	<link>
		<uri>http://www.emn.fr/z-info/atlanmod/index.php/Ecore</uri>
		<name>Atlantic</name>
	</link>
	<grammar>
		<dir>fetched</dir>
		<level>0</level>
		<method>download</method>
		<format>XMI</format>
	</grammar>%s
</entry>''' % (auth2handle(authors),aut,title,fname,date,grammar))
	f.close()
	print('\tOUT: CHECK')
	s += 'fe %s %s/%s\n' % (d,d,filename)
	f = open('feitall','w')
	f.write(s)
	f.close()
	print('FE∀: CHECK')

print ('Result:',fetched,'fetched, ',extracted,'extracted')

'''
<?xml version="1.0" encoding="UTF-8"?>		<grammar>
			<name>Extracted</name>
			<meta><src>Atlantic</src><tol0>wget</tol0><tol1>ecore2bgf</tol1></meta><source>
				<author>Julien Bernier</author>
				<author>Manuel Boillod</author>
				<author>Joanny Christ</author>
				<author>Sylvain Leduby</author>
				<file>GenericEditor.ecore</file>
				<date>2005/02/01</date>
				<readme/>
				<link>
					<uri>http://www.emn.fr/z-info/atlanmod/index.php/Ecore</uri>
					<name>Atlantic</name>
				</link>
				<link>
					<mu>topics/grammars/metamodels/GenericEditor/GenericEditor.ecore</mu>
					<name>GitHub</name>
				</link>
			</source>
<extraction><ecore/></extraction>		</grammar>


<?xml version="1.0" encoding="UTF-8"?>
<entry>
	<name>Brunelière</name>
	<source>
		<author>Hugo Brunelière</author>
		<file>AWKPrograms.ecore</file>
		<date>2005/08/09</date>
	</source>
	<readme/>
	<link>
		<uri>http://www.emn.fr/z-info/atlanmod/index.php/Ecore</uri>
		<name>Atlantic</name>
	</link>
	<grammar>
		<dir>fetched</dir>
		<level>0</level>
		<method>download</method>
		<format>XMI</format>
	</grammar>
	<grammar>
		<of>AWK</of>
		<dir>extracted</dir>
		<level>1</level>
		<method>automatic</method>
		<derivedFrom>fetched</derivedFrom>
		<!--  -->
		<toolused>ecore2bgf</toolused>
	</grammar>
</entry>
'''
