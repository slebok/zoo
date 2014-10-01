http://www.w3.org/Addressing/
	http://www.ietf.org/rfc/rfc3987.txt

Network Working Group                                          M. Duerst
Request for Comments: 3987                                           W3C
Category: Standards Track                                    M. Suignard
                                                   Microsoft Corporation
                                                            January 2005


             Internationalized Resource Identifiers (IRIs)

Status of This Memo

   This document specifies an Internet standards track protocol for the
   Internet community, and requests discussion and suggestions for
   improvements.  Please refer to the current edition of the "Internet
   Official Protocol Standards" (STD 1) for the standardization state
   and status of this protocol.  Distribution of this memo is unlimited.

Copyright Notice

   Copyright (C) The Internet Society (2005).

Abstract

   This document defines a new protocol element, the Internationalized
   Resource Identifier (IRI), as a complement to the Uniform Resource
   Identifier (URI).  An IRI is a sequence of characters from the
   Universal Character Set (Unicode/ISO 10646).  A mapping from IRIs to
   URIs is defined, which means that IRIs can be used instead of URIs,
   where appropriate, to identify resources.

   The approach of defining a new protocol element was chosen instead of
   extending or changing the definition of URIs.  This was done in order
   to allow a clear distinction and to avoid incompatibilities with
   existing software.  Guidelines are provided for the use and
   deployment of IRIs in various protocols, formats, and software
   components that currently deal with URIs.

      
Grammar in a broad sense fetched automatically on 1 October 2014 by Vadim Zaytsev, http://grammarware.net
