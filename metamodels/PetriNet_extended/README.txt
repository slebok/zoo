http://www.emn.fr/z-info/atlanmod/index.php/Ecore#PetriNet_extended_1.0
 ↳  http://gforge.inria.fr/scm/viewvc.php/*checkout*/AtlantEcore/PetriNet_extended.ecore?root=atlantic-zoos

PetriNet_extended 1.0
date : 2005/08/11
Domain : Petri net
Description :  This basic metamodel describes Petri Net. It consists of places, transitions and directed arcs that connect them, so arcs run between places and transitions, not between places and places or transitions and transitions.  There is two sorts of arcs : the ones which connect places with transitions, and the other start at a transition and end at a place. Places can contain tokens; the current state of the modeled system (the marking) is given by the number (and type if the tokens are distinguishable) of tokens in each place. Transitions are active components. They model activities which can occur (the transition fires), thus changing the state of the system (the marking of the Petri net). Transitions are only allowed to fire if they are enabled, which means that all the preconditions for the activity must be fulfilled (there are enough tokens available in the input places).  When the transition fires, it removes tokens from its input places and adds some at all of its output places. The number of tokens removed / added depends on the cardinality of each arc (weight). The interactive firing of transitions in subsequent markings is called token game. 
See : Petri_Net.km3
Authors : Hugo Bruneliere

Grammar in a broad sense extracted automatically on 8 April 2013 by Vadim Zaytsev, http://grammarware.net
