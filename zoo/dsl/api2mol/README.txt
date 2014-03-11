API2MoL
A software asset enables access to its internal functionality through an Application Programming Interface (API) that describes the set of public services offered by the software. Given the importance of the API concept in software engineering, we need mechanisms to integrate APIs in Model-Driven Engineering (MDE), for instance, as part of software modernization or code-generation scenarios. However, in current approaches integration is done by hardcoding glue code directly in the MDE application.

Our generic solution API2MoL is a Domain Specific Language specially designed to integrate APIs into MDE. With API2MoL, developers can define the mappings between an API and a metamodel (i.e. mappings between API classes and metamodel elements). It is also possible to automatically create a metamodel definition directly from the API information if not existing metamodel is already available. These mappings can then be used to anytime we need to bridge the gap between software and models. For instance, we can create complete models from running applications or create complete software artifacts from models, where complete, in both examples, refers to the fact that the model/software will include all the necessary calls to the APIs used by the software.

https://code.google.com/a/eclipselabs.org/p/api2mol/
 http://modelum.es/trac/api2mol/
  Documentation
   API2MoL abstract syntax
    http://modelum.es/trac/api2mol/attachment/wiki/WikiStart/api2mol.ecore
   API2MoL concrete syntax
    http://modelum.es/trac/api2mol/attachment/wiki/WikiStart/api2mol.g
