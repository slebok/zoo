http://www.w3.org/Addressing/
	http://www.w3.org/Addressing/rfc1630.txt

Network Working Group                                     T. Berners-Lee
Request for Comments: 1630                                          CERN
Category: Informational                                        June 1994


                 Universal Resource Identifiers in WWW

                A Unifying Syntax for the Expression of
             Names and Addresses of Objects on the Network
                     as used in the World-Wide Web

Status of this Memo

   This memo provides information for the Internet community.  This memo
   does not specify an Internet standard of any kind.  Distribution of
   this memo is unlimited.

IESG Note:

   Note that the work contained in this memo does not describe an
   Internet standard.  An Internet standard for general Resource
   Identifiers is under development within the IETF.

Introduction

   This document defines the syntax used by the World-Wide Web
   initiative to encode the names and addresses of objects on the
   Internet.  The web is considered to include objects accessed using an
   extendable number of protocols, existing, invented for the web
   itself, or to be invented in the future.  Access instructions for an
   individual object under a given protocol are encoded into forms of
   address string.  Other protocols allow the use of object names of
   various forms.  In order to abstract the idea of a generic object,
   the web needs the concepts of the universal set of objects, and of
   the universal set of names or addresses of objects.

   A Universal Resource Identifier (URI) is a member of this universal
   set of names in registered name spaces and addresses referring to
   registered protocols or name spaces.  A Uniform Resource Locator
   (URL), defined elsewhere, is a form of URI which expresses an address
   which maps onto an access algorithm using network protocols. Existing
   URI schemes which correspond to the (still mutating) concept of IETF
   URLs are listed here. The Uniform Resource Name (URN) debate attempts
   to define a name space (and presumably resolution protocols) for
   persistent object names. This area is not addressed by this document,
   which is written in order to document existing practice and provide a
   reference point for URL and URN discussions.

Grammar in a broad sense fetched automatically on 1 October 2014 by Vadim Zaytsev, http://grammarware.net
