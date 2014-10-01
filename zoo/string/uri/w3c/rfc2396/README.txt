http://www.w3.org/Addressing/
	http://www.ietf.org/rfc/rfc2396.txt

Network Working Group                                     T. Berners-Lee
Request for Comments: 2396                                       MIT/LCS
Updates: 1808, 1738                                          R. Fielding
Category: Standards Track                                    U.C. Irvine
                                                             L. Masinter
                                                       Xerox Corporation
                                                             August 1998


           Uniform Resource Identifiers (URI): Generic Syntax

Status of this Memo

   This document specifies an Internet standards track protocol for the
   Internet community, and requests discussion and suggestions for
   improvements.  Please refer to the current edition of the "Internet
   Official Protocol Standards" (STD 1) for the standardization state
   and status of this protocol.  Distribution of this memo is unlimited.

Copyright Notice

   Copyright (C) The Internet Society (1998).  All Rights Reserved.

IESG Note

   This paper describes a "superset" of operations that can be applied
   to URI.  It consists of both a grammar and a description of basic
   functionality for URI.  To understand what is a valid URI, both the
   grammar and the associated description have to be studied.  Some of
   the functionality described is not applicable to all URI schemes, and
   some operations are only possible when certain media types are
   retrieved using the URI, regardless of the scheme used.

Abstract

   A Uniform Resource Identifier (URI) is a compact string of characters
   for identifying an abstract or physical resource.  This document
   defines the generic syntax of URI, including both absolute and
   relative forms, and guidelines for their use; it revises and replaces
   the generic definitions in RFC 1738 and RFC 1808.

   This document defines a grammar that is a superset of all valid URI,
   such that an implementation can parse the common components of a URI
   reference without knowing the scheme-specific requirements of every
   possible identifier type.  This document does not define a generative
   grammar for URI; that task will be performed by the individual
   specifications of each URI scheme.

   
Grammar in a broad sense fetched automatically on 1 October 2014 by Vadim Zaytsev, http://grammarware.net
