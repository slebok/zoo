/*
 * TXL v7.4 (c) 1988-1993, Queen's University at Kingston
 * J.R. Cordy, C.D. Halpern, E.M. Promislow & I.H. Carmichael
 * June 1993
 *
 * Example user external rules using the TXL external rule protocol.  
 * At present, user external rules may only act on the list of atomic
 * (leaf) tree nodes listed below.
 *
 * The interface to user external rules consists of two routines -
 *
 * 	char isUserRule (rulename)
 *	    char rulename[256];
 *
 * which returns true (1) if rulename is the name of an implemented user 
 * external rule, and false (0) otherwise, and 
 *
 *	void userRule (rulename, parmkinds, parmstrings, success)
 *	    char rulename[256];
 *	    char parmkinds[10];
 *	    char parmstrings[10][256];
 *	    char *success;
 *
 * which implements the user external rules.  The parmkinds array
 * gives the TXL leaf node kind code for the kind of the scope and each
 * parameter to the rule.  The parmstrings array gives the value of each of
 * the * nodes as a C string.  The first (i.e., [0]) element of each is the
 * scope the rule is applied to, and the rest are arguments 1 to 9 of
 * the rule call.  (Note: the actual number of arguments is indicated by
 * parmkinds[lastarg+1] = TXL_undefined).
 *
 * For each implemented user external rulename, userRule should verify
 * the appropriateness of the scope and parameters, calculate the result,
 * and strcopy the string form of the result to parmstrings[0].
 * (Note: in the TXL rule protocol, only the value of the scope can be
 * changed.  Assigning to parmstrings[1-9] or parmkinds[0-9] will have 
 * no effect.)
 *
 */

/* TXL leaf node kinds */
#define TXL_stringlit		4
#define TXL_charlit		5
#define TXL_token		6
#define TXL_id			7
#define TXL_upperlowerid	8
#define TXL_upperid		9
#define TXL_lowerupperid	10
#define TXL_lowerid		11
#define TXL_number		12
#define TXL_floatnumber		13
#define TXL_decimalnumber	14
#define TXL_integernumber	15
#define TXL_comment		16
#define TXL_undefined		22

/* TXL rule parameters */
#define TXL_maxparms 		10 	/* 0 = scope, 1-9 = parameters */
#define TXL_scope		0


char isUserRule (rulename)
    char rulename[256];
{
    /* at present we implement only [getid] and [sum N1 N2 N3 ...] */
    return ((strcmp(rulename, "getid") == 0) || (strcmp(rulename, "sum") == 0));

}


void userRule (rulename, parmkinds, parmstrings, success)
    char rulename[256];
    char parmkinds[10];
    char parmstrings[10][256];
    char *success;
{
    if ((strcmp(rulename, "getid") == 0) && 
		((parmkinds[TXL_scope]) == TXL_id)) {
	/* ID [getid] - get an input word from the terminal into ID */
	gets (parmstrings[TXL_scope], 255);
	*success = 1;

    } else if ((strcmp(rulename, "sum") == 0) && 
		((parmkinds[TXL_scope]) == TXL_number)) {
	/* N [sum N1 N2 N3 ...] - replace N by the sum of N1, N2, N3 ... */
	double r,q;
	register int p;
	r = 0.0;
	for (p = 1; p < TXL_maxparms; p++) {
	    if ((parmkinds[p]) != TXL_number) break;
	    sscanf (parmstrings[p], "%le", &q);
	    r += q;
	};
	sprintf (parmstrings[TXL_scope], "%g", (double) r);
	*success = 1;

    } else {
	/* at present we only implement [getid] and [sum] */
	*success = 0;
    };
}
