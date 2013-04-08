http://www.emn.fr/z-info/atlanmod/index.php/Ecore#PetriNet_1.0_2
 ↳  http://gforge.inria.fr/scm/viewvc.php/*checkout*/AtlantEcore/PetriNet.ecore?root=atlantic-zoos

PetriNet 1.0
date : 2005/07/18
Domain : Petri Net, PNML
Description :  The PetriNet metamodel describes the different model elements that compose a Petri net model, as well as the way they can be linked to each other. A PetriNet model is composed of Transitions, Places and Arcs. The PetriNet entity, as well as the Transition and the Place ones, inherits from the abstract Element entity that defines a name attribute. An Arc is an abstract entity which is associated with a weight attribute. Each Arc is either of the TransToPlaceArc or PlaceToTransArc kind. A TransToPlaceArc connects a Transition to a Place, whereas a PlaceToTransArc connects a Place to a Transition. A Place can have several outgoing PlaceToTransArcs and several incoming TransToPlaceArcs. Similarly, a Transition can have several incoming PlaceToTransArcs and several outgoing TransToPlaceArcs. Each TransToPlaceArc has a source Transition and a target Place. In the same way, each PlaceToTransArc has a source Place and a target Transition. 
See : <a href="http://www.informatik.huberlin.de/top/pnml/about.html" class="external free" title="http://www.informatik.huberlin.de/top/pnml/about.html" rel="nofollow">http://www.informatik.huberlin.de/top/pnml/about.html</a>
Authors : David Touzet

Grammar in a broad sense extracted automatically on 8 April 2013 by Vadim Zaytsev, http://grammarware.net
