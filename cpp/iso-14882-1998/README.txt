INTERNATIONAL STANDARD ISO/IEC 14882
First edition 
1998-09-01 

Programming languages â€” C++

Reference number 
ISO/IEC 14882:1998(E)

Â© ISO/IEC 1999 
All rights reserved. Unless otherwise specified, no part of this publication may be reproduced or utilized in any form or by any means, electronic 
or mechanical, including photocopying and microfilm, without permission in writing from either ISO at the address below or ISO's member body 
in the country of the requester. 
ISO copyright office 
Case postale 56 í¯¿í°€ CH-1211 Geneva 20 
Tel. + 41 22 749 01 11 
Fax + 41 22 734 10 79 
E-mail copyright@iso.ch 
Web www.iso.ch 
Printed in Switzerland

Fixes that were necessary for extraction:

		namespaceidentifier{namespace-body } 
	was changed to
		namespaceidentifier {namespace-body } 
	(the extractor cannot be expected to split this into a sequence
	of a terminal, a reserved nonterminal, a non-alphanum terminal and a defined nonterminal)
	
	There are various layout problems (say, ";" formatted in italics),
	but we don't even care because we copy-paste the raw text anyway.
	