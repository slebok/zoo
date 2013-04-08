http://www.emn.fr/z-info/atlanmod/index.php/Ecore#Measure_2.0
 ↳  http://gforge.inria.fr/scm/viewvc.php/*checkout*/AtlantEcore/Measure.ecore?root=atlantic-zoos

Measure 2.0
date : 2007/06/05
Domain : measurement data, metrics
Description :  This metamodel is a representation of measurement data.  
See : The measurement data are stored in sets of measures (MeasureSet). Each MeasureSet stores the data collected from one model element. The name and type of the model element are stored respectively in elementName and elementType of the MeasureSet. The reference subsets allow a hierarchy between the MeasureSets (the same as from the model measured). A measure (Measure) corresponds to a metric (Metric) (with a name and a description [desc]). The different metrics are also categorised (a category has a name and a description [desc]). The value of a measure can be an integer, a double or a percentage value (respectively IntegerMeasure, DoubleMeasure and PercentageMeasure).
Authors :

Grammar in a broad sense extracted automatically on 8 April 2013 by Vadim Zaytsev, http://grammarware.net
