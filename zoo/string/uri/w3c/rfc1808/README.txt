http://www.w3.org/Addressing/
	http://www.w3.org/Addressing/rfc1808.txt

Network Working Group                                        R. Fielding
Request for Comments: 1808                                     UC Irvine
Category: Standards Track                                      June 1995


                   Relative Uniform Resource Locators

Status of this Memo

   This document specifies an Internet standards track protocol for the
   Internet community, and requests discussion and suggestions for
   improvements.  Please refer to the current edition of the "Internet
   Official Protocol Standards" (STD 1) for the standardization state
   and status of this protocol.  Distribution of this memo is unlimited.

Abstract

   A Uniform Resource Locator (URL) is a compact representation of the
   location and access method for a resource available via the Internet.
   When embedded within a base document, a URL in its absolute form may
   contain a great deal of information which is already known from the
   context of that base document's retrieval, including the scheme,
   network location, and parts of the url-path.  In situations where the
   base URL is well-defined and known to the parser (human or machine),
   it is useful to be able to embed URL references which inherit that
   context rather than re-specifying it in every instance.  This
   document defines the syntax and semantics for such Relative Uniform
   Resource Locators.

   
Grammar in a broad sense fetched automatically on 1 October 2014 by Vadim Zaytsev, http://grammarware.net
