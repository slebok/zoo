http://www.w3.org/Addressing/
  http://www.ietf.org/rfc/rfc3986.txt

Network Working Group                                     T. Berners-Lee
Request for Comments: 3986                                       W3C/MIT
STD: 66                                                      R. Fielding
Updates: 1738                                               Day Software
Obsoletes: 2732, 2396, 1808                                  L. Masinter
Category: Standards Track                                  Adobe Systems
                                                            January 2005


           Uniform Resource Identifier (URI): Generic Syntax

Status of This Memo

   This document specifies an Internet standards track protocol for the
   Internet community, and requests discussion and suggestions for
   improvements.  Please refer to the current edition of the "Internet
   Official Protocol Standards" (STD 1) for the standardization state
   and status of this protocol.  Distribution of this memo is unlimited.

Copyright Notice

   Copyright (C) The Internet Society (2005).

Abstract

   A Uniform Resource Identifier (URI) is a compact sequence of
   characters that identifies an abstract or physical resource.  This
   specification defines the generic URI syntax and a process for
   resolving URI references that might be in relative form, along with
   guidelines and security considerations for the use of URIs on the
   Internet.  The URI syntax defines a grammar that is a superset of all
   valid URIs, allowing an implementation to parse the common components
   of a URI reference without knowing the scheme-specific requirements
   of every possible identifier.  This specification does not define a
   generative grammar for URIs; that task is performed by the individual
   specifications of each URI scheme.
   
Grammar in a broad sense fetched automatically on 1 October 2014 by Vadim Zaytsev, http://grammarware.net
