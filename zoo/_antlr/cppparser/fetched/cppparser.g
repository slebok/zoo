<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">
<head>
<link rel="icon" href="/main/static/hgicon.png" type="image/png" />
<meta name="robots" content="index, nofollow"/>
<link rel="stylesheet" href="/main/static/style-gitweb.css" type="text/css" />
<script src="https://netbeans.org/images_www/js/companion-projects.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="https://netbeans.org/netbeans3.css">

<title>main: cnd.modelimpl/src/org/netbeans/modules/cnd/modelimpl/parser/cppparser.g@3e1bf818cd27</title>
<link rel="alternate" type="application/atom+xml"
   href="/main/atom-log" title="Atom feed for main"/>
<link rel="alternate" type="application/rss+xml"
   href="/main/rss-log" title="RSS feed for main"/>
<link rel="stylesheet" type="text/css" href="https://netbeans.org/netbeans3.css">
</head>

<body  class="blue-bg">
<div id="wrapper-flex">
<div id="hdr">            
	<div id="navtabs">
		<a href="https://netbeans.org/"><img src="https://netbeans.org/images_www/v7/design/logo_netbeans_red.png" id="nblogo" width="130" height="32" alt="Logo Netbeans"/></a>
	</div>
</div>
<div id="navig-breadcrumbs"><a href="https://netbeans.org/">NetBeans.org</a> </div>
	<!-- start content area -->
			<div id="middle">
			<table class="colapse full-width f-page-table-2col"> <!-- main content table -->
			<tr>
			<td class="valign-top"><!-- main content cell, testwww page is here -->
			<div class="f-page-auto-cell" id="doc" >

<div class="page_header">
<a href="http://mercurial.selenic.com/" title="Mercurial" style="float: right;">Mercurial</a><a href="/main/summary">main</a> / file revision
</div>

<div class="page_nav">
<a href="/main/summary">summary</a> |
<a href="/main/shortlog">shortlog</a> |
<a href="/main/log">changelog</a> |
<a href="/main/graph">graph</a> |
<a href="/main/tags">tags</a> |
<a href="/main/branches">branches</a> |
<a href="/main/file/3e1bf818cd27/cnd.modelimpl/src/org/netbeans/modules/cnd/modelimpl/parser/">files</a> |
<a href="/main/rev/3e1bf818cd27">changeset</a> |
file |
<a href="/main/log/3e1bf818cd27/cnd.modelimpl/src/org/netbeans/modules/cnd/modelimpl/parser/cppparser.g">revisions</a> |
<a href="/main/annotate/3e1bf818cd27/cnd.modelimpl/src/org/netbeans/modules/cnd/modelimpl/parser/cppparser.g">annotate</a> |
<a href="/main/diff/3e1bf818cd27/cnd.modelimpl/src/org/netbeans/modules/cnd/modelimpl/parser/cppparser.g">diff</a> |
<a href="/main/raw-file/3e1bf818cd27/cnd.modelimpl/src/org/netbeans/modules/cnd/modelimpl/parser/cppparser.g">raw</a><br/>
</div>

<div class="title">cnd.modelimpl/src/org/netbeans/modules/cnd/modelimpl/parser/cppparser.g</div>

<div class="title_text">
<table cellspacing="0">
<tr>
 <td>author</td>
 <td>&#102;&#102;&#106;&#114;&#101;&#64;&#110;&#101;&#116;&#98;&#101;&#97;&#110;&#115;&#46;&#111;&#114;&#103;</td></tr>
<tr>
 <td></td>
 <td>Tue Sep 23 00:08:27 2014 +0000 (15 hours ago)</td></tr>

<tr>
 <td>changeset 278965</td>
 <td style="font-family:monospace"><a class="list" href="/main/rev/3e1bf818cd27">3e1bf818cd27</a></td></tr>

<tr>
<td>parent 277062</td>
<td style="font-family:monospace">
<a class="list" href="/main/file/f145e0e0cf38/cnd.modelimpl/src/org/netbeans/modules/cnd/modelimpl/parser/cppparser.g">
f145e0e0cf38
</a>
</td>
</tr>

<tr>
 <td>permissions</td>
 <td style="font-family:monospace">-rw-r--r--</td></tr>
</table>
</div>

<div class="page_path">
Automated merge with main-silver
</div>

<div class="page_body">

<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1" id="l1">     1</a> /*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2" id="l2">     2</a>  * PUBLIC DOMAIN PCCTS-BASED C++ GRAMMAR (cplusplus.g, stat.g, expr.g)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3" id="l3">     3</a>  *
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4" id="l4">     4</a>  * Authors: Sumana Srinivasan, NeXT Inc.;            sumana_srinivasan@next.com
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l5" id="l5">     5</a>  *          Terence Parr, Parr Research Corporation; parrt@parr-research.com
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l6" id="l6">     6</a>  *          Russell Quong, Purdue University;        quong@ecn.purdue.edu
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l7" id="l7">     7</a>  *
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l8" id="l8">     8</a>  * VERSION 1.2
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l9" id="l9">     9</a>  *
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l10" id="l10">    10</a>  * SOFTWARE RIGHTS
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l11" id="l11">    11</a>  *
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l12" id="l12">    12</a>  * This file is a part of the ANTLR-based C++ grammar and is free
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l13" id="l13">    13</a>  * software.  We do not reserve any LEGAL rights to its use or
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l14" id="l14">    14</a>  * distribution, but you may NOT claim ownership or authorship of this
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l15" id="l15">    15</a>  * grammar or support code.  An individual or company may otherwise do
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l16" id="l16">    16</a>  * whatever they wish with the grammar distributed herewith including the
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l17" id="l17">    17</a>  * incorporation of the grammar or the output generated by ANTLR into
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l18" id="l18">    18</a>  * commerical software.  You may redistribute in source or binary form
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l19" id="l19">    19</a>  * without payment of royalties to us as long as this header remains
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l20" id="l20">    20</a>  * in all source distributions.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l21" id="l21">    21</a>  *
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l22" id="l22">    22</a>  * We encourage users to develop parsers/tools using this grammar.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l23" id="l23">    23</a>  * In return, we ask that credit is given to us for developing this
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l24" id="l24">    24</a>  * grammar.  By &quot;credit&quot;, we mean that if you incorporate our grammar or
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l25" id="l25">    25</a>  * the generated code into one of your programs (commercial product,
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l26" id="l26">    26</a>  * research project, or otherwise) that you acknowledge this fact in the
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l27" id="l27">    27</a>  * documentation, research report, etc....  In addition, you should say nice
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l28" id="l28">    28</a>  * things about us at every opportunity.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l29" id="l29">    29</a>  *
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l30" id="l30">    30</a>  * As long as these guidelines are kept, we expect to continue enhancing
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l31" id="l31">    31</a>  * this grammar.  Feel free to send us enhancements, fixes, bug reports,
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l32" id="l32">    32</a>  * suggestions, or general words of encouragement at parrt@parr-research.com.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l33" id="l33">    33</a>  * 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l34" id="l34">    34</a>  * NeXT Computer Inc.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l35" id="l35">    35</a>  * 900 Chesapeake Dr.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l36" id="l36">    36</a>  * Redwood City, CA 94555
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l37" id="l37">    37</a>  * 12/02/1994
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l38" id="l38">    38</a>  * 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l39" id="l39">    39</a>  * Restructured for public consumption by Terence Parr late February, 1995.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l40" id="l40">    40</a>  *
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l41" id="l41">    41</a>  * DISCLAIMER: we make no guarantees that this grammar works, makes sense,
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l42" id="l42">    42</a>  *             or can be used to do anything useful.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l43" id="l43">    43</a>  */
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l44" id="l44">    44</a> /* 2001-2002
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l45" id="l45">    45</a>  * Version 1.0
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l46" id="l46">    46</a>  * This C++ grammar file has been converted from PCCTS to run under 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l47" id="l47">    47</a>  *  ANTLR to generate lexer and parser in C++ code by
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l48" id="l48">    48</a>  *  Jianguo Zuo and David Wigg at
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l49" id="l49">    49</a>  *  The Centre for Systems and Software Engineering
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l50" id="l50">    50</a>  *  London South Bank University
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l51" id="l51">    51</a>  *  London, UK.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l52" id="l52">    52</a>  *
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l53" id="l53">    53</a>  */
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l54" id="l54">    54</a> /* 2003
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l55" id="l55">    55</a>  * Version 2.0 was published by David Wigg in September 2003
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l56" id="l56">    56</a>  */
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l57" id="l57">    57</a> /* 2004
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l58" id="l58">    58</a>  * Version 3.0 July 2004
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l59" id="l59">    59</a>  * This is version 3.0 of the C++ grammar definition for ANTLR to 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l60" id="l60">    60</a>  *  generate lexer and parser in C++ code updated by
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l61" id="l61">    61</a>  *  David Wigg at
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l62" id="l62">    62</a>  *  The Centre for Systems and Software Engineering
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l63" id="l63">    63</a>  *  London South Bank University
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l64" id="l64">    64</a>  *  London, UK.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l65" id="l65">    65</a>  *
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l66" id="l66">    66</a>  * wiggjd@bcs.ac.uk
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l67" id="l67">    67</a>  * blackse@lsbu.ac.uk
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l68" id="l68">    68</a>  *
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l69" id="l69">    69</a>  * See MyReadMe.txt for further information
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l70" id="l70">    70</a>  *
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l71" id="l71">    71</a>  * This file is best viewed in courier font with tabs set to 4 spaces
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l72" id="l72">    72</a>  */
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l73" id="l73">    73</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l74" id="l74">    74</a> /* 2005
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l75" id="l75">    75</a>  * Some modifications were made by Gordon Prieur (Gordon.Prieur@sun.com);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l76" id="l76">    76</a>  * after that the grammar was ported to Java by Vladimir Kvashin (Vladimir.Kvashin@sun.com)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l77" id="l77">    77</a>  *
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l78" id="l78">    78</a>  * NOCDDL
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l79" id="l79">    79</a>  */
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l80" id="l80">    80</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l81" id="l81">    81</a> header {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l82" id="l82">    82</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l83" id="l83">    83</a> package org.netbeans.modules.cnd.modelimpl.parser.generated;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l84" id="l84">    84</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l85" id="l85">    85</a> import java.io.*;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l86" id="l86">    86</a> import java.util.*;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l87" id="l87">    87</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l88" id="l88">    88</a> import org.netbeans.modules.cnd.antlr.*;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l89" id="l89">    89</a> import org.netbeans.modules.cnd.antlr.collections.*;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l90" id="l90">    90</a> import org.netbeans.modules.cnd.antlr.debug.misc.*;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l91" id="l91">    91</a> import org.netbeans.modules.cnd.modelimpl.parser.*;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l92" id="l92">    92</a> import org.netbeans.modules.cnd.modelimpl.parser.Enum;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l93" id="l93">    93</a> import org.netbeans.modules.cnd.modelimpl.debug.*;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l94" id="l94">    94</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l95" id="l95">    95</a> }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l96" id="l96">    96</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l97" id="l97">    97</a> options {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l98" id="l98">    98</a> 	language = &quot;Java&quot;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l99" id="l99">    99</a> } 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l100" id="l100">   100</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l101" id="l101">   101</a> {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l102" id="l102">   102</a> @SuppressWarnings({&quot;unchecked&quot;, &quot;cast&quot;, &quot;fallthrough&quot;})
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l103" id="l103">   103</a> }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l104" id="l104">   104</a> class CPPParser extends Parser;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l105" id="l105">   105</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l106" id="l106">   106</a> options {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l107" id="l107">   107</a> 	k = 2;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l108" id="l108">   108</a> 	importVocab = APT;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l109" id="l109">   109</a> 	exportVocab = CPP;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l110" id="l110">   110</a> 	codeGenMakeSwitchThreshold = 2;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l111" id="l111">   111</a> 	codeGenBitsetTestThreshold = 3;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l112" id="l112">   112</a> 	noConstructors = true;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l113" id="l113">   113</a> 	buildAST = true;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l114" id="l114">   114</a>         genASTClassMap = false;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l115" id="l115">   115</a> }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l116" id="l116">   116</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l117" id="l117">   117</a> //
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l118" id="l118">   118</a> // We create CsmAST node for each token,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l119" id="l119">   119</a> // which isn't dummy - i.e. which has an appropriate text in translation unit.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l120" id="l120">   120</a> // Examples are  CSM_USING_DIRECTIVE and CSM_USING_DECLARATION
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l121" id="l121">   121</a> //
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l122" id="l122">   122</a> tokens {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l123" id="l123">   123</a>         CSM_START&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;; // dummy token - should be BEFORE ALL CSM_...
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l124" id="l124">   124</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l125" id="l125">   125</a> 	CSM_TRANSLATION_UNIT&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l126" id="l126">   126</a> 	CSM_CLASS_DECLARATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l127" id="l127">   127</a> 	CSM_ENUM_DECLARATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l128" id="l128">   128</a> 	CSM_ENUM_FWD_DECLARATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l129" id="l129">   129</a> 	CSM_NAMESPACE_DECLARATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.NamedFakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l130" id="l130">   130</a> 	CSM_CTOR_DECLARATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l131" id="l131">   131</a> 	CSM_CTOR_TEMPLATE_DECLARATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l132" id="l132">   132</a> 	CSM_FUNCTION_DECLARATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l133" id="l133">   133</a> 	CSM_FUNCTION_LIKE_VARIABLE_DECLARATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l134" id="l134">   134</a> 	CSM_FUNCTION_DEFINITION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l135" id="l135">   135</a> 	CSM_FUNCTION_RET_FUN_DECLARATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l136" id="l136">   136</a> 	CSM_FUNCTION_RET_FUN_DEFINITION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l137" id="l137">   137</a> 	CSM_FUNCTION_TEMPLATE_DECLARATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l138" id="l138">   138</a> 	CSM_FUNCTION_TEMPLATE_DEFINITION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l139" id="l139">   139</a> 	CSM_PARAMETER_DECLARATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l140" id="l140">   140</a> 	CSM_TYPE_BUILTIN&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l141" id="l141">   141</a>         CSM_TYPE_DECLTYPE&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l142" id="l142">   142</a> 	CSM_TYPE_COMPOUND&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l143" id="l143">   143</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l144" id="l144">   144</a> 	CSM_TEMPLATE_EXPLICIT_SPECIALIZATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l145" id="l145">   145</a> 	CSM_FWD_TEMPLATE_EXPLICIT_SPECIALIZATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l146" id="l146">   146</a> 	CSM_TEMPLATE_EXPLICIT_INSTANTIATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l147" id="l147">   147</a> 	CSM_TEMPLATE_CTOR_DEFINITION_EXPLICIT_SPECIALIZATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l148" id="l148">   148</a> 	CSM_TEMPLATE_DTOR_DEFINITION_EXPLICIT_SPECIALIZATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l149" id="l149">   149</a> 	CSM_TEMPLATE_FUNCTION_DEFINITION_EXPLICIT_SPECIALIZATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l150" id="l150">   150</a>         CSM_USER_TYPE_CAST_DEFINITION_EXPLICIT_SPECIALIZATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l151" id="l151">   151</a> 	CSM_TEMPLATE_CLASS_DECLARATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l152" id="l152">   152</a> 	CSM_EXTERN_TEMPLATE&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l153" id="l153">   153</a> 	CSM_TEMPLATE_TEMPLATE_PARAMETER&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l154" id="l154">   154</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l155" id="l155">   155</a> 	CSM_DTOR_DEFINITION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l156" id="l156">   156</a> 	CSM_DTOR_TEMPLATE_DEFINITION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l157" id="l157">   157</a> 	CSM_DTOR_DECLARATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l158" id="l158">   158</a> 	CSM_CTOR_DEFINITION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l159" id="l159">   159</a> 	CSM_CTOR_TEMPLATE_DEFINITION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l160" id="l160">   160</a> 	CSM_USER_TYPE_CAST_DECLARATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l161" id="l161">   161</a> 	CSM_USER_TYPE_CAST_TEMPLATE_DECLARATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l162" id="l162">   162</a> 	CSM_USER_TYPE_CAST_DEFINITION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l163" id="l163">   163</a> 	CSM_USER_TYPE_CAST_TEMPLATE_DEFINITION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l164" id="l164">   164</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l165" id="l165">   165</a> 	CSM_GENERIC_DECLARATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l166" id="l166">   166</a> 	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l167" id="l167">   167</a> 	CSM_TEMPL_FWD_CL_OR_STAT_MEM&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l168" id="l168">   168</a> 	CSM_STRANGE_2&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l169" id="l169">   169</a> 	CSM_FIELD&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l170" id="l170">   170</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l171" id="l171">   171</a> 	CSM_VISIBILITY_REDEF&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.NamedFakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l172" id="l172">   172</a> 	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l173" id="l173">   173</a> 	CSM_TEMPLATE_PARMLIST&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l174" id="l174">   174</a> 	CSM_PARMLIST&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l175" id="l175">   175</a> 	CSM_KR_PARMLIST&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l176" id="l176">   176</a> 	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l177" id="l177">   177</a> 	CSM_ENUMERATOR_LIST&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l178" id="l178">   178</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l179" id="l179">   179</a> 	CSM_NAMESPACE_ALIAS&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.NamedFakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l180" id="l180">   180</a> 	CSM_USING_DIRECTIVE&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.NamedFakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l181" id="l181">   181</a> 	CSM_USING_DECLARATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.NamedFakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l182" id="l182">   182</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l183" id="l183">   183</a>         CSM_CTOR_INITIALIZER&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l184" id="l184">   184</a>         CSM_CTOR_INITIALIZER_LIST&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l185" id="l185">   185</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l186" id="l186">   186</a> 	CSM_QUALIFIED_ID&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.NamedFakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l187" id="l187">   187</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l188" id="l188">   188</a> 	////////// STATEMENTS //////////
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l189" id="l189">   189</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l190" id="l190">   190</a> 	// This is just a start marker of the token types, related with statements
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l191" id="l191">   191</a> 	// Do NOT create tokens of this type
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l192" id="l192">   192</a> 	// Place token types, which correspond to statements only AFTER this type
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l193" id="l193">   193</a> 	// (but BEFORE CSM_STATEMENTS_END)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l194" id="l194">   194</a> 	CSM_STATEMENTS_START&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l195" id="l195">   195</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l196" id="l196">   196</a> 	CSM_LABELED_STATEMENT&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l197" id="l197">   197</a> 	CSM_CASE_STATEMENT&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l198" id="l198">   198</a> 	CSM_DEFAULT_STATEMENT&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l199" id="l199">   199</a> 	CSM_EXPRESSION_STATEMENT&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l200" id="l200">   200</a> 	CSM_DECLARATION_STATEMENT&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l201" id="l201">   201</a> 	CSM_COMPOUND_STATEMENT&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l202" id="l202">   202</a>     CSM_COMPOUND_STATEMENT_LAZY&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l203" id="l203">   203</a>     CSM_TRY_CATCH_STATEMENT_LAZY&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l204" id="l204">   204</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l205" id="l205">   205</a> 	// selection
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l206" id="l206">   206</a> 	CSM_IF_STATEMENT&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l207" id="l207">   207</a> 	CSM_SWITCH_STATEMENT&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l208" id="l208">   208</a> 	// iteration
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l209" id="l209">   209</a> 	CSM_WHILE_STATEMENT&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l210" id="l210">   210</a> 	CSM_DO_WHILE_STATEMENT&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l211" id="l211">   211</a> 	CSM_FOR_STATEMENT&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l212" id="l212">   212</a> 	// jump
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l213" id="l213">   213</a> 	CSM_GOTO_STATEMENT&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l214" id="l214">   214</a> 	CSM_CONTINUE_STATEMENT&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l215" id="l215">   215</a> 	CSM_BREAK_STATEMENT&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l216" id="l216">   216</a> 	CSM_RETURN_STATEMENT&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l217" id="l217">   217</a> 	// try-catch
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l218" id="l218">   218</a>     CSM_TRY_STATEMENT&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l219" id="l219">   219</a>     CSM_CATCH_CLAUSE&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l220" id="l220">   220</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l221" id="l221">   221</a> 	CSM_THROW_STATEMENT&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l222" id="l222">   222</a> 	CSM_ASM_BLOCK&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l223" id="l223">   223</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l224" id="l224">   224</a> 	// This is just an end marker of the token types, related with statements
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l225" id="l225">   225</a> 	// Do NOT create tokens of this type
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l226" id="l226">   226</a> 	// Place token types, which correspond to statements only BEFORE this type
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l227" id="l227">   227</a> 	// (but AFTER CSM_STATEMENTS_START)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l228" id="l228">   228</a> 	CSM_STATEMENTS_END&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l229" id="l229">   229</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l230" id="l230">   230</a> 	////////// EXPRESSIONS //////////
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l231" id="l231">   231</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l232" id="l232">   232</a> 	// This is just a start marker of the token types, related with expressions
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l233" id="l233">   233</a> 	// Do NOT create tokens of this type
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l234" id="l234">   234</a> 	// Place token types, which correspond to expressions only AFTER this type
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l235" id="l235">   235</a> 	// (but BEFORE CSM_EXPRESSIONS_END)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l236" id="l236">   236</a> 	CSM_EXPRESSIONS_START&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l237" id="l237">   237</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l238" id="l238">   238</a> 	// temporary solution
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l239" id="l239">   239</a> 	// to wrap all expressions 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l240" id="l240">   240</a> 	CSM_EXPRESSION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l241" id="l241">   241</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l242" id="l242">   242</a>         // cast
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l243" id="l243">   243</a>         CSM_CAST_EXPRESSION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l244" id="l244">   244</a>         CSM_FUN_TYPE_CAST_EXPRESSION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l245" id="l245">   245</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l246" id="l246">   246</a>         // function call
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l247" id="l247">   247</a>         CSM_FUNCALL_EXPRESSION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l248" id="l248">   248</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l249" id="l249">   249</a> 	// This is just an end marker of the token types, related with expressions
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l250" id="l250">   250</a> 	// Do NOT create tokens of this type
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l251" id="l251">   251</a> 	// Place token types, which correspond to expressions only BEFORE this type
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l252" id="l252">   252</a> 	// (but AFTER CSM_EXPRESSIONS_START)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l253" id="l253">   253</a> 	CSM_EXPRESSIONS_END&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l254" id="l254">   254</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l255" id="l255">   255</a> 	//////////  //////////
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l256" id="l256">   256</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l257" id="l257">   257</a> 	CSM_FOR_INIT_STATEMENT&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l258" id="l258">   258</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l259" id="l259">   259</a> 	CSM_LINKAGE_SPECIFICATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l260" id="l260">   260</a> 	CSM_PTR_OPERATOR&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l261" id="l261">   261</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l262" id="l262">   262</a> 	CSM_ARRAY_DECLARATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l263" id="l263">   263</a> 	CSM_VARIABLE_DECLARATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l264" id="l264">   264</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l265" id="l265">   265</a> 	CSM_VARIABLE_LIKE_FUNCTION_DECLARATION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l266" id="l266">   266</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l267" id="l267">   267</a> 	CSM_CONDITION&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l268" id="l268">   268</a> 	CSM_BASE_SPECIFIER&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l269" id="l269">   269</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l270" id="l270">   270</a> 	CSM_TEST&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l271" id="l271">   271</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l272" id="l272">   272</a> 	CSM_END&lt;AST=org.netbeans.modules.cnd.modelimpl.parser.FakeAST&gt;; // dummy token - should be AFTER ALL CSM_...
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l273" id="l273">   273</a> }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l274" id="l274">   274</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l275" id="l275">   275</a> {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l276" id="l276">   276</a>     private CppParserAction action;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l277" id="l277">   277</a>     protected CPPParser(TokenStream stream, CppParserAction action) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l278" id="l278">   278</a>         this(stream);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l279" id="l279">   279</a>         this.action = action;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l280" id="l280">   280</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l281" id="l281">   281</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l282" id="l282">   282</a>     // Defines for flags passed to init methods
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l283" id="l283">   283</a>     public static final int CPP_STATEMENT_TRACE		= 0x1;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l284" id="l284">   284</a>     public static final int CPP_STATEMENT_TRACE_VERBOSE = 0x2;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l285" id="l285">   285</a>     public static final int CPP_SUPPRESS_ERRORS		= 0x4;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l286" id="l286">   286</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l287" id="l287">   287</a>     public static final int CPP_CPLUSPLUS		= 0x8;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l288" id="l288">   288</a>     public static final int CPP_ANSI_C			= 0x10;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l289" id="l289">   289</a>     public static final int CPP_KandR_C			= 0x20;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l290" id="l290">   290</a>     
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l291" id="l291">   291</a>     public static final int CPP_FLAVOR_CPP11            = 0x40;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l292" id="l292">   292</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l293" id="l293">   293</a>     /** Switches legacy warnings on */
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l294" id="l294">   294</a>     protected static final boolean reportOddWarnings = Boolean.getBoolean(&quot;cnd.parser.odd.warnings&quot;);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l295" id="l295">   295</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l296" id="l296">   296</a>     protected void addNewFold(int type, int startLnum, int startOffset, int endLnum, int endOffset) {}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l297" id="l297">   297</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l298" id="l298">   298</a>     //	The statements in this block appear only in CPPParser.cpp and not in CPPLexer.cpp
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l299" id="l299">   299</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l300" id="l300">   300</a>     public static final
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l301" id="l301">   301</a>     int statementTrace = 0;	// Used to control selected (level) tracing (see support.cpp)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l302" id="l302">   302</a> 				// 1 Shows which external and member statements selected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l303" id="l303">   303</a> 				// 2 Shows above plus all declarations/definitions
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l304" id="l304">   304</a> 				// 3 reserved for future use
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l305" id="l305">   305</a> 				// 4 and above available for user
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l306" id="l306">   306</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l307" id="l307">   307</a>      protected boolean isLazyCompound() {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l308" id="l308">   308</a>         return false;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l309" id="l309">   309</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l310" id="l310">   310</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l311" id="l311">   311</a>     protected void init(String filename, int flags) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l312" id="l312">   312</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l313" id="l313">   313</a> 	setFilename(filename);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l314" id="l314">   314</a> 	//
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l315" id="l315">   315</a> 	// Creates a dictionary to hold symbols with 4001 buckets, 200 scopes
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l316" id="l316">   316</a> 	// and 800,000 characters // These can be changed to suit the size of
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l317" id="l317">   317</a> 	// program(s) being parsed.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l318" id="l318">   318</a> 	//symbols = new CPPDictionary(4001, 200, 800000);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l319" id="l319">   319</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l320" id="l320">   320</a> 	// Set template parameter and external scopes. Set template parameter scope to 0.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l321" id="l321">   321</a> 	//templateParameterScope = symbols-&gt;getCurrentScopeIndex();
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l322" id="l322">   322</a> 	//symbols-&gt;saveScope();	// Advance currentScope from 0 to 1
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l323" id="l323">   323</a> 	//externalScope = symbols-&gt;getCurrentScopeIndex();	// Set external scope to 1
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l324" id="l324">   324</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l325" id="l325">   325</a> 	// Declare predefined scope &quot;std&quot; in external scope
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l326" id="l326">   326</a> 	//CPPSymbol *a = new CPPSymbol(&quot;std&quot;, CPPSymbol::otTypedef);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l327" id="l327">   327</a> 	//symbols-&gt;define(&quot;std&quot;, a);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l328" id="l328">   328</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l329" id="l329">   329</a> 	// Global flags to allow for nested declarations
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l330" id="l330">   330</a> 	_td = false;		// For typedef
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l331" id="l331">   331</a> 	_fd = false;		// For friend
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l332" id="l332">   332</a> 	_sc = scInvalid;	// For StorageClass
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l333" id="l333">   333</a> 	_tq = tqInvalid;	// For TypeQualifier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l334" id="l334">   334</a> 	_ts = tsInvalid;	// For TypeSpecifier
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l335" id="l335">   335</a> 	_ds = dsInvalid;	// For DeclSpecifier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l336" id="l336">   336</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l337" id="l337">   337</a> 	//functionDefinition = 0;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l338" id="l338">   338</a> 	qualifierPrefix = new StringBuilder();
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l339" id="l339">   339</a> 	enclosingClass = &quot;&quot;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l340" id="l340">   340</a> 	assign_stmt_RHS_found = 0;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l341" id="l341">   341</a> 	in_parameter_list = false;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l342" id="l342">   342</a> 	K_and_R = false;	// used to distinguish old K &amp; R parameter definitions
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l343" id="l343">   343</a> 	in_return = false;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l344" id="l344">   344</a> 	is_address = false;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l345" id="l345">   345</a> 	is_pointer = false;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l346" id="l346">   346</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l347" id="l347">   347</a> 	/*if ((flags &amp; CPP_STATEMENT_TRACE) &gt; 0) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l348" id="l348">   348</a> 	    statementTrace = 1;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l349" id="l349">   349</a> 	}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l350" id="l350">   350</a> 	if ((flags &amp; CPP_STATEMENT_TRACE_VERBOSE) &gt; 0) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l351" id="l351">   351</a> 	    statementTrace = 2;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l352" id="l352">   352</a> 	}*/
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l353" id="l353">   353</a> 	if ((flags &amp; CPP_SUPPRESS_ERRORS) &gt; 0) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l354" id="l354">   354</a> 	    reportErrors = false;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l355" id="l355">   355</a> 	}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l356" id="l356">   356</a> 	if ((flags &amp; CPP_CPLUSPLUS) &gt; 0) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l357" id="l357">   357</a> 	    lang = CPLUSPLUS;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l358" id="l358">   358</a> 	} else if ((flags &amp; CPP_ANSI_C) &gt; 0) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l359" id="l359">   359</a> 	    lang = ANSI_C;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l360" id="l360">   360</a> 	} else if (CPP_KandR_C &gt; 0) { // VK: looks strange; well leave for a while
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l361" id="l361">   361</a> 	    lang = KandR_C;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l362" id="l362">   362</a> 	} else {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l363" id="l363">   363</a> 	    lang = UNKNOWN_LANG;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l364" id="l364">   364</a> 	}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l365" id="l365">   365</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l366" id="l366">   366</a>         if ((flags &amp; CPP_FLAVOR_CPP11) &gt; 0) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l367" id="l367">   367</a>             langFlavor = FLAVOR_CPP11;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l368" id="l368">   368</a>         } else {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l369" id="l369">   369</a>             langFlavor = FLAVOR_UNKNOWN;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l370" id="l370">   370</a>         }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l371" id="l371">   371</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l372" id="l372">   372</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l373" id="l373">   373</a>     boolean isCPlusPlus() {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l374" id="l374">   374</a> 	return lang == CPLUSPLUS;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l375" id="l375">   375</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l376" id="l376">   376</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l377" id="l377">   377</a>     boolean isCPlusPlus11() {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l378" id="l378">   378</a>         return isCPlusPlus() &amp;&amp; langFlavor == FLAVOR_CPP11;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l379" id="l379">   379</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l380" id="l380">   380</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l381" id="l381">   381</a>     boolean isC() {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l382" id="l382">   382</a>         return lang == ANSI_C;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l383" id="l383">   383</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l384" id="l384">   384</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l385" id="l385">   385</a> 	protected static final int tsInvalid   = 0x0;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l386" id="l386">   386</a> 	protected static final int tsVOID      = 0x1;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l387" id="l387">   387</a> 	protected static final int tsCHAR      = 0x2;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l388" id="l388">   388</a> 	protected static final int tsSHORT     = 0x4;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l389" id="l389">   389</a> 	protected static final int tsINT       = 0x8;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l390" id="l390">   390</a> 	protected static final int tsLONG      = 0x10;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l391" id="l391">   391</a> 	protected static final int tsFLOAT     = 0x20;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l392" id="l392">   392</a> 	protected static final int tsDOUBLE    = 0x40;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l393" id="l393">   393</a> 	protected static final int tsSIGNED    = 0x80;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l394" id="l394">   394</a> 	protected static final int tsUNSIGNED  = 0x100;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l395" id="l395">   395</a> 	protected static final int tsTYPEID    = 0x200;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l396" id="l396">   396</a> 	protected static final int tsSTRUCT    = 0x400;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l397" id="l397">   397</a> 	protected static final int tsENUM      = 0x800;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l398" id="l398">   398</a> 	protected static final int tsUNION     = 0x1000;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l399" id="l399">   399</a> 	protected static final int tsCLASS     = 0x2000;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l400" id="l400">   400</a> 	protected static final int tsWCHAR_T   = 0x4000;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l401" id="l401">   401</a> 	protected static final int tsBOOL      = 0x8000;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l402" id="l402">   402</a> 	protected static final int tsCOMPLEX   = 0x10000;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l403" id="l403">   403</a> 	protected static final int tsIMAGINARY = 0x20000;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l404" id="l404">   404</a>         protected static final int tsAUTO      = 0x40000; // c++11 auto type specifier
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l405" id="l405">   405</a>         protected static final int tsOTHER     = 0x80000;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l406" id="l406">   406</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l407" id="l407">   407</a> 	public static class TypeQualifier extends Enum { public TypeQualifier(String id) { super(id); } }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l408" id="l408">   408</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l409" id="l409">   409</a> 	protected static final TypeQualifier tqInvalid = new TypeQualifier(&quot;tqInvalid&quot;);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l410" id="l410">   410</a> 	protected static final TypeQualifier tqCONST = new TypeQualifier(&quot;tqCONST&quot;);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l411" id="l411">   411</a> 	protected static final TypeQualifier tqVOLATILE = new TypeQualifier(&quot;tqVOLATILE&quot;);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l412" id="l412">   412</a> 	protected static final TypeQualifier tqCDECL = new TypeQualifier(&quot;tqCDECL&quot;);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l413" id="l413">   413</a> 	protected static final TypeQualifier tqOTHER = new TypeQualifier(&quot;tqOTHER&quot;);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l414" id="l414">   414</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l415" id="l415">   415</a> 	public static class StorageClass extends Enum { public StorageClass(String id) { super(id); } }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l416" id="l416">   416</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l417" id="l417">   417</a> 	protected static final StorageClass scInvalid = new StorageClass(&quot;scInvalid&quot;);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l418" id="l418">   418</a> 	protected static final StorageClass scAUTO = new StorageClass(&quot;scAUTO&quot;);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l419" id="l419">   419</a> 	protected static final StorageClass scREGISTER = new StorageClass(&quot;scREGISTER&quot;);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l420" id="l420">   420</a> 	protected static final StorageClass scSTATIC = new StorageClass(&quot;scSTATIC&quot;);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l421" id="l421">   421</a> 	protected static final StorageClass scEXTERN = new StorageClass(&quot;scEXTERN&quot;);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l422" id="l422">   422</a> 	protected static final StorageClass scMUTABLE = new StorageClass(&quot;scMUTABLE&quot;);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l423" id="l423">   423</a> 	protected static final StorageClass scTHREAD = new StorageClass(&quot;scTHREAD&quot;);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l424" id="l424">   424</a> 	protected static final StorageClass scOTHER = new StorageClass(&quot;scOTHER&quot;);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l425" id="l425">   425</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l426" id="l426">   426</a> 	public static class DeclSpecifier extends Enum { public DeclSpecifier(String id) { super(id); } }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l427" id="l427">   427</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l428" id="l428">   428</a> 	protected static final DeclSpecifier dsInvalid = new DeclSpecifier(&quot;dsInvalid&quot;);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l429" id="l429">   429</a> 	protected static final DeclSpecifier dsVIRTUAL = new DeclSpecifier(&quot;dsVIRTUAL&quot;);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l430" id="l430">   430</a> 	protected static final DeclSpecifier dsINLINE = new DeclSpecifier(&quot;dsINLINE&quot;);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l431" id="l431">   431</a> 	protected static final DeclSpecifier dsEXPLICIT = new DeclSpecifier(&quot;dsEXPLICIT&quot;);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l432" id="l432">   432</a> 	protected static final DeclSpecifier dsFRIEND = new DeclSpecifier(&quot;dsFRIEND&quot;);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l433" id="l433">   433</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l434" id="l434">   434</a>         protected static final String LITERAL_EXEC = &quot;EXEC&quot;;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l435" id="l435">   435</a>         protected static final String LITERAL_SQL = &quot;SQL&quot;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l436" id="l436">   436</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l437" id="l437">   437</a> 	// typedef int QualifiedItem;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l438" id="l438">   438</a> 	protected static final int qiInvalid     = 0x0;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l439" id="l439">   439</a> 	protected static final int qiType        = 0x1;	// includes enum, class, typedefs, namespace
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l440" id="l440">   440</a> 	protected static final int qiDtor        = 0x2;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l441" id="l441">   441</a> 	protected static final int qiCtor        = 0x4;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l442" id="l442">   442</a> 	protected static final int qiOperator    = 0x8;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l443" id="l443">   443</a> 	protected static final int qiPtrMember   = 0x10;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l444" id="l444">   444</a> 	protected static final int qiVar         = 0x20;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l445" id="l445">   445</a> 	protected static final int qiFun         = 0x40;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l446" id="l446">   446</a> 	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l447" id="l447">   447</a> 	// Language Definitions
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l448" id="l448">   448</a> 	// TODO: what's the difference with the above constants (CPP_ANSI_C, etc)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l449" id="l449">   449</a> 	protected static final  int UNKNOWN_LANG	= 0x0;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l450" id="l450">   450</a> 	protected static final  int CPLUSPLUS	= 0x2;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l451" id="l451">   451</a> 	protected static final  int ANSI_C	= 0x4;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l452" id="l452">   452</a> 	protected static final  int KandR_C	= 0x8;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l453" id="l453">   453</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l454" id="l454">   454</a>         // Language Flavors
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l455" id="l455">   455</a>         protected static final  int FLAVOR_UNKNOWN  = 0x0;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l456" id="l456">   456</a>         protected static final  int FLAVOR_CPP11    = 0x1;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l457" id="l457">   457</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l458" id="l458">   458</a>         protected static final int ERROR_LIMIT = 100;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l459" id="l459">   459</a> 	private int errorCount = 0;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l460" id="l460">   460</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l461" id="l461">   461</a>     protected static final int declOther = 0;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l462" id="l462">   462</a>     protected static final int declStatement = 1;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l463" id="l463">   463</a>     protected static final int declGeneric = 2;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l464" id="l464">   464</a>     protected static final int declNotFirst = 3;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l465" id="l465">   465</a>     protected static final int declFunctionParam = 4;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l466" id="l466">   466</a>     protected static final int declExternFunction = 5;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l467" id="l467">   467</a>     protected static final int declSimpleFunction = 6;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l468" id="l468">   468</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l469" id="l469">   469</a> 	public int getErrorCount() {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l470" id="l470">   470</a> 	    int cnt = errorCount;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l471" id="l471">   471</a> 	    return cnt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l472" id="l472">   472</a> 	}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l473" id="l473">   473</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l474" id="l474">   474</a>         public boolean shouldProceed() {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l475" id="l475">   475</a>             boolean res = errorCount &lt; ERROR_LIMIT;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l476" id="l476">   476</a>             if (!res) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l477" id="l477">   477</a>                 reportError(&quot;Too many errors. Parsing is being stopped.&quot;); // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l478" id="l478">   478</a>             }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l479" id="l479">   479</a>             return res;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l480" id="l480">   480</a>         }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l481" id="l481">   481</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l482" id="l482">   482</a> 	public void reportError(RecognitionException e) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l483" id="l483">   483</a>             // Do not report errors that we had reported already
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l484" id="l484">   484</a>             if (lastRecoveryPosition == input.index()) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l485" id="l485">   485</a>                 return;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l486" id="l486">   486</a>             }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l487" id="l487">   487</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l488" id="l488">   488</a>             onError(e);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l489" id="l489">   489</a>             
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l490" id="l490">   490</a>             if (Diagnostic.needStatistics()) Diagnostic.onParserError(e);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l491" id="l491">   491</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l492" id="l492">   492</a> 	    if (reportErrors) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l493" id="l493">   493</a>                 if (TraceFlags.DEBUG) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l494" id="l494">   494</a>                     e.printStackTrace(System.err);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l495" id="l495">   495</a>                 } else {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l496" id="l496">   496</a>                     super.reportError(e);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l497" id="l497">   497</a>                 }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l498" id="l498">   498</a> 	    }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l499" id="l499">   499</a> 	    errorCount++;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l500" id="l500">   500</a> 	}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l501" id="l501">   501</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l502" id="l502">   502</a> 	public void reportError(String s) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l503" id="l503">   503</a> 	    if (reportErrors) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l504" id="l504">   504</a> 		super.reportError(s);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l505" id="l505">   505</a> 	    }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l506" id="l506">   506</a> 	    errorCount++;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l507" id="l507">   507</a> 	}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l508" id="l508">   508</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l509" id="l509">   509</a>         // Set of tokens stopping recovery
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l510" id="l510">   510</a>         private static final BitSet stopSet = new BitSet();
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l511" id="l511">   511</a>         static {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l512" id="l512">   512</a>             stopSet.add(LCURLY);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l513" id="l513">   513</a>             stopSet.add(RCURLY);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l514" id="l514">   514</a>             stopSet.add(RPAREN);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l515" id="l515">   515</a>             stopSet.add(LPAREN);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l516" id="l516">   516</a>             //stopSet.add(LSQUARE);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l517" id="l517">   517</a>             //stopSet.add(RSQUARE);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l518" id="l518">   518</a>         }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l519" id="l519">   519</a>         
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l520" id="l520">   520</a>         private static final int RECOVERY_LIMIT = 20;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l521" id="l521">   521</a>         private int recoveryCounter = 0;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l522" id="l522">   522</a>         private int lastRecoveryPosition = -1;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l523" id="l523">   523</a>         
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l524" id="l524">   524</a>         public void recover(RecognitionException ex, BitSet tokenSet) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l525" id="l525">   525</a>             if (lastRecoveryPosition == input.index()) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l526" id="l526">   526</a>                 if (recoveryCounter &gt; RECOVERY_LIMIT) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l527" id="l527">   527</a>                     consume();
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l528" id="l528">   528</a>                     recoveryCounter = 0;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l529" id="l529">   529</a>                 } else {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l530" id="l530">   530</a>                     recoveryCounter++;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l531" id="l531">   531</a>                 }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l532" id="l532">   532</a>             } else {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l533" id="l533">   533</a>                 recoveryCounter = 0;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l534" id="l534">   534</a>                 lastRecoveryPosition = input.index();
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l535" id="l535">   535</a>             }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l536" id="l536">   536</a>             tokenSet.orInPlace(stopSet);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l537" id="l537">   537</a>             consumeUntil(tokenSet);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l538" id="l538">   538</a> 	}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l539" id="l539">   539</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l540" id="l540">   540</a>         public boolean isTemplateTooDeep(int currentLevel, int maxLevel) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l541" id="l541">   541</a>             return isTemplateTooDeep(currentLevel, maxLevel, 0);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l542" id="l542">   542</a>         }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l543" id="l543">   543</a> 	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l544" id="l544">   544</a>         public static int TEMPLATE_PREVIEW_POS_LIMIT = 4096;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l545" id="l545">   545</a>         public boolean isTemplateTooDeep(int currentLevel, int maxLevel, int startPos) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l546" id="l546">   546</a>             int level = currentLevel;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l547" id="l547">   547</a>             int pos = startPos;            
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l548" id="l548">   548</a>             while(pos &lt; TEMPLATE_PREVIEW_POS_LIMIT) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l549" id="l549">   549</a>                 int token = LA(pos);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l550" id="l550">   550</a>                 pos++;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l551" id="l551">   551</a>                 if(token == EOF || token == 0) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l552" id="l552">   552</a>                     break;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l553" id="l553">   553</a>                 }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l554" id="l554">   554</a>                 if(token == LCURLY || token == RCURLY) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l555" id="l555">   555</a>                     break;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l556" id="l556">   556</a>                 }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l557" id="l557">   557</a>                 if(token == LESSTHAN) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l558" id="l558">   558</a>                     level++;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l559" id="l559">   559</a>                 } else if(token == GREATERTHAN) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l560" id="l560">   560</a>                     level--;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l561" id="l561">   561</a>                 } 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l562" id="l562">   562</a>                 if(level == 0) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l563" id="l563">   563</a>                     return false;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l564" id="l564">   564</a>                 }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l565" id="l565">   565</a>                 if(level &gt;= maxLevel) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l566" id="l566">   566</a>                     return true;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l567" id="l567">   567</a>                 }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l568" id="l568">   568</a>             }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l569" id="l569">   569</a>             return false;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l570" id="l570">   570</a>         }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l571" id="l571">   571</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l572" id="l572">   572</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l573" id="l573">   573</a> 	//protected boolean isCtor() { /*TODO: implement*/ throw new NotImplementedException(); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l574" id="l574">   574</a> 	//protected boolean isValidIdentifier(String id) { /*TODO: implement*/ throw new NotImplementedException(); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l575" id="l575">   575</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l576" id="l576">   576</a> 	protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l577" id="l577">   577</a> 	int lang;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l578" id="l578">   578</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l579" id="l579">   579</a> 	protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l580" id="l580">   580</a> 	int langFlavor;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l581" id="l581">   581</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l582" id="l582">   582</a> 	// Symbol table management stuff
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l583" id="l583">   583</a> 	//CPPDictionary *symbols;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l584" id="l584">   584</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l585" id="l585">   585</a> 	//protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l586" id="l586">   586</a> 	//int templateParameterScope;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l587" id="l587">   587</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l588" id="l588">   588</a> 	//protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l589" id="l589">   589</a> 	//int externalScope;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l590" id="l590">   590</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l591" id="l591">   591</a> 	protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l592" id="l592">   592</a> 	boolean _td;			// For typedef
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l593" id="l593">   593</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l594" id="l594">   594</a> 	protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l595" id="l595">   595</a> 	boolean _fd;			// For friend
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l596" id="l596">   596</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l597" id="l597">   597</a> 	protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l598" id="l598">   598</a> 	StorageClass _sc;	// For storage class
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l599" id="l599">   599</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l600" id="l600">   600</a> 	protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l601" id="l601">   601</a> 	TypeQualifier _tq;	// For type qualifier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l602" id="l602">   602</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l603" id="l603">   603</a> 	protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l604" id="l604">   604</a> 	/*TypeSpecifier*/int _ts;	// For type specifier
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l605" id="l605">   605</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l606" id="l606">   606</a> 	protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l607" id="l607">   607</a> 	DeclSpecifier _ds;	// For declaration specifier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l608" id="l608">   608</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l609" id="l609">   609</a> 	/*protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l610" id="l610">   610</a> 	int functionDefinition;	// 0 = Function definition not being parsed
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l611" id="l611">   611</a> 				// 1 = Parsing function name
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l612" id="l612">   612</a> 				// 2 = Parsing function parameter list
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l613" id="l613">   613</a> 				// 3 = Parsing function block*/
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l614" id="l614">   614</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l615" id="l615">   615</a> 	protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l616" id="l616">   616</a> 	StringBuilder qualifierPrefix = new StringBuilder();
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l617" id="l617">   617</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l618" id="l618">   618</a> 	protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l619" id="l619">   619</a> 	String enclosingClass;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l620" id="l620">   620</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l621" id="l621">   621</a> 	int assign_stmt_RHS_found;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l622" id="l622">   622</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l623" id="l623">   623</a> 	boolean in_parameter_list;	// DW 13/02/04 used within CPP_parser
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l624" id="l624">   624</a> 	boolean K_and_R;	// used to distinguish old K &amp; R parameter definitions
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l625" id="l625">   625</a> 	boolean in_return;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l626" id="l626">   626</a> 	boolean is_address;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l627" id="l627">   627</a> 	boolean is_pointer;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l628" id="l628">   628</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l629" id="l629">   629</a>         private static final int NESTED_CLASSES_LIMIT = 32;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l630" id="l630">   630</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l631" id="l631">   631</a>         protected int classDefinitionDepth = 0; // to restrict number of nested classes
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l632" id="l632">   632</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l633" id="l633">   633</a> 	protected int MaxTemplateTokenScan = 200;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l634" id="l634">   634</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l635" id="l635">   635</a> 	static class IF_Type extends Enum { public IF_Type(String id) { super(id); } }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l636" id="l636">   636</a> 	protected static final IF_Type IF_Local = new IF_Type(&quot;IF_Local&quot;);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l637" id="l637">   637</a> 	protected static final IF_Type IF_System = new IF_Type(&quot;IF_System&quot;);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l638" id="l638">   638</a> 	protected static final IF_Type IF_Macro = new IF_Type(&quot;IF_Macro&quot;);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l639" id="l639">   639</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l640" id="l640">   640</a> 	static class IncludeFile {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l641" id="l641">   641</a> 	    public IF_Type type;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l642" id="l642">   642</a> 	    public String file;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l643" id="l643">   643</a> 	}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l644" id="l644">   644</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l645" id="l645">   645</a> 	// Semantic interface; You could subclass and redefine these functions
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l646" id="l646">   646</a> 	//  so you don't have to mess with the grammar itself.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l647" id="l647">   647</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l648" id="l648">   648</a> 	// Antlr doesn't allow to make parser abstract;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l649" id="l649">   649</a> 	// I throw this exception in methods, which otherwise were just abstract 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l650" id="l650">   650</a> 	public static class NotImplementedException extends Error {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l651" id="l651">   651</a> 		public NotImplementedException() { super(&quot;not imlemented&quot;); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l652" id="l652">   652</a> 	}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l653" id="l653">   653</a> 	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l654" id="l654">   654</a> 	// Symbol stuff
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l655" id="l655">   655</a> 	protected boolean qualifiedItemIsOneOf(/*QualifiedItem*/int qiFlags) { return qualifiedItemIsOneOf(qiFlags, 0); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l656" id="l656">   656</a> 	protected boolean qualifiedItemIsOneOf(/*QualifiedItem*/int qiFlags, int lookahead_offset) { /*TODO: implement*/ throw new NotImplementedException(); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l657" id="l657">   657</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l658" id="l658">   658</a> 	protected /*QualifiedItem*/int qualifiedItemIs()	{ return qualifiedItemIs(0); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l659" id="l659">   659</a> 	protected /*QualifiedItem*/int qualifiedItemIs(int lookahead_offset) { /*TODO: implement*/ throw new NotImplementedException(); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l660" id="l660">   660</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l661" id="l661">   661</a> 	// both skipTemplateQualifiers and skipNestedParens used only in CPPParserEx
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l662" id="l662">   662</a> 	//protected boolean skipTemplateQualifiers(int kInOut) { /*TODO: implement*/ throw new NotImplementedException(); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l663" id="l663">   663</a> 	// TODO: original skipNestedParens(int&amp; kInOut) passes kInOut BY REF!
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l664" id="l664">   664</a> 	//protected int skipNestedParens(int kInOut) { /*TODO: implement*/ throw new NotImplementedException(); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l665" id="l665">   665</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l666" id="l666">   666</a> 	protected boolean scopedItem() { return scopedItem(1); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l667" id="l667">   667</a> 	protected boolean scopedItem(int k) { /*TODO: implement*/ throw new NotImplementedException(); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l668" id="l668">   668</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l669" id="l669">   669</a> 	// finalQualifier is used in CPPParserEx only
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l670" id="l670">   670</a> 	//protected int finalQualifier() { return finalQualifier(1); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l671" id="l671">   671</a> 	//protected int finalQualifier(final int k) { /*TODO: implement*/ throw new NotImplementedException(); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l672" id="l672">   672</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l673" id="l673">   673</a> 	protected boolean isTypeName(CharSequence s) { /*TODO: implement*/ throw new NotImplementedException(); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l674" id="l674">   674</a>         protected CharSequence getTokenText(Token token) { /*TODO: implement*/ throw new NotImplementedException(); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l675" id="l675">   675</a> 	// isClassName is used in CPPParserEx only
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l676" id="l676">   676</a> 	//protected boolean isClassName(String  s) { /*TODO: implement*/ throw new NotImplementedException(); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l677" id="l677">   677</a> 	//protected void end_of_stmt() {}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l678" id="l678">   678</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l679" id="l679">   679</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l680" id="l680">   680</a> 	// Scoping stuff
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l681" id="l681">   681</a> 	//protected void enterNewLocalScope() {}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l682" id="l682">   682</a> 	//protected void exitLocalScope() {}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l683" id="l683">   683</a> 	//protected void enterExternalScope() {}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l684" id="l684">   684</a> 	//protected void exitExternalScope() {}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l685" id="l685">   685</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l686" id="l686">   686</a> 	// Aggregate stuff
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l687" id="l687">   687</a> 	protected void classForwardDeclaration(/*TypeSpecifier*/int ts, DeclSpecifier ds, String tag) {}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l688" id="l688">   688</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l689" id="l689">   689</a> 	protected void beginClassDefinition(/*TypeSpecifier*/int ts, String tag) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l690" id="l690">   690</a>             classDefinitionDepth++;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l691" id="l691">   691</a>         }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l692" id="l692">   692</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l693" id="l693">   693</a> 	protected void endClassDefinition() {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l694" id="l694">   694</a>             classDefinitionDepth--;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l695" id="l695">   695</a>         }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l696" id="l696">   696</a>         
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l697" id="l697">   697</a>         protected boolean checkClassDefinitionDepth(int maxDepth) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l698" id="l698">   698</a>             return classDefinitionDepth &lt; maxDepth;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l699" id="l699">   699</a>         }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l700" id="l700">   700</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l701" id="l701">   701</a> 	protected void beginEnumDefinition(String s) {}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l702" id="l702">   702</a> 	protected void endEnumDefinition() {}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l703" id="l703">   703</a> 	protected void enumElement(String s) {}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l704" id="l704">   704</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l705" id="l705">   705</a> 	// Declaration and definition stuff
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l706" id="l706">   706</a> 	protected void declarationSpecifier(boolean td, boolean fd, StorageClass sc, TypeQualifier tq,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l707" id="l707">   707</a> 			     /*TypeSpecifier*/int ts, DeclSpecifier ds) {}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l708" id="l708">   708</a> 	protected void beginDeclaration() {}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l709" id="l709">   709</a> 	protected void endDeclaration() {}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l710" id="l710">   710</a> 	protected void beginConstructorDeclaration(String s) {}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l711" id="l711">   711</a> 	protected void endConstructorDeclaration() {}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l712" id="l712">   712</a> 	protected void beginDestructorDeclaration(String s) {}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l713" id="l713">   713</a> 	protected void endDestructorDeclaration() {}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l714" id="l714">   714</a> 	protected void beginParameterDeclaration() {}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l715" id="l715">   715</a> 	protected void beginFieldDeclaration() {}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l716" id="l716">   716</a> 	//protected void beginFunctionDefinition() {}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l717" id="l717">   717</a> 	//protected void endFunctionDefinition() {}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l718" id="l718">   718</a> 	//protected void functionParameterList() {}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l719" id="l719">   719</a> 	//protected void functionEndParameterList(boolean def) {}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l720" id="l720">   720</a> 	//protected void beginConstructorDefinition() {}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l721" id="l721">   721</a> 	//protected void endConstructorDefinition() {}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l722" id="l722">   722</a> 	//protected void beginDestructorDefinition() {}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l723" id="l723">   723</a> 	//protected void endDestructorDefinition() {}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l724" id="l724">   724</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l725" id="l725">   725</a> 	// Declarator stuff
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l726" id="l726">   726</a> 	protected void declaratorID(String s, /*QualifiedItem*/int qi) {}	// stores new symbol with type
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l727" id="l727">   727</a> 	protected void declaratorArray() {}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l728" id="l728">   728</a> 	//protected void declaratorParameterList(boolean def) {}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l729" id="l729">   729</a> 	//protected void declaratorEndParameterList(boolean def) {}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l730" id="l730">   730</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l731" id="l731">   731</a> 	// template stuff
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l732" id="l732">   732</a> 	protected void templateTypeParameter(String s) {}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l733" id="l733">   733</a> 	//protected void beginTemplateDeclaration() {}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l734" id="l734">   734</a> 	//protected void endTemplateDeclaration() {}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l735" id="l735">   735</a> 	protected void beginTemplateDefinition() {}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l736" id="l736">   736</a> 	protected void endTemplateDefinition() {}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l737" id="l737">   737</a> 	//protected void beginTemplateParameterList() {}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l738" id="l738">   738</a> 	//protected void endTemplateParameterList() {}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l739" id="l739">   739</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l740" id="l740">   740</a> 	// exception stuff
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l741" id="l741">   741</a> 	//protected void exceptionBeginHandler() {}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l742" id="l742">   742</a> 	//protected void exceptionEndHandler() {}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l743" id="l743">   743</a> 	protected void panic(String s) {}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l744" id="l744">   744</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l745" id="l745">   745</a> 	boolean reportErrors = true;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l746" id="l746">   746</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l747" id="l747">   747</a> 	// myCode functions ready for overriding in MyCode subclass
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l748" id="l748">   748</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l749" id="l749">   749</a> 	//protected int getOffset() { /*TODO: implement*/ throw new NotImplementedException(); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l750" id="l750">   750</a> 	//protected int getLine()	{ /*TODO: implement*/ throw new NotImplementedException(); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l751" id="l751">   751</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l752" id="l752">   752</a> 	protected void printf(String pattern, Object... params) { /*TODO: implement*/ throw new NotImplementedException(); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l753" id="l753">   753</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l754" id="l754">   754</a> 	protected boolean balanceBraces(int left, int right) { throw new NotImplementedException(); };
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l755" id="l755">   755</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l756" id="l756">   756</a>         protected boolean checkTemplateExplicitSpecialization() { throw new NotImplementedException(); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l757" id="l757">   757</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l758" id="l758">   758</a>         /** Is called when an error occurred */
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l759" id="l759">   759</a>         protected void onError(RecognitionException e) {}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l760" id="l760">   760</a> }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l761" id="l761">   761</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l762" id="l762">   762</a> public translation_unit:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l763" id="l763">   763</a> 		//{enterExternalScope();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l764" id="l764">   764</a>                 /* Do not generate ambiguity warnings: we intentionally want to match everything that
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l765" id="l765">   765</a>                    can not be matched in external_declaration in the second alternative */
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l766" id="l766">   766</a> 		(options{generateAmbigWarnings = false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l767" id="l767">   767</a>             { LT(1).getText().equals(LITERAL_EXEC) &amp;&amp; LT(2).getText().equals(LITERAL_SQL) }? (literal_ident literal_ident) =&gt; pro_c_statement
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l768" id="l768">   768</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l769" id="l769">   769</a>             {shouldProceed() &amp;&amp; !isCPlusPlus11()}? (LSQUARE) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l770" id="l770">   770</a>             /* This alternative fixes recovery problem happened because C++11 declaration
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l771" id="l771">   771</a>                could begin with LSQAURE token (see c++11 attributes). This
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l772" id="l772">   772</a>                breaks recovery for C++98 because rule external_declaration now
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l773" id="l773">   773</a>                will be called when declaration starts with LSQUARE, so the last
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l774" id="l774">   774</a>                alternative for recovering will not work. It seems that better solution is
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l775" id="l775">   775</a>                to track that function 'recover' was called (that means an error occured) but
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l776" id="l776">   776</a>                input.index() was not changed. In that case it is normal to consume one token
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l777" id="l777">   777</a>                like in the last alternative.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l778" id="l778">   778</a>             */ 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l779" id="l779">   779</a>             .! { reportError(new NoViableAltException(LT(0), getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l780" id="l780">   780</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l781" id="l781">   781</a>             {shouldProceed()}?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l782" id="l782">   782</a>             external_declaration             
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l783" id="l783">   783</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l784" id="l784">   784</a>             {shouldProceed()}?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l785" id="l785">   785</a>             /* Here we match everything that can not be matched by external_declaration rule,
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l786" id="l786">   786</a>                report it as an error and not include in AST */
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l787" id="l787">   787</a>             .! { reportError(new NoViableAltException(LT(0), getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l788" id="l788">   788</a>         )* EOF!
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l789" id="l789">   789</a> 		{/*exitExternalScope();*/ #translation_unit = #(#[CSM_TRANSLATION_UNIT, getFilename()], #translation_unit);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l790" id="l790">   790</a>        ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l791" id="l791">   791</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l792" id="l792">   792</a> //
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l793" id="l793">   793</a> // it's a caller's responsibility to check isCPlusPlus
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l794" id="l794">   794</a> //
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l795" id="l795">   795</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l796" id="l796">   796</a> template_explicit_specialization
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l797" id="l797">   797</a> {String s; TypeQualifier tq; StorageClass sc;int ts = 0; boolean b;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l798" id="l798">   798</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l799" id="l799">   799</a>     LITERAL_template LESSTHAN GREATERTHAN
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l800" id="l800">   800</a>     (
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l801" id="l801">   801</a>         // Template explicit specialisation function definition (VK 30/05/06)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l802" id="l802">   802</a>         ((LITERAL_template LESSTHAN GREATERTHAN)? declaration_specifiers[false, false] function_declarator[true, false, false] (LCURLY | literal_try | ASSIGNEQUAL (LITERAL_default | LITERAL_delete)))=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l803" id="l803">   803</a>         (LITERAL_template LESSTHAN GREATERTHAN)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l804" id="l804">   804</a>         {if(statementTrace &gt;= 1) printf(&quot;external_declaration_0a[%d]: template &quot; + &quot;explicit-specialisation function definition\n&quot;, LT(1).getLine());}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l805" id="l805">   805</a>         function_definition
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l806" id="l806">   806</a>         { #template_explicit_specialization = #(#[CSM_TEMPLATE_FUNCTION_DEFINITION_EXPLICIT_SPECIALIZATION, &quot;CSM_TEMPLATE_FUNCTION_DEFINITION_EXPLICIT_SPECIALIZATION&quot;], #template_explicit_specialization); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l807" id="l807">   807</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l808" id="l808">   808</a>         // Template explicit specialisation ctor definition
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l809" id="l809">   809</a>         (   ctor_decl_spec ctor_declarator[true]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l810" id="l810">   810</a>             ( COLON         // DEFINITION :ctor_initializer
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l811" id="l811">   811</a>             | LCURLY        // DEFINITION (compound Statement) ?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l812" id="l812">   812</a>             | ASSIGNEQUAL (LITERAL_default | LITERAL_delete)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l813" id="l813">   813</a>             )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l814" id="l814">   814</a>         ) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l815" id="l815">   815</a>         {if(statementTrace &gt;= 1) printf(&quot;template_explicit_specialization_0b[%d]: template &quot; + &quot;explicit-specialisation ctor definition\n&quot;, LT(1).getLine());}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l816" id="l816">   816</a>         ctor_definition
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l817" id="l817">   817</a>         { #template_explicit_specialization = #(#[CSM_TEMPLATE_CTOR_DEFINITION_EXPLICIT_SPECIALIZATION, &quot;CSM_TEMPLATE_CTOR_DEFINITION_EXPLICIT_SPECIALIZATION&quot;], #template_explicit_specialization); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l818" id="l818">   818</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l819" id="l819">   819</a> 	// Template explicit specialisation dtor definition
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l820" id="l820">   820</a> 		(dtor_declarator[true] LCURLY)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l821" id="l821">   821</a> 		{if(statementTrace &gt;= 1)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l822" id="l822">   822</a> 			printf(&quot;template_explicit_specialization_0b[%d]: template &quot; +
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l823" id="l823">   823</a> 				&quot;explicit-specialisation dtor definition\n&quot;, LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l824" id="l824">   824</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l825" id="l825">   825</a> 		dtor_definition
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l826" id="l826">   826</a> 		//{ #template_explicit_specialization = #(#[CSM_TEMPLATE_FUNCTION_DEFINITION_EXPLICIT_SPECIALIZATION, &quot;CSM_TEMPLATE_FUNCTION_DEFINITION_EXPLICIT_SPECIALIZATION&quot;], #template_explicit_specialization); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l827" id="l827">   827</a>         { #template_explicit_specialization = #(#[CSM_TEMPLATE_DTOR_DEFINITION_EXPLICIT_SPECIALIZATION, &quot;CSM_TEMPLATE_DTOR_DEFINITION_EXPLICIT_SPECIALIZATION&quot;], #template_explicit_specialization); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l828" id="l828">   828</a> 	| 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l829" id="l829">   829</a>         // Template explicit specialisation ctor declaration 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l830" id="l830">   830</a> 		(ctor_declarator[false] SEMICOLON)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l831" id="l831">   831</a> 		{if(statementTrace &gt;= 1)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l832" id="l832">   832</a> 			printf(&quot;template_explicit_specialization_0c[%d]: template &quot; +
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l833" id="l833">   833</a> 				&quot;explicit-specialisation ctor declaration\n&quot;, LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l834" id="l834">   834</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l835" id="l835">   835</a> 		b = ctor_declarator[false] SEMICOLON
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l836" id="l836">   836</a> 		{ #template_explicit_specialization = #(#[CSM_TEMPLATE_EXPLICIT_SPECIALIZATION, &quot;CSM_TEMPLATE_EXPLICIT_SPECIALIZATION&quot;], #template_explicit_specialization); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l837" id="l837">   837</a>         // Template explicit specialisation dtor declaration        
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l838" id="l838">   838</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l839" id="l839">   839</a> 		(dtor_declarator[false] SEMICOLON)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l840" id="l840">   840</a> 		{if(statementTrace &gt;= 1)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l841" id="l841">   841</a> 			printf(&quot;template_explicit_specialization_0d[%d]: template &quot; +
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l842" id="l842">   842</a> 				&quot;explicit-specialisation dtor definition\n&quot;, LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l843" id="l843">   843</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l844" id="l844">   844</a> 		dtor_declarator[false] SEMICOLON
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l845" id="l845">   845</a> 		{ #template_explicit_specialization = #(#[CSM_TEMPLATE_EXPLICIT_SPECIALIZATION, &quot;CSM_TEMPLATE_EXPLICIT_SPECIALIZATION&quot;], #template_explicit_specialization); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l846" id="l846">   846</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l847" id="l847">   847</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l848" id="l848">   848</a>         // Template explicit specialisation dtor declaration
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l849" id="l849">   849</a> 		(class_forward_declaration)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l850" id="l850">   850</a> 		{if(statementTrace &gt;= 1)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l851" id="l851">   851</a> 			printf(&quot;template_explicit_specialization_0f[%d]: template &quot; +
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l852" id="l852">   852</a> 				&quot;class forward explicit-specialisation\n&quot;, LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l853" id="l853">   853</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l854" id="l854">   854</a> 		declaration_specifiers[false, false] SEMICOLON
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l855" id="l855">   855</a> 		{ #template_explicit_specialization = #(#[CSM_FWD_TEMPLATE_EXPLICIT_SPECIALIZATION, &quot;CSM_FWD_TEMPLATE_EXPLICIT_SPECIALIZATION&quot;], #template_explicit_specialization); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l856" id="l856">   856</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l857" id="l857">   857</a>             (   (LITERAL___extension__!)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l858" id="l858">   858</a>                 (LITERAL_template LESSTHAN GREATERTHAN)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l859" id="l859">   859</a>                 (   storage_class_specifier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l860" id="l860">   860</a>                 |   cv_qualifier
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l861" id="l861">   861</a>                 |   LITERAL_typedef
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l862" id="l862">   862</a>                 )*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l863" id="l863">   863</a>                 enum_def_head
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l864" id="l864">   864</a>             ) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l865" id="l865">   865</a>             (LITERAL___extension__!)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l866" id="l866">   866</a>             (LITERAL_template LESSTHAN GREATERTHAN)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l867" id="l867">   867</a>                 (   sc = storage_class_specifier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l868" id="l868">   868</a>                 |   tq = cv_qualifier
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l869" id="l869">   869</a>                 |   LITERAL_typedef
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l870" id="l870">   870</a>             )*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l871" id="l871">   871</a>             enum_specifier (init_declarator_list[declOther])? 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l872" id="l872">   872</a>             SEMICOLON
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l873" id="l873">   873</a>             { #template_explicit_specialization = #(#[CSM_ENUM_DECLARATION, &quot;CSM_ENUM_DECLARATION&quot;], #template_explicit_specialization); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l874" id="l874">   874</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l875" id="l875">   875</a>             (   (LITERAL___extension__!)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l876" id="l876">   876</a>                 (LITERAL_template LESSTHAN GREATERTHAN)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l877" id="l877">   877</a>                 (   storage_class_specifier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l878" id="l878">   878</a>                 |   cv_qualifier
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l879" id="l879">   879</a>                 |   LITERAL_typedef
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l880" id="l880">   880</a>                 )*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l881" id="l881">   881</a>                 LITERAL_enum (LITERAL_class | LITERAL_struct)? (qualified_id)? (COLON ts = type_specifier[dsInvalid, false])? SEMICOLON
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l882" id="l882">   882</a>             ) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l883" id="l883">   883</a>             (LITERAL___extension__!)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l884" id="l884">   884</a>             (LITERAL_template LESSTHAN GREATERTHAN)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l885" id="l885">   885</a>                 (   sc = storage_class_specifier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l886" id="l886">   886</a>                 |   tq = cv_qualifier
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l887" id="l887">   887</a>                 |   LITERAL_typedef
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l888" id="l888">   888</a>             )*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l889" id="l889">   889</a>             enum_specifier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l890" id="l890">   890</a>             SEMICOLON
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l891" id="l891">   891</a>             { #template_explicit_specialization = #(#[CSM_ENUM_FWD_DECLARATION, &quot;CSM_ENUM_FWD_DECLARATION&quot;], #template_explicit_specialization); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l892" id="l892">   892</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l893" id="l893">   893</a>         // Template explicit specialisation for type cast operator
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l894" id="l894">   894</a>             (   (LITERAL___extension__!)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l895" id="l895">   895</a>                 (LITERAL_template LESSTHAN GREATERTHAN)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l896" id="l896">   896</a>                 (   literal_inline
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l897" id="l897">   897</a>                 |   cv_qualifier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l898" id="l898">   898</a>                 |   LITERAL_constexpr
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l899" id="l899">   899</a>                 )*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l900" id="l900">   900</a>                 scope_override LITERAL_OPERATOR
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l901" id="l901">   901</a>             ) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l902" id="l902">   902</a>             (   (LITERAL___extension__!)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l903" id="l903">   903</a>                 (LITERAL_template LESSTHAN GREATERTHAN)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l904" id="l904">   904</a>                 (   literal_inline
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l905" id="l905">   905</a>                 |   tq = cv_qualifier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l906" id="l906">   906</a>                 |   LITERAL_constexpr
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l907" id="l907">   907</a>                 )*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l908" id="l908">   908</a>                 s = scope_override b = conversion_function_decl_or_def 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l909" id="l909">   909</a>             )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l910" id="l910">   910</a>             { if (b) #template_explicit_specialization = #(#[CSM_USER_TYPE_CAST_DEFINITION_EXPLICIT_SPECIALIZATION, &quot;CSM_USER_TYPE_CAST_DEFINITION_EXPLICIT_SPECIALIZATION&quot;], #template_explicit_specialization);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l911" id="l911">   911</a>               else #template_explicit_specialization = #(#[CSM_TEMPLATE_EXPLICIT_SPECIALIZATION, &quot;CSM_TEMPLATE_EXPLICIT_SPECIALIZATION&quot;], #template_explicit_specialization); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l912" id="l912">   912</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l913" id="l913">   913</a> 	// Template explicit specialisation (DW 14/04/03)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l914" id="l914">   914</a> 		{if(statementTrace &gt;= 1)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l915" id="l915">   915</a> 			printf(&quot;template_explicit_specialization_0e[%d]: template &quot; +
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l916" id="l916">   916</a> 				&quot;explicit-specialisation\n&quot;, LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l917" id="l917">   917</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l918" id="l918">   918</a>         (LITERAL_template LESSTHAN GREATERTHAN)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l919" id="l919">   919</a> 		declaration[declOther]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l920" id="l920">   920</a> 		{ #template_explicit_specialization = #(#[CSM_TEMPLATE_EXPLICIT_SPECIALIZATION, &quot;CSM_TEMPLATE_EXPLICIT_SPECIALIZATION&quot;], #template_explicit_specialization); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l921" id="l921">   921</a> 	)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l922" id="l922">   922</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l923" id="l923">   923</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l924" id="l924">   924</a> //
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l925" id="l925">   925</a> // it's a caller's responsibility to check isCPlusPlus
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l926" id="l926">   926</a> //
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l927" id="l927">   927</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l928" id="l928">   928</a> external_declaration_template { String s; K_and_R = false; boolean ctrName=false; boolean definition; boolean friend = false; TypeQualifier tq; StorageClass sc;int ts = 0;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l929" id="l929">   929</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l930" id="l930">   930</a>         ((LITERAL___extension__)? LITERAL_template LESSTHAN GREATERTHAN) =&gt; 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l931" id="l931">   931</a>         (
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l932" id="l932">   932</a>             (LITERAL___extension__!)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l933" id="l933">   933</a>             (
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l934" id="l934">   934</a>                 {checkTemplateExplicitSpecialization()}? 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l935" id="l935">   935</a>                 template_explicit_specialization
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l936" id="l936">   936</a>             |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l937" id="l937">   937</a>                 declaration_template_impl
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l938" id="l938">   938</a>             )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l939" id="l939">   939</a>         )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l940" id="l940">   940</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l941" id="l941">   941</a>         (LITERAL_template (LITERAL_class | LITERAL_struct| LITERAL_union)) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l942" id="l942">   942</a>         LITERAL_template (LITERAL_class | LITERAL_struct| LITERAL_union) 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l943" id="l943">   943</a>         s=scope_override s=literal_ident (LESSTHAN template_argument_list GREATERTHAN)? SEMICOLON
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l944" id="l944">   944</a>         {#external_declaration_template = #(#[CSM_TEMPLATE_EXPLICIT_INSTANTIATION, &quot;CSM_TEMPLATE_EXPLICIT_INSTANTIATION&quot;], #external_declaration_template);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l945" id="l945">   945</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l946" id="l946">   946</a>         (LITERAL_template (~LESSTHAN)) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l947" id="l947">   947</a>         LITERAL_template
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l948" id="l948">   948</a>         (
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l949" id="l949">   949</a>             (scope_override LITERAL_OPERATOR)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l950" id="l950">   950</a>                 s=scope_override conversion_function_decl
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l951" id="l951">   951</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l952" id="l952">   952</a>             declaration[declOther]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l953" id="l953">   953</a>         )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l954" id="l954">   954</a>         {#external_declaration_template = #(#[CSM_TEMPLATE_EXPLICIT_INSTANTIATION, &quot;CSM_TEMPLATE_EXPLICIT_INSTANTIATION&quot;], #external_declaration_template);}	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l955" id="l955">   955</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l956" id="l956">   956</a>         declaration_template_impl
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l957" id="l957">   957</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l958" id="l958">   958</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l959" id="l959">   959</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l960" id="l960">   960</a> declaration_template_impl { String s; K_and_R = false; boolean ctrName=false; boolean definition; boolean friend = false; TypeQualifier tq; StorageClass sc;int ts = 0;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l961" id="l961">   961</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l962" id="l962">   962</a>         {beginTemplateDefinition();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l963" id="l963">   963</a>         (
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l964" id="l964">   964</a>             options {greedy=true;} :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l965" id="l965">   965</a>             (
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l966" id="l966">   966</a>                 (LITERAL_template LESSTHAN GREATERTHAN) =&gt; 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l967" id="l967">   967</a>                     LITERAL_template LESSTHAN! GREATERTHAN! // just swallow tokens
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l968" id="l968">   968</a>                 |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l969" id="l969">   969</a>                     template_head
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l970" id="l970">   970</a>             )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l971" id="l971">   971</a>         )+
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l972" id="l972">   972</a> 		(   
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l973" id="l973">   973</a>                 // Class template definition
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l974" id="l974">   974</a>                 (class_head)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l975" id="l975">   975</a>                 {if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l976" id="l976">   976</a>                     printf(&quot;declaration_template_impl_1b[%d]: Class template definition\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l977" id="l977">   977</a>                         LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l978" id="l978">   978</a>                 }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l979" id="l979">   979</a>                 declaration[declOther]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l980" id="l980">   980</a>                 { #declaration_template_impl = #(#[CSM_TEMPLATE_CLASS_DECLARATION, &quot;CSM_TEMPLATE_CLASS_DECLARATION&quot;], #declaration_template_impl); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l981" id="l981">   981</a>             |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l982" id="l982">   982</a>                 // Templated FUNCTIONS and CONSTRUCTORS matched here.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l983" id="l983">   983</a>                 // Templated CONSTRUCTOR declaration
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l984" id="l984">   984</a>                 (	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l985" id="l985">   985</a>                         ctor_decl_spec
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l986" id="l986">   986</a>                         /*{qualifiedItemIsOneOf(qiCtor)}?*/
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l987" id="l987">   987</a>                         ctor_declarator[false] (EOF|SEMICOLON)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l988" id="l988">   988</a>                 )=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l989" id="l989">   989</a>                 {if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l990" id="l990">   990</a>                         printf(&quot;declaration_template_impl_11a[%d]: Constructor or no-ret type fun declarator\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l991" id="l991">   991</a>                                 LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l992" id="l992">   992</a>                 }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l993" id="l993">   993</a>                 friend = ctor_decl_spec
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l994" id="l994">   994</a> //                {ctrName = qualifiedItemIsOneOf(qiCtor);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l995" id="l995">   995</a>                 ctrName = ctor_declarator[false]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l996" id="l996">   996</a>                 (
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l997" id="l997">   997</a>                         EOF! { reportError(new NoViableAltException(org.netbeans.modules.cnd.apt.utils.APTUtils.EOF_TOKEN, getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l998" id="l998">   998</a>                     |   
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l999" id="l999">   999</a>                         SEMICOLON  // Constructor declarator
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1000" id="l1000">  1000</a>                 )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1001" id="l1001">  1001</a>                 {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1002" id="l1002">  1002</a>                     // below is a workaround for know infinite loop bug in ANTLR 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1003" id="l1003">  1003</a>                     // see http://www.jguru.com/faq/view.jsp?EID=271922
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1004" id="l1004">  1004</a>                     //if( #cds1 != null ) { #cds1.setNextSibling(null); }; 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1005" id="l1005">  1005</a>                     if (ctrName &amp;&amp; !friend) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1006" id="l1006">  1006</a>                         #declaration_template_impl= #(#[CSM_CTOR_TEMPLATE_DECLARATION, &quot;CSM_CTOR_TEMPLATE_DECLARATION&quot;],  #declaration_template_impl); //end_of_stmt();
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1007" id="l1007">  1007</a>                     } else {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1008" id="l1008">  1008</a>                         #declaration_template_impl= #(#[CSM_FUNCTION_TEMPLATE_DECLARATION, &quot;CSM_FUNCTION_TEMPLATE_DECLARATION&quot;],  #declaration_template_impl); //end_of_stmt();
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1009" id="l1009">  1009</a>                     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1010" id="l1010">  1010</a>                 }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1011" id="l1011">  1011</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1012" id="l1012">  1012</a>             |   
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1013" id="l1013">  1013</a>                 // Templated CONSTRUCTOR definition
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1014" id="l1014">  1014</a>                 // JEL 4/3/96.. Added predicate that works once the
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1015" id="l1015">  1015</a>                 // restriction is added that ctor cannot be virtual
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1016" id="l1016">  1016</a>                 (  
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1017" id="l1017">  1017</a>                     ctor_decl_spec                            
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1018" id="l1018">  1018</a>                     /*{qualifiedItemIsOneOf(qiCtor)}?*/
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1019" id="l1019">  1019</a>                     ctor_declarator[true]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1020" id="l1020">  1020</a>                 )=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1021" id="l1021">  1021</a>                 {if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1022" id="l1022">  1022</a>                     printf(&quot;declaration_template_impl_11b[%d]: Template constructor &quot; +
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1023" id="l1023">  1023</a>                         &quot;definition\n&quot;, LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1024" id="l1024">  1024</a>                 }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1025" id="l1025">  1025</a>                 // TODO: use ctor_definition here
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1026" id="l1026">  1026</a>                 friend = ctor_decl_spec
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1027" id="l1027">  1027</a>                 ctrName = ctor_declarator[true]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1028" id="l1028">  1028</a>                 (ctor_body | ASSIGNEQUAL (LITERAL_default | LITERAL_delete))
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1029" id="l1029">  1029</a>                 {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1030" id="l1030">  1030</a>                     if (ctrName &amp;&amp; !friend) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1031" id="l1031">  1031</a>                         #declaration_template_impl= #(#[CSM_CTOR_TEMPLATE_DEFINITION, &quot;CSM_CTOR_TEMPLATE_DEFINITION&quot;],  #declaration_template_impl); //end_of_stmt();
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1032" id="l1032">  1032</a>                     } else {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1033" id="l1033">  1033</a>                         #declaration_template_impl= #(#[CSM_FUNCTION_TEMPLATE_DEFINITION, &quot;CSM_FUNCTION_TEMPLATE_DEFINITION&quot;],  #declaration_template_impl); //end_of_stmt();
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1034" id="l1034">  1034</a>                     }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1035" id="l1035">  1035</a>                 }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1036" id="l1036">  1036</a>             |  
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1037" id="l1037">  1037</a>                 // User-defined type cast
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1038" id="l1038">  1038</a>                 {isCPlusPlus()}?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1039" id="l1039">  1039</a>                 ((literal_inline | LITERAL_constexpr)? scope_override conversion_function_decl_or_def)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1040" id="l1040">  1040</a>                 {if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1041" id="l1041">  1041</a>                         printf(&quot;external_declaration_6[%d]: Operator function\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1042" id="l1042">  1042</a>                                 LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1043" id="l1043">  1043</a>                 }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1044" id="l1044">  1044</a>                 (literal_inline | LITERAL_constexpr)? s = scope_override definition = conversion_function_decl_or_def 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1045" id="l1045">  1045</a>                 { if( definition ) #declaration_template_impl = #(#[CSM_USER_TYPE_CAST_TEMPLATE_DEFINITION, &quot;CSM_USER_TYPE_CAST_TEMPLATE_DEFINITION&quot;], #declaration_template_impl);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1046" id="l1046">  1046</a>                     else	   #declaration_template_impl = #(#[CSM_USER_TYPE_CAST_TEMPLATE_DECLARATION, &quot;CSM_USER_TYPE_CAST_TEMPLATE_DECLARATION&quot;], #declaration_template_impl); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1047" id="l1047">  1047</a>             |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1048" id="l1048">  1048</a>                 // Templated function declaration
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1049" id="l1049">  1049</a>                 (declaration_specifiers[false, false] function_declarator[false, false, false] SEMICOLON)=&gt; 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1050" id="l1050">  1050</a>                 {if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1051" id="l1051">  1051</a>                     printf(&quot;declaration_template_impl_11c[%d]: Function template &quot; +
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1052" id="l1052">  1052</a>                         &quot;declaration\n&quot;, LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1053" id="l1053">  1053</a>                 }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1054" id="l1054">  1054</a>                 declaration[declOther]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1055" id="l1055">  1055</a>                 { #declaration_template_impl = #(#[CSM_FUNCTION_TEMPLATE_DECLARATION, &quot;CSM_FUNCTION_TEMPLATE_DECLARATION&quot;], #declaration_template_impl); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1056" id="l1056">  1056</a>             |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1057" id="l1057">  1057</a>                 // Templated function definition
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1058" id="l1058">  1058</a>                 (declaration_specifiers[false, false] function_declarator[true, false, false] (LCURLY | literal_try | ASSIGNEQUAL (LITERAL_default | LITERAL_delete)))=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1059" id="l1059">  1059</a>                 {if (statementTrace&gt;=1) printf(&quot;declaration_template_impl_11d[%d]: Function template &quot; + &quot;definition\n&quot;, LT(1).getLine());}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1060" id="l1060">  1060</a>                 function_definition
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1061" id="l1061">  1061</a>                 { #declaration_template_impl = #(#[CSM_FUNCTION_TEMPLATE_DEFINITION, &quot;CSM_FUNCTION_TEMPLATE_DEFINITION&quot;], #declaration_template_impl); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1062" id="l1062">  1062</a>             |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1063" id="l1063">  1063</a>                 // Destructor DEFINITION (templated)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1064" id="l1064">  1064</a>                 (   dtor_head[true] 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1065" id="l1065">  1065</a>                     (   LCURLY
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1066" id="l1066">  1066</a>                     |   ASSIGNEQUAL (LITERAL_default | LITERAL_delete)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1067" id="l1067">  1067</a>                     )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1068" id="l1068">  1068</a>                 )=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1069" id="l1069">  1069</a>                     {if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1070" id="l1070">  1070</a>                         printf(&quot;external_declaration_4[%d]: Destructor definition\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1071" id="l1071">  1071</a>                             LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1072" id="l1072">  1072</a>                     }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1073" id="l1073">  1073</a>                     dtor_head[true] 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1074" id="l1074">  1074</a>                     (   
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1075" id="l1075">  1075</a>                         dtor_body
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1076" id="l1076">  1076</a>                     |   
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1077" id="l1077">  1077</a>                         ASSIGNEQUAL (LITERAL_default | LITERAL_delete)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1078" id="l1078">  1078</a>                     )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1079" id="l1079">  1079</a>                     { #declaration_template_impl = #(#[CSM_DTOR_TEMPLATE_DEFINITION, &quot;CSM_DTOR_TEMPLATE_DEFINITION&quot;], #declaration_template_impl); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1080" id="l1080">  1080</a>             |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1081" id="l1081">  1081</a>                 (LITERAL_using literal_ident ASSIGNEQUAL) =&gt; alias_declaration
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1082" id="l1082">  1082</a>                 { #declaration_template_impl = #(#[CSM_GENERIC_DECLARATION, &quot;CSM_GENERIC_DECLARATION&quot;], #declaration_template_impl); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1083" id="l1083">  1083</a>             |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1084" id="l1084">  1084</a>                 (   (LITERAL___extension__!)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1085" id="l1085">  1085</a>                     (   storage_class_specifier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1086" id="l1086">  1086</a>                     |   cv_qualifier
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1087" id="l1087">  1087</a>                     |   LITERAL_typedef
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1088" id="l1088">  1088</a>                     )*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1089" id="l1089">  1089</a>                     enum_def_head
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1090" id="l1090">  1090</a>                 ) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1091" id="l1091">  1091</a>                 (LITERAL___extension__!)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1092" id="l1092">  1092</a>                     (   sc = storage_class_specifier
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1093" id="l1093">  1093</a>                     |   tq = cv_qualifier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1094" id="l1094">  1094</a>                     |   LITERAL_typedef
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1095" id="l1095">  1095</a>                 )*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1096" id="l1096">  1096</a>                 enum_specifier (init_declarator_list[declOther])? 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1097" id="l1097">  1097</a>                 SEMICOLON
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1098" id="l1098">  1098</a>                 { #declaration_template_impl = #(#[CSM_ENUM_DECLARATION, &quot;CSM_ENUM_DECLARATION&quot;], #declaration_template_impl); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1099" id="l1099">  1099</a>             |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1100" id="l1100">  1100</a>                 (   (LITERAL___extension__!)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1101" id="l1101">  1101</a>                     (   storage_class_specifier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1102" id="l1102">  1102</a>                     |   cv_qualifier
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1103" id="l1103">  1103</a>                     |   LITERAL_typedef
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1104" id="l1104">  1104</a>                     )*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1105" id="l1105">  1105</a>                     LITERAL_enum (LITERAL_class | LITERAL_struct)? (qualified_id)? (COLON ts = type_specifier[dsInvalid, false])? SEMICOLON
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1106" id="l1106">  1106</a>                 ) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1107" id="l1107">  1107</a>                 (LITERAL___extension__!)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1108" id="l1108">  1108</a>                     (   sc = storage_class_specifier
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1109" id="l1109">  1109</a>                         |   tq = cv_qualifier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1110" id="l1110">  1110</a>                         |   LITERAL_typedef
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1111" id="l1111">  1111</a>                     )*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1112" id="l1112">  1112</a>                 enum_specifier
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1113" id="l1113">  1113</a>                 SEMICOLON
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1114" id="l1114">  1114</a>                 { #declaration_template_impl = #(#[CSM_ENUM_FWD_DECLARATION, &quot;CSM_ENUM_FWD_DECLARATION&quot;], #declaration_template_impl); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1115" id="l1115">  1115</a>             |  
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1116" id="l1116">  1116</a>                 // templated forward class decl, init/decl of static member in template
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1117" id="l1117">  1117</a>                             // Changed alternative order as a fix for IZ#138099:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1118" id="l1118">  1118</a>                             // unresolved identifier for functions' template parameter.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1119" id="l1119">  1119</a>                             // If this alternative is before function declaration
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1120" id="l1120">  1120</a>                             // then code like &quot;template&lt;T&gt; int foo(T);&quot; incorrectly
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1121" id="l1121">  1121</a>                             // becomes a CSM_TEMPL_FWD_CL_OR_STAT_MEM.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1122" id="l1122">  1122</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1123" id="l1123">  1123</a>                 (declaration_specifiers[true, false]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1124" id="l1124">  1124</a>                     (init_declarator_list[declOther])? SEMICOLON /*{end_of_stmt();}*/)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1125" id="l1125">  1125</a>                 //{beginTemplateDeclaration();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1126" id="l1126">  1126</a>                 { if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1127" id="l1127">  1127</a>                     printf(&quot;declaration_template_impl_10[%d]: Class template declaration\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1128" id="l1128">  1128</a>                         LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1129" id="l1129">  1129</a>                 }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1130" id="l1130">  1130</a>                 declaration_specifiers[true, false]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1131" id="l1131">  1131</a>                     (init_declarator_list[declOther])? SEMICOLON //{end_of_stmt();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1132" id="l1132">  1132</a>                 {/*endTemplateDeclaration();*/ #declaration_template_impl = #(#[CSM_TEMPL_FWD_CL_OR_STAT_MEM, &quot;CSM_TEMPL_FWD_CL_OR_STAT_MEM&quot;], #declaration_template_impl);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1133" id="l1133">  1133</a>         )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1134" id="l1134">  1134</a>         {endTemplateDefinition();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1135" id="l1135">  1135</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1136" id="l1136">  1136</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1137" id="l1137">  1137</a> protected 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1138" id="l1138">  1138</a> typedef_enum
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1139" id="l1139">  1139</a>         :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1140" id="l1140">  1140</a>                 {if(statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1141" id="l1141">  1141</a>                         printf(&quot;typedef_enum [%d]\n&quot;,LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1142" id="l1142">  1142</a>                 }                     
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1143" id="l1143">  1143</a>                 LITERAL_typedef 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1144" id="l1144">  1144</a>                 {declarationSpecifier(true, false, scInvalid, tqInvalid, tsInvalid, dsInvalid);} 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1145" id="l1145">  1145</a>                 enum_specifier 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1146" id="l1146">  1146</a>                 (init_declarator_list[declOther])? SEMICOLON //{end_of_stmt();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1147" id="l1147">  1147</a>         ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1148" id="l1148">  1148</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1149" id="l1149">  1149</a> external_declaration {String s; K_and_R = false; boolean definition;StorageClass sc;TypeQualifier tq; int ts = 0;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1150" id="l1150">  1150</a> 	:  
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1151" id="l1151">  1151</a> 	(
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1152" id="l1152">  1152</a>                 {isCPlusPlus()}?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1153" id="l1153">  1153</a> 		// Suppressed instantiation of the following declaration
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1154" id="l1154">  1154</a> 		{if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1155" id="l1155">  1155</a> 			printf(&quot;external_declaration_0[%d]: Suppressed instantiation of the following declaration\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1156" id="l1156">  1156</a> 				LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1157" id="l1157">  1157</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1158" id="l1158">  1158</a>                 ((LITERAL___extension__)? LITERAL_extern LITERAL_template)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1159" id="l1159">  1159</a> 		(LITERAL___extension__!)? LITERAL_extern LITERAL_template external_declaration
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1160" id="l1160">  1160</a> 		{ #external_declaration = #(#[CSM_EXTERN_TEMPLATE, &quot;CSM_EXTERN_TEMPLATE&quot;], #external_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1161" id="l1161">  1161</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1162" id="l1162">  1162</a> 	    {isCPlusPlus()}? ((LITERAL___extension__)? (LITERAL_export)? LITERAL_template) =&gt; external_declaration_template
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1163" id="l1163">  1163</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1164" id="l1164">  1164</a> 	// Class definition (templates too)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1165" id="l1165">  1165</a> 	// This is separated out otherwise the next alternative
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1166" id="l1166">  1166</a> 	// would look for &quot;class A { ... } f() {...}&quot; which is
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1167" id="l1167">  1167</a> 	// an unacceptable level of backtracking.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1168" id="l1168">  1168</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1169" id="l1169">  1169</a> 	// JEL Note:  Rule body does not need typedef, because
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1170" id="l1170">  1170</a> 	// that is internal to &quot;declaration&quot;, and it is invalid
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1171" id="l1171">  1171</a> 	// to say &quot;typedef template...&quot;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1172" id="l1172">  1172</a> 	 	// Class definition
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1173" id="l1173">  1173</a>                 // we need &quot;static&quot; here for the case &quot;static struct XX {...} myVar; - see issue #106652
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1174" id="l1174">  1174</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1175" id="l1175">  1175</a> //		((LITERAL_typedef | LITERAL_static)? class_head)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1176" id="l1176">  1176</a>         ((LITERAL___extension__!)? (decl_specifiers_before_type)? class_head) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1177" id="l1177">  1177</a>         {action.simple_declaration(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1178" id="l1178">  1178</a>         {action.class_declaration(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1179" id="l1179">  1179</a> 		(LITERAL___extension__!)? declaration[declOther]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1180" id="l1180">  1180</a> 		{ #external_declaration = #(#[CSM_CLASS_DECLARATION, &quot;CSM_CLASS_DECLARATION&quot;], #external_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1181" id="l1181">  1181</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1182" id="l1182">  1182</a>         // Enum definition (don't want to backtrack over this in other alts)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1183" id="l1183">  1183</a>         ((LITERAL___extension__!)? (decl_specifiers_before_type)? enum_def_head) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1184" id="l1184">  1184</a>         {action.simple_declaration(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1185" id="l1185">  1185</a>         {action.enum_declaration(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1186" id="l1186">  1186</a>         {if (statementTrace&gt;=1) printf(&quot;external_declaration_3[%d]: Enum definition\n&quot;,LT(1).getLine());}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1187" id="l1187">  1187</a>         (LITERAL___extension__!)? declaration[declOther]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1188" id="l1188">  1188</a>         {action.end_enum_declaration(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1189" id="l1189">  1189</a>         {action.end_simple_declaration(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1190" id="l1190">  1190</a>         { #external_declaration = #(#[CSM_ENUM_DECLARATION, &quot;CSM_ENUM_DECLARATION&quot;], #external_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1191" id="l1191">  1191</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1192" id="l1192">  1192</a>         // Enum forward declaration (don't want to backtrack over this in other alts)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1193" id="l1193">  1193</a>         ((LITERAL___extension__!)? (decl_specifiers_before_type)? enum_fwd_head) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1194" id="l1194">  1194</a>         {action.simple_declaration(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1195" id="l1195">  1195</a>         {action.enum_declaration(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1196" id="l1196">  1196</a>         {if (statementTrace&gt;=1) printf(&quot;external_declaration_3[%d]: Enum definition\n&quot;,LT(1).getLine());}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1197" id="l1197">  1197</a>         (LITERAL___extension__!)? declaration[declOther]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1198" id="l1198">  1198</a>         {action.end_enum_declaration(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1199" id="l1199">  1199</a>         {action.end_simple_declaration(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1200" id="l1200">  1200</a>         { #external_declaration = #(#[CSM_ENUM_FWD_DECLARATION, &quot;CSM_ENUM_FWD_DECLARATION&quot;], #external_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1201" id="l1201">  1201</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1202" id="l1202">  1202</a> 		// Destructor DEFINITION (templated or non-templated)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1203" id="l1203">  1203</a> 		{isCPlusPlus()}?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1204" id="l1204">  1204</a> 		(   (template_head)? 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1205" id="l1205">  1205</a>                     dtor_head[true] 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1206" id="l1206">  1206</a>                     (   LCURLY
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1207" id="l1207">  1207</a>                     |   ASSIGNEQUAL (LITERAL_default | LITERAL_delete)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1208" id="l1208">  1208</a>                     )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1209" id="l1209">  1209</a>                 )=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1210" id="l1210">  1210</a> 		{if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1211" id="l1211">  1211</a> 			printf(&quot;external_declaration_4[%d]: Destructor definition\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1212" id="l1212">  1212</a> 				LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1213" id="l1213">  1213</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1214" id="l1214">  1214</a> 		(template_head)? 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1215" id="l1215">  1215</a>                 dtor_head[true]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1216" id="l1216">  1216</a>                 (   dtor_body
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1217" id="l1217">  1217</a>                 |   ASSIGNEQUAL (LITERAL_default | LITERAL_delete)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1218" id="l1218">  1218</a>                 )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1219" id="l1219">  1219</a> 		{ #external_declaration = #(#[CSM_DTOR_DEFINITION, &quot;CSM_DTOR_DEFINITION&quot;], #external_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1220" id="l1220">  1220</a> 	|
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1221" id="l1221">  1221</a> 		// Constructor DEFINITION (non-templated)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1222" id="l1222">  1222</a> 		{isCPlusPlus()}?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1223" id="l1223">  1223</a> 		(	(options {warnWhenFollowAmbig = false;}: ctor_decl_spec)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1224" id="l1224">  1224</a> 			{qualifiedItemIsOneOf(qiCtor)}?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1225" id="l1225">  1225</a> 		)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1226" id="l1226">  1226</a> 		{if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1227" id="l1227">  1227</a> 			printf(&quot;external_declaration_5[%d]: Constructor definition\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1228" id="l1228">  1228</a> 				LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1229" id="l1229">  1229</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1230" id="l1230">  1230</a> 		ctor_definition
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1231" id="l1231">  1231</a> 		{ #external_declaration = #(#[CSM_CTOR_DEFINITION, &quot;CSM_CTOR_DEFINITION&quot;], #external_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1232" id="l1232">  1232</a> 	|  
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1233" id="l1233">  1233</a> 		// User-defined type cast
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1234" id="l1234">  1234</a> 		{isCPlusPlus()}?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1235" id="l1235">  1235</a> 		((template_head)? (literal_inline | LITERAL_constexpr)? scope_override conversion_function_decl_or_def)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1236" id="l1236">  1236</a> 		{if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1237" id="l1237">  1237</a> 			printf(&quot;external_declaration_6[%d]: Operator function\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1238" id="l1238">  1238</a> 				LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1239" id="l1239">  1239</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1240" id="l1240">  1240</a> 		(template_head)? (literal_inline | LITERAL_constexpr)? s = scope_override definition = conversion_function_decl_or_def 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1241" id="l1241">  1241</a> 		{ if( definition ) #external_declaration = #(#[CSM_USER_TYPE_CAST_DEFINITION, &quot;CSM_USER_TYPE_CAST_DEFINITION&quot;], #external_declaration);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1242" id="l1242">  1242</a> 		    else	   #external_declaration = #(#[CSM_USER_TYPE_CAST_DECLARATION, &quot;CSM_USER_TYPE_CAST_DECLARATION&quot;], #external_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1243" id="l1243">  1243</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1244" id="l1244">  1244</a>         // Function declaration
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1245" id="l1245">  1245</a>         (   (LITERAL___extension__)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1246" id="l1246">  1246</a>             (options {greedy=true;} :function_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1247" id="l1247">  1247</a>             declaration_specifiers[false, false]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1248" id="l1248">  1248</a>             (options {greedy=true;} :function_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1249" id="l1249">  1249</a>             function_declarator[false, false, true] (EOF|SEMICOLON)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1250" id="l1250">  1250</a>         ) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1251" id="l1251">  1251</a>         {if (statementTrace&gt;=1) printf(&quot;external_declaration_7[%d]: Function prototype\n&quot;, LT(1).getLine());}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1252" id="l1252">  1252</a>         (LITERAL___extension__!)? (options {greedy=true;} :function_attribute_specification!)? declaration[declOther]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1253" id="l1253">  1253</a>         { #external_declaration = #(#[CSM_FUNCTION_DECLARATION, &quot;CSM_FUNCTION_DECLARATION&quot;], #external_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1254" id="l1254">  1254</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1255" id="l1255">  1255</a>         // Function declaration
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1256" id="l1256">  1256</a>         (   (LITERAL___extension__)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1257" id="l1257">  1257</a>             (options {greedy=true;} :function_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1258" id="l1258">  1258</a>             declaration_specifiers[false, false]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1259" id="l1259">  1259</a>             (options {greedy=true;} :function_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1260" id="l1260">  1260</a>             function_declarator[false, false, false] (EOF|SEMICOLON)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1261" id="l1261">  1261</a>         ) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1262" id="l1262">  1262</a>         {if (statementTrace&gt;=1) printf(&quot;external_declaration_7[%d]: Function prototype\n&quot;, LT(1).getLine());}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1263" id="l1263">  1263</a>         (LITERAL___extension__!)? (options {greedy=true;} :function_attribute_specification!)? declaration[declOther]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1264" id="l1264">  1264</a>         { #external_declaration = #(#[CSM_FUNCTION_LIKE_VARIABLE_DECLARATION, &quot;CSM_FUNCTION_LIKE_VARIABLE_DECLARATION&quot;], #external_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1265" id="l1265">  1265</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1266" id="l1266">  1266</a>         // Function declaration without literal_ident in return type
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1267" id="l1267">  1267</a>         // IZ 146150 : 'unexpected token: ;' message appears on 'extern int errno;' line
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1268" id="l1268">  1268</a>         (   (LITERAL___extension__)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1269" id="l1269">  1269</a>             (options {greedy=true;} :function_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1270" id="l1270">  1270</a>             declaration_specifiers[false, true]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1271" id="l1271">  1271</a>             (options {greedy=true;} :function_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1272" id="l1272">  1272</a>             function_declarator[false, true, false] (EOF|SEMICOLON)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1273" id="l1273">  1273</a>         ) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1274" id="l1274">  1274</a>         {if (statementTrace&gt;=1) printf(&quot;external_declaration_7[%d]: Function prototype\n&quot;, LT(1).getLine());}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1275" id="l1275">  1275</a>         (LITERAL___extension__!)? (options {greedy=true;} :function_attribute_specification!)? declaration[declOther]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1276" id="l1276">  1276</a>         { #external_declaration = #(#[CSM_FUNCTION_LIKE_VARIABLE_DECLARATION, &quot;CSM_FUNCTION_LIKE_VARIABLE_DECLARATION&quot;], #external_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1277" id="l1277">  1277</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1278" id="l1278">  1278</a>         // Extern function declaration without return type but with parameters list
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1279" id="l1279">  1279</a>         (   (LITERAL___extension__)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1280" id="l1280">  1280</a>             (options {greedy=true;} :function_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1281" id="l1281">  1281</a>             LITERAL_extern
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1282" id="l1282">  1282</a>             (options {greedy=true;} :function_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1283" id="l1283">  1283</a>             function_declarator[false, false, false] (EOF|SEMICOLON)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1284" id="l1284">  1284</a>         ) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1285" id="l1285">  1285</a>         {if (statementTrace&gt;=1) printf(&quot;external_declaration_7[%d]: Function prototype\n&quot;, LT(1).getLine());}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1286" id="l1286">  1286</a>         (LITERAL___extension__!)? (options {greedy=true;} :function_attribute_specification!)? declaration[declExternFunction]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1287" id="l1287">  1287</a>         { #external_declaration = #(#[CSM_FUNCTION_LIKE_VARIABLE_DECLARATION, &quot;CSM_FUNCTION_LIKE_VARIABLE_DECLARATION&quot;], #external_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1288" id="l1288">  1288</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1289" id="l1289">  1289</a>         // Simple function declaration without return type
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1290" id="l1290">  1290</a>         (literal_ident LPAREN (simple_parameter_list)? RPAREN (EOF|SEMICOLON)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1291" id="l1291">  1291</a>         ) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1292" id="l1292">  1292</a>         {if (statementTrace&gt;=1) printf(&quot;external_declaration_7[%d]: Function prototype\n&quot;, LT(1).getLine());}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1293" id="l1293">  1293</a>         (LITERAL___extension__!)? (options {greedy=true;} :function_attribute_specification!)? declaration[declSimpleFunction]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1294" id="l1294">  1294</a>         { #external_declaration = #(#[CSM_FUNCTION_LIKE_VARIABLE_DECLARATION, &quot;CSM_FUNCTION_LIKE_VARIABLE_DECLARATION&quot;], #external_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1295" id="l1295">  1295</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1296" id="l1296">  1296</a>         // Function definition with return value
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1297" id="l1297">  1297</a>         (   (LITERAL___extension__)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1298" id="l1298">  1298</a>             (options {greedy=true;} :function_attribute_specification!)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1299" id="l1299">  1299</a>             declaration_specifiers[false, false]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1300" id="l1300">  1300</a>             (options {greedy=true;} :function_attribute_specification!)? 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1301" id="l1301">  1301</a>             function_declarator[true, false, false] (LCURLY | literal_try | ASSIGNEQUAL (LITERAL_default | LITERAL_delete))
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1302" id="l1302">  1302</a>         ) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1303" id="l1303">  1303</a>         {if (statementTrace&gt;=1) printf(&quot;external_declaration_8[%d]: Function definition\n&quot;, LT(1).getLine());}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1304" id="l1304">  1304</a>         (LITERAL___extension__!)? (options {greedy=true;} :function_attribute_specification!)? function_definition
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1305" id="l1305">  1305</a>         { #external_declaration = #(#[CSM_FUNCTION_DEFINITION, &quot;CSM_FUNCTION_DEFINITION&quot;], #external_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1306" id="l1306">  1306</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1307" id="l1307">  1307</a>         // FIXUP: Function definition without return value
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1308" id="l1308">  1308</a>         // till not correct hanlding in function_definition (external_declaration_7)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1309" id="l1309">  1309</a>         // functions without return type
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1310" id="l1310">  1310</a> 		(function_declarator[true, false, false] (function_K_R_parameter_list)? LCURLY)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1311" id="l1311">  1311</a> 		{if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1312" id="l1312">  1312</a> 			printf(&quot;external_declaration_8a[%d]: Function definition without ret value\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1313" id="l1313">  1313</a> 				LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1314" id="l1314">  1314</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1315" id="l1315">  1315</a> 		function_definition_no_ret_type
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1316" id="l1316">  1316</a> 		{ #external_declaration = #(#[CSM_FUNCTION_DEFINITION, &quot;CSM_FUNCTION_DEFINITION&quot;], #external_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1317" id="l1317">  1317</a> 	|
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1318" id="l1318">  1318</a> 		// K &amp; R Function definition
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1319" id="l1319">  1319</a> 		(declaration_specifiers[false, false]	function_declarator[true, false, false] declaration[declOther])=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1320" id="l1320">  1320</a> 		{K_and_R = true;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1321" id="l1321">  1321</a> 		 if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1322" id="l1322">  1322</a> 			printf(&quot;external_declaration_9[%d]: K &amp; R function definition\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1323" id="l1323">  1323</a> 				LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1324" id="l1324">  1324</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1325" id="l1325">  1325</a> 		function_definition
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1326" id="l1326">  1326</a> 		{ #external_declaration = #(#[CSM_FUNCTION_DEFINITION, &quot;CSM_FUNCTION_DEFINITION&quot;], #external_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1327" id="l1327">  1327</a>         |       // function declaration with function as return type
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1328" id="l1328">  1328</a> 		((LITERAL___extension__)? declaration_specifiers[false, false] function_declarator_with_fun_as_ret_type[false] (EOF|SEMICOLON))=&gt; 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1329" id="l1329">  1329</a> 		{if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1330" id="l1330">  1330</a> 			printf(&quot;external_declaration_7a[%d]: Function prototype with function as return type\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1331" id="l1331">  1331</a> 				LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1332" id="l1332">  1332</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1333" id="l1333">  1333</a> 		function_declaration_with_fun_as_ret_type
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1334" id="l1334">  1334</a> 		{ #external_declaration = #(#[CSM_FUNCTION_RET_FUN_DECLARATION, &quot;CSM_FUNCTION_RET_FUN_DECLARATION&quot;], #external_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1335" id="l1335">  1335</a>                 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1336" id="l1336">  1336</a>         |       // function definition with function as return type
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1337" id="l1337">  1337</a>                 ((LITERAL___extension__)? declaration_specifiers[false, false] function_declarator_with_fun_as_ret_type[true] LCURLY)=&gt; 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1338" id="l1338">  1338</a> 		{if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1339" id="l1339">  1339</a> 			printf(&quot;external_declaration_8b[%d]: Function definition with function as return type\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1340" id="l1340">  1340</a> 				LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1341" id="l1341">  1341</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1342" id="l1342">  1342</a> 		function_definition_with_fun_as_ret_type
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1343" id="l1343">  1343</a> 		{ #external_declaration = #(#[CSM_FUNCTION_RET_FUN_DEFINITION, &quot;CSM_FUNCTION_RET_FUN_DEFINITION&quot;], #external_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1344" id="l1344">  1344</a> 	|
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1345" id="l1345">  1345</a>                 asm_block
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1346" id="l1346">  1346</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1347" id="l1347">  1347</a> 		{isCPlusPlus()}?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1348" id="l1348">  1348</a> 		{if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1349" id="l1349">  1349</a> 			printf(&quot;external_declaration_12[%d]: Namespace declaration\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1350" id="l1350">  1350</a> 				LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1351" id="l1351">  1351</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1352" id="l1352">  1352</a> 		decl_namespace
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1353" id="l1353">  1353</a> 		// moved to decl_namespace { #external_declaration = #(#[, &quot;&quot;], #external_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1354" id="l1354">  1354</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1355" id="l1355">  1355</a> 		{isCPlusPlus()}?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1356" id="l1356">  1356</a>             // Constructor definition with initializer
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1357" id="l1357">  1357</a>             (   ctor_decl_spec ctor_declarator[true] COLON ) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1358" id="l1358">  1358</a>             ctor_definition
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1359" id="l1359">  1359</a>             { #external_declaration = #(#[CSM_CTOR_DEFINITION, &quot;CSM_CTOR_DEFINITION&quot;], #external_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1360" id="l1360">  1360</a> 	|	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1361" id="l1361">  1361</a> 		// everything else (except templates)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1362" id="l1362">  1362</a> 		{if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1363" id="l1363">  1363</a> 			printf(&quot;external_declaration_13[%d]: Declaration\n&quot;,LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1364" id="l1364">  1364</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1365" id="l1365">  1365</a>                 // VV: 23/05/06 support for gcc's &quot;__extension__&quot;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1366" id="l1366">  1366</a> 		(LITERAL___extension__!)?  declaration[declGeneric]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1367" id="l1367">  1367</a> 		{ 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1368" id="l1368">  1368</a> 		    // if declaration itself returned proper type, don't wrap it into generic declaration
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1369" id="l1369">  1369</a> 		    if( #external_declaration != null ) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1370" id="l1370">  1370</a> 			int type = #external_declaration.getType(); 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1371" id="l1371">  1371</a> 			int childrenCnt = #external_declaration.getNumberOfChildren();
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1372" id="l1372">  1372</a> 			if( childrenCnt &gt; 0 || type &lt; CSM_START || CSM_END &lt; type ) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1373" id="l1373">  1373</a> 			    #external_declaration = #(#[CSM_GENERIC_DECLARATION, &quot;CSM_GENERIC_DECLARATION&quot;], #external_declaration);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1374" id="l1374">  1374</a> 			}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1375" id="l1375">  1375</a> 		    }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1376" id="l1376">  1376</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1377" id="l1377">  1377</a> 	|	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1378" id="l1378">  1378</a> 		{if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1379" id="l1379">  1379</a> 			printf(&quot;external_declaration_14[%d]: Semicolon\n&quot;,LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1380" id="l1380">  1380</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1381" id="l1381">  1381</a> 		SEMICOLON! //{end_of_stmt();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1382" id="l1382">  1382</a> 	)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1383" id="l1383">  1383</a> 	;	// end of external_declaration
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1384" id="l1384">  1384</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1385" id="l1385">  1385</a> decl_namespace
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1386" id="l1386">  1386</a> 	{String qid; String name = &quot;&quot;;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1387" id="l1387">  1387</a> 	:	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1388" id="l1388">  1388</a> 		(literal_inline)? token:LITERAL_namespace
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1389" id="l1389">  1389</a> 		(
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1390" id="l1390">  1390</a>                         {action.namespace_declaration(token);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1391" id="l1391">  1391</a> 			(name = literal_ident{_td = true; /*declaratorID(name,qiType);} {action.namespace_name(name);*/})?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1392" id="l1392">  1392</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1393" id="l1393">  1393</a> 			// The following statement can be invoked to trigger selective
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1394" id="l1394">  1394</a> 			// antlr trace. Also see below
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1395" id="l1395">  1395</a> 			//{
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1396" id="l1396">  1396</a> 			//	if (strcmp((ns.getText()),&quot;xyz&quot;)==0) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1397" id="l1397">  1397</a> 			//	    antlrTrace(true);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1398" id="l1398">  1398</a> 			//	 }	// Used for diagnostic trigger
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1399" id="l1399">  1399</a> 			//}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1400" id="l1400">  1400</a> 			(options {greedy=true;} : namespace_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1401" id="l1401">  1401</a>                         {action.namespace_body(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1402" id="l1402">  1402</a> 			LCURLY
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1403" id="l1403">  1403</a> 			//{enterNewLocalScope();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1404" id="l1404">  1404</a> 			((external_declaration)*)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1405" id="l1405">  1405</a> 			{/*exitLocalScope();*/{ #decl_namespace = #(#[CSM_NAMESPACE_DECLARATION, name], #decl_namespace); }}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1406" id="l1406">  1406</a>                         {action.end_namespace_body(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1407" id="l1407">  1407</a> 			token2:RCURLY {action.end_namespace_declaration(token2);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1408" id="l1408">  1408</a> 			// The following should be implemented to match the optional
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1409" id="l1409">  1409</a> 			// statement above
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1410" id="l1410">  1410</a> 			//{antlrTrace(false);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1411" id="l1411">  1411</a> 		|
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1412" id="l1412">  1412</a> 			name = literal_ident{_td = true;declaratorID((name),qiType);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1413" id="l1413">  1413</a> 			ASSIGNEQUAL qid = qualified_id SEMICOLON! 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1414" id="l1414">  1414</a> 			{/*end_of_stmt();*/#decl_namespace = #(#[CSM_NAMESPACE_ALIAS, name], #decl_namespace);} 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1415" id="l1415">  1415</a> 		)                
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1416" id="l1416">  1416</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1417" id="l1417">  1417</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1418" id="l1418">  1418</a> namespace_alias_definition
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1419" id="l1419">  1419</a> 	{String qid; String name = &quot;&quot;;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1420" id="l1420">  1420</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1421" id="l1421">  1421</a> 		lns:LITERAL_namespace
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1422" id="l1422">  1422</a> 		name = literal_ident{_td = true;declaratorID((name),qiType);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1423" id="l1423">  1423</a> 		lae:ASSIGNEQUAL 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1424" id="l1424">  1424</a>         /*{action.namespace_alias_definition(lns, ns2, lae);}*/
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1425" id="l1425">  1425</a>         qid = qualified_id 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1426" id="l1426">  1426</a>         /*{action.end_namespace_alias_definition(LT(1));}*/
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1427" id="l1427">  1427</a>         SEMICOLON!
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1428" id="l1428">  1428</a> 		{#namespace_alias_definition = #(#[CSM_NAMESPACE_ALIAS, name], #namespace_alias_definition);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1429" id="l1429">  1429</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1430" id="l1430">  1430</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1431" id="l1431">  1431</a> //
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1432" id="l1432">  1432</a> // it's a caller's responsibility to check isCPlusPlus
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1433" id="l1433">  1433</a> //
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1434" id="l1434">  1434</a> member_declaration_template
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1435" id="l1435">  1435</a> 	{String q; boolean definition=false; boolean friend = false; boolean ctorName = false;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1436" id="l1436">  1436</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1437" id="l1437">  1437</a> 		{beginTemplateDefinition();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1438" id="l1438">  1438</a> 		template_head
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1439" id="l1439">  1439</a>  		(     
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1440" id="l1440">  1440</a> 			(class_head)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1441" id="l1441">  1441</a> 			{if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1442" id="l1442">  1442</a> 				printf(&quot;member_declaration_12[%d]: Class template declaration\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1443" id="l1443">  1443</a> 					LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1444" id="l1444">  1444</a> 			}                           
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1445" id="l1445">  1445</a> 			declaration[declOther]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1446" id="l1446">  1446</a> 			{ #member_declaration_template = #(#[CSM_TEMPLATE_CLASS_DECLARATION, &quot;CSM_TEMPLATE_CLASS_DECLARATION&quot;], #member_declaration_template); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1447" id="l1447">  1447</a> 		|  
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1448" id="l1448">  1448</a> 			// Templated FUNCTIONS and CONSTRUCTORS matched here.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1449" id="l1449">  1449</a> 			// DW 27/06/03 Copied here from external_declaration since templates
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1450" id="l1450">  1450</a> 			// can now be nested
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1451" id="l1451">  1451</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1452" id="l1452">  1452</a> 			// Templated CONSTRUCTOR declaration
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1453" id="l1453">  1453</a>                         (	ctor_decl_spec
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1454" id="l1454">  1454</a>                                 {qualifiedItemIsOneOf(qiCtor)}?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1455" id="l1455">  1455</a>                                 ctor_declarator[false] (EOF|SEMICOLON)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1456" id="l1456">  1456</a>                         )=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1457" id="l1457">  1457</a>                         {if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1458" id="l1458">  1458</a>                                 printf(&quot;member_declaration_13[%d]: Constructor declarator\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1459" id="l1459">  1459</a>                                         LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1460" id="l1460">  1460</a>                         }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1461" id="l1461">  1461</a>                         friend = ctor_decl_spec
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1462" id="l1462">  1462</a>                         ctorName = ctor_declarator[false] 	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1463" id="l1463">  1463</a>                         ( EOF! { reportError(new NoViableAltException(org.netbeans.modules.cnd.apt.utils.APTUtils.EOF_TOKEN, getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1464" id="l1464">  1464</a>                         | SEMICOLON ) // Constructor declarator
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1465" id="l1465">  1465</a>                         {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1466" id="l1466">  1466</a>                         // below is a workaround for know infinite loop bug in ANTLR 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1467" id="l1467">  1467</a>                         // see http://www.jguru.com/faq/view.jsp?EID=271922
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1468" id="l1468">  1468</a>                         //if( #cds1 != null ) { #cds1.setNextSibling(null); }; 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1469" id="l1469">  1469</a>                         #member_declaration_template = #(#[CSM_CTOR_TEMPLATE_DECLARATION, &quot;CSM_CTOR_TEMPLATE_DECLARATION&quot;],  #member_declaration_template); //end_of_stmt();
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1470" id="l1470">  1470</a>                         }   
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1471" id="l1471">  1471</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1472" id="l1472">  1472</a>                   |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1473" id="l1473">  1473</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1474" id="l1474">  1474</a> 			// Templated CONSTRUCTOR definition
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1475" id="l1475">  1475</a> 			// JEL 4/3/96 Added predicate that works once the
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1476" id="l1476">  1476</a> 			// restriction is added that ctor cannot be virtual
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1477" id="l1477">  1477</a> 			(ctor_decl_spec
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1478" id="l1478">  1478</a> 			 {qualifiedItemIsOneOf(qiCtor)}?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1479" id="l1479">  1479</a> 			 ctor_declarator[true]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1480" id="l1480">  1480</a> 			 ( COLON        // DEFINITION :ctor_initializer
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1481" id="l1481">  1481</a> 			  |LCURLY       // DEFINITION (compound Statement) ?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1482" id="l1482">  1482</a>                           | ASSIGNEQUAL (LITERAL_default | LITERAL_delete)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1483" id="l1483">  1483</a> 			 )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1484" id="l1484">  1484</a> 			)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1485" id="l1485">  1485</a> 			{if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1486" id="l1486">  1486</a> 				printf(&quot;member_declaration_13a[%d]: Template constructor &quot; +
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1487" id="l1487">  1487</a> 					&quot;definition\n&quot;, LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1488" id="l1488">  1488</a> 			}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1489" id="l1489">  1489</a> 			ctor_definition
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1490" id="l1490">  1490</a> 			{ #member_declaration_template = #(#[CSM_CTOR_TEMPLATE_DEFINITION, &quot;CSM_CTOR_TEMPLATE_DEFINITION&quot;], #member_declaration_template); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1491" id="l1491">  1491</a> 		|
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1492" id="l1492">  1492</a> 			// Templated function declaration
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1493" id="l1493">  1493</a> 			(declaration_specifiers[false, false] function_declarator[false, false, false] SEMICOLON)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1494" id="l1494">  1494</a> 			{if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1495" id="l1495">  1495</a> 				printf(&quot;member_declaration_13b[%d]: Function template &quot; +
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1496" id="l1496">  1496</a> 					&quot;declaration\n&quot;, LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1497" id="l1497">  1497</a> 			}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1498" id="l1498">  1498</a> 			declaration[declOther]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1499" id="l1499">  1499</a> 			{ #member_declaration_template = #(#[CSM_FUNCTION_TEMPLATE_DECLARATION, &quot;CSM_FUNCTION_TEMPLATE_DECLARATION&quot;], #member_declaration_template); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1500" id="l1500">  1500</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1501" id="l1501">  1501</a>         // Templated function definition
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1502" id="l1502">  1502</a>         // Function definition DW 2/6/97
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1503" id="l1503">  1503</a>         (declaration_specifiers[false, false] function_declarator[true, false, false] (LCURLY | literal_try | ASSIGNEQUAL (LITERAL_default | LITERAL_delete)))=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1504" id="l1504">  1504</a>         {if (statementTrace&gt;=1) printf(&quot;member_declaration_13c[%d]: Function template &quot; + &quot;definition\n&quot;, LT(1).getLine());}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1505" id="l1505">  1505</a>         function_definition
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1506" id="l1506">  1506</a>         { #member_declaration_template = #(#[CSM_FUNCTION_TEMPLATE_DEFINITION, &quot;CSM_FUNCTION_TEMPLATE_DEFINITION&quot;], #member_declaration_template); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1507" id="l1507">  1507</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1508" id="l1508">  1508</a>         (   ((options {greedy=true;} :function_attribute_specification)|literal_inline|LITERAL_constexpr|LITERAL_explicit)*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1509" id="l1509">  1509</a>             conversion_function_decl_or_def
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1510" id="l1510">  1510</a>         ) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1511" id="l1511">  1511</a>         {if (statementTrace&gt;=1) printf(&quot;member_declaration_13d[%d]: Templated operator &quot; + &quot;function\n&quot;, LT(1).getLine());}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1512" id="l1512">  1512</a>         ((options {greedy=true;} :function_attribute_specification)|literal_inline|LITERAL_constexpr|LITERAL_explicit)*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1513" id="l1513">  1513</a>         definition = conversion_function_decl_or_def
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1514" id="l1514">  1514</a>         {if( definition )   #member_declaration_template = #(#[CSM_USER_TYPE_CAST_TEMPLATE_DEFINITION, &quot;CSM_USER_TYPE_CAST_TEMPLATE_DEFINITION&quot;], #member_declaration_template);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1515" id="l1515">  1515</a>          else               #member_declaration_template = #(#[CSM_USER_TYPE_CAST_TEMPLATE_DECLARATION, &quot;CSM_USER_TYPE_CAST_TEMPLATE_DECLARATION&quot;], #member_declaration_template);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1516" id="l1516">  1516</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1517" id="l1517">  1517</a>         (LITERAL_using literal_ident ASSIGNEQUAL) =&gt; alias_declaration
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1518" id="l1518">  1518</a>         { #member_declaration_template = #(#[CSM_FIELD, &quot;CSM_FIELD&quot;], #member_declaration_template); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1519" id="l1519">  1519</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1520" id="l1520">  1520</a>                         // this rule must be after handling functions 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1521" id="l1521">  1521</a> 			// templated forward class decl, init/decl of static member in template
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1522" id="l1522">  1522</a> 			(declaration_specifiers[true, false]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1523" id="l1523">  1523</a> 				(init_declarator_list[declOther])? SEMICOLON /*{end_of_stmt();}*/)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1524" id="l1524">  1524</a> 			//{beginTemplateDeclaration();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1525" id="l1525">  1525</a> 			{ if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1526" id="l1526">  1526</a> 				printf(&quot;member_declaration_12a[%d]: Class template declaration\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1527" id="l1527">  1527</a> 					LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1528" id="l1528">  1528</a> 			}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1529" id="l1529">  1529</a> 			declaration_specifiers[true, false]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1530" id="l1530">  1530</a> 				(init_declarator_list[declOther])? SEMICOLON //{end_of_stmt();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1531" id="l1531">  1531</a> 			{/*endTemplateDeclaration();*/ #member_declaration_template = #(#[CSM_TEMPL_FWD_CL_OR_STAT_MEM, &quot;CSM_TEMPL_FWD_CL_OR_STAT_MEM&quot;], #member_declaration_template); } 		
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1532" id="l1532">  1532</a> 		)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1533" id="l1533">  1533</a> 		{endTemplateDefinition();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1534" id="l1534">  1534</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1535" id="l1535">  1535</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1536" id="l1536">  1536</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1537" id="l1537">  1537</a> member_declaration
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1538" id="l1538">  1538</a> 	{String q; boolean definition;boolean ctrName=false;StorageClass sc = scInvalid;int ts = 0;boolean friend = false;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1539" id="l1539">  1539</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1540" id="l1540">  1540</a> 	(
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1541" id="l1541">  1541</a> 		// Class definition
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1542" id="l1542">  1542</a> 		// This is separated out otherwise the next alternative
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1543" id="l1543">  1543</a> 		// would look for &quot;class A { ... } f() {...}&quot; which is
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1544" id="l1544">  1544</a> 		// an unacceptable level of backtracking.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1545" id="l1545">  1545</a>                 // we need &quot;static&quot; here for the case &quot;static struct XX {...} myVar; - see issue #135149
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1546" id="l1546">  1546</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1547" id="l1547">  1547</a> //		((LITERAL_typedef | LITERAL_static)? class_head)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1548" id="l1548">  1548</a>         ((LITERAL___extension__!)? (decl_specifiers_before_type)? class_head) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1549" id="l1549">  1549</a>         {action.simple_declaration(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1550" id="l1550">  1550</a>         {action.class_declaration(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1551" id="l1551">  1551</a> 		{if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1552" id="l1552">  1552</a> 			printf(&quot;member_declaration_1[%d]: Class definition\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1553" id="l1553">  1553</a> 				LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1554" id="l1554">  1554</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1555" id="l1555">  1555</a> 		(LITERAL___extension__!)? declaration[declOther]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1556" id="l1556">  1556</a> 		{ #member_declaration = #(#[CSM_CLASS_DECLARATION, &quot;CSM_CLASS_DECLARATION&quot;], #member_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1557" id="l1557">  1557</a> 	|  
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1558" id="l1558">  1558</a> 		// Enum definition (don't want to backtrack over this in other alts)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1559" id="l1559">  1559</a> 		((LITERAL___extension__!)? (decl_specifiers_before_type)? enum_def_head)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1560" id="l1560">  1560</a>         {action.simple_declaration(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1561" id="l1561">  1561</a>         {action.enum_declaration(LT(1));} 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1562" id="l1562">  1562</a> 		{if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1563" id="l1563">  1563</a> 			printf(&quot;member_declaration_2[%d]: Enum definition\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1564" id="l1564">  1564</a> 				LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1565" id="l1565">  1565</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1566" id="l1566">  1566</a> 		(LITERAL___extension__!)? declaration_specifiers[true, false] (member_declarator_list)? 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1567" id="l1567">  1567</a>         {action.end_enum_declaration(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1568" id="l1568">  1568</a>         {action.end_simple_declaration(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1569" id="l1569">  1569</a>         SEMICOLON	//{end_of_stmt();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1570" id="l1570">  1570</a> 		{ #member_declaration = #(#[CSM_ENUM_DECLARATION, &quot;CSM_ENUM_DECLARATION&quot;], #member_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1571" id="l1571">  1571</a> 	|
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1572" id="l1572">  1572</a> 		// Enum forward declaration (don't want to backtrack over this in other alts)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1573" id="l1573">  1573</a> 		((LITERAL___extension__!)? (decl_specifiers_before_type)? enum_fwd_head)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1574" id="l1574">  1574</a>         {action.simple_declaration(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1575" id="l1575">  1575</a>         {action.enum_declaration(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1576" id="l1576">  1576</a>         (LITERAL___extension__!)? 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1577" id="l1577">  1577</a>         (decl_specifiers_before_type)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1578" id="l1578">  1578</a> 		{if (statementTrace&gt;=1)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1579" id="l1579">  1579</a> 			printf(&quot;member_declaration_2b[%d]: Enum forward declaration\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1580" id="l1580">  1580</a> 				LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1581" id="l1581">  1581</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1582" id="l1582">  1582</a> 		enum_specifier
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1583" id="l1583">  1583</a>         {action.end_enum_declaration(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1584" id="l1584">  1584</a>         {action.end_simple_declaration(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1585" id="l1585">  1585</a>         SEMICOLON	//{end_of_stmt();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1586" id="l1586">  1586</a> 		{ #member_declaration = #(#[CSM_ENUM_FWD_DECLARATION, &quot;CSM_ENUM_FWD_DECLARATION&quot;], #member_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1587" id="l1587">  1587</a> 	|	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1588" id="l1588">  1588</a> 		// Constructor declarator
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1589" id="l1589">  1589</a> 		(	ctor_decl_spec
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1590" id="l1590">  1590</a> 			/*{qualifiedItemIsOneOf(qiCtor)}?*/
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1591" id="l1591">  1591</a> 			ctor_declarator[false] (EOF|SEMICOLON)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1592" id="l1592">  1592</a> 		)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1593" id="l1593">  1593</a> 		{if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1594" id="l1594">  1594</a> 			printf(&quot;member_declaration_3[%d]: Constructor or no-ret type fun declarator\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1595" id="l1595">  1595</a> 				LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1596" id="l1596">  1596</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1597" id="l1597">  1597</a> 		friend = cds:ctor_decl_spec
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1598" id="l1598">  1598</a> //                {ctrName = qualifiedItemIsOneOf(qiCtor);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1599" id="l1599">  1599</a> 		ctrName = cd:ctor_declarator[false] 	(EOF!|SEMICOLON) // Constructor declarator
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1600" id="l1600">  1600</a> 		{
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1601" id="l1601">  1601</a>                     // below is a workaround for know infinite loop bug in ANTLR 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1602" id="l1602">  1602</a>                     // see http://www.jguru.com/faq/view.jsp?EID=271922
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1603" id="l1603">  1603</a>                     if( #cds != null ) { #cds.setNextSibling(null); }; 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1604" id="l1604">  1604</a>                     if (ctrName &amp;&amp; !friend) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1605" id="l1605">  1605</a>                         #member_declaration = #(#[CSM_CTOR_DECLARATION, &quot;CSM_CTOR_DECLARATION&quot;], #cds, #cd); //end_of_stmt();
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1606" id="l1606">  1606</a>                     } else {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1607" id="l1607">  1607</a>                         #member_declaration = #(#[CSM_FUNCTION_DECLARATION, &quot;CSM_FUNCTION_DECLARATION&quot;], #cds, #cd); //end_of_stmt();
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1608" id="l1608">  1608</a>                     }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1609" id="l1609">  1609</a>                 }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1610" id="l1610">  1610</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1611" id="l1611">  1611</a>         // JEL Predicate to distinguish ctor from function
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1612" id="l1612">  1612</a>         // This works now that ctor cannot have VIRTUAL
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1613" id="l1613">  1613</a>         // It unfortunately matches A::A where A is not enclosing
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1614" id="l1614">  1614</a>         // class -- this will have to be checked semantically
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1615" id="l1615">  1615</a>         (   ctor_decl_spec
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1616" id="l1616">  1616</a>             /*{qualifiedItemIsOneOf(qiCtor)}?*/
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1617" id="l1617">  1617</a>             ctor_declarator[true]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1618" id="l1618">  1618</a>             (COLON        // DEFINITION :ctor_initializer
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1619" id="l1619">  1619</a>             |LCURLY       // DEFINITION (compound Statement) ?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1620" id="l1620">  1620</a>             |literal_try  // DEFINITION try ... catch ...
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1621" id="l1621">  1621</a>             | ASSIGNEQUAL (LITERAL_default | LITERAL_delete)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1622" id="l1622">  1622</a>             )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1623" id="l1623">  1623</a>         )=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1624" id="l1624">  1624</a>         {if (statementTrace&gt;=1) printf(&quot;member_declaration_4[%d]: Constructor or no-ret type fun definition\n&quot;, LT(1).getLine());}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1625" id="l1625">  1625</a>         friend = ctor_decl_spec
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1626" id="l1626">  1626</a> //        {ctrName = qualifiedItemIsOneOf(qiCtor);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1627" id="l1627">  1627</a>         ctrName = ctor_declarator[true]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1628" id="l1628">  1628</a>         (   ctor_body
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1629" id="l1629">  1629</a>         |   ASSIGNEQUAL (LITERAL_default | LITERAL_delete)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1630" id="l1630">  1630</a>         )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1631" id="l1631">  1631</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1632" id="l1632">  1632</a>         {if (ctrName &amp;&amp; !friend) { #member_declaration = #(#[CSM_CTOR_DEFINITION, &quot;CSM_CTOR_DEFINITION&quot;], #member_declaration);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1633" id="l1633">  1633</a>          else { #member_declaration = #(#[CSM_FUNCTION_DEFINITION, &quot;CSM_FUNCTION_DEFINITION&quot;], #member_declaration);}}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1634" id="l1634">  1634</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1635" id="l1635">  1635</a>         // Destructor declarator
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1636" id="l1636">  1636</a>         // No template_head allowed for dtor member
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1637" id="l1637">  1637</a>         // Backtrack if not a dtor (no TILDE)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1638" id="l1638">  1638</a>         (dtor_head[false] (EOF|SEMICOLON))=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1639" id="l1639">  1639</a>         {if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1640" id="l1640">  1640</a>                 printf(&quot;member_declaration_5a[%d]: Destructor declaration\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1641" id="l1641">  1641</a>                         LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1642" id="l1642">  1642</a>         }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1643" id="l1643">  1643</a>         // This is inlined dtor_head rule (here it is necessary to know if destructor is friend)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1644" id="l1644">  1644</a>         friend = dtor_decl_spec        
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1645" id="l1645">  1645</a>         dtor_declarator[false]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1646" id="l1646">  1646</a>         ( 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1647" id="l1647">  1647</a>             EOF! { reportError(new NoViableAltException(org.netbeans.modules.cnd.apt.utils.APTUtils.EOF_TOKEN, getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1648" id="l1648">  1648</a>         | 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1649" id="l1649">  1649</a>             SEMICOLON 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1650" id="l1650">  1650</a>         ) //{end_of_stmt();}	// Declaration        
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1651" id="l1651">  1651</a>         {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1652" id="l1652">  1652</a>             if (!friend) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1653" id="l1653">  1653</a>                 #member_declaration = #(#[CSM_DTOR_DECLARATION, &quot;CSM_DTOR_DECLARATION&quot;], #member_declaration); //end_of_stmt();
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1654" id="l1654">  1654</a>             } else {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1655" id="l1655">  1655</a>                 #member_declaration = #(#[CSM_FUNCTION_DECLARATION, &quot;CSM_FUNCTION_DECLARATION&quot;], #member_declaration); //end_of_stmt();
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1656" id="l1656">  1656</a>             }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1657" id="l1657">  1657</a>         }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1658" id="l1658">  1658</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1659" id="l1659">  1659</a>         // Destructor definition
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1660" id="l1660">  1660</a>         // No template_head allowed for dtor member
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1661" id="l1661">  1661</a>         // Backtrack if not a dtor (no TILDE)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1662" id="l1662">  1662</a>         (   dtor_head[true] 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1663" id="l1663">  1663</a>             (   LCURLY
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1664" id="l1664">  1664</a>             |   ASSIGNEQUAL (LITERAL_default | LITERAL_delete)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1665" id="l1665">  1665</a>             )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1666" id="l1666">  1666</a>         )=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1667" id="l1667">  1667</a>         {if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1668" id="l1668">  1668</a>                 printf(&quot;member_declaration_5b[%d]: Destructor definition\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1669" id="l1669">  1669</a>                         LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1670" id="l1670">  1670</a>         }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1671" id="l1671">  1671</a> 		dtor_head[true] 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1672" id="l1672">  1672</a>         (   dtor_body
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1673" id="l1673">  1673</a>         |   ASSIGNEQUAL (LITERAL_default | LITERAL_delete)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1674" id="l1674">  1674</a>         )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1675" id="l1675">  1675</a> 	{ #member_declaration = #(#[CSM_DTOR_DEFINITION, &quot;CSM_DTOR_DEFINITION&quot;], #member_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1676" id="l1676">  1676</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1677" id="l1677">  1677</a>         // Function declaration
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1678" id="l1678">  1678</a>         (   (LITERAL___extension__)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1679" id="l1679">  1679</a>             declaration_specifiers[false, false]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1680" id="l1680">  1680</a>             function_declarator[false, false, false]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1681" id="l1681">  1681</a>             (EOF|SEMICOLON)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1682" id="l1682">  1682</a>         ) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1683" id="l1683">  1683</a>         {if (statementTrace&gt;=1) printf(&quot;member_declaration_6[%d]: Function declaration\n&quot;, LT(1).getLine());}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1684" id="l1684">  1684</a>         declaration[declOther]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1685" id="l1685">  1685</a>         { #member_declaration = #(#[CSM_FUNCTION_DECLARATION, &quot;CSM_FUNCTION_DECLARATION&quot;], #member_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1686" id="l1686">  1686</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1687" id="l1687">  1687</a>         // Function definition
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1688" id="l1688">  1688</a>         (   (LITERAL___extension__)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1689" id="l1689">  1689</a>             declaration_specifiers[false, false]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1690" id="l1690">  1690</a>             function_declarator[true, false, false]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1691" id="l1691">  1691</a>             (LCURLY | literal_try | ASSIGNEQUAL (LITERAL_default | LITERAL_delete))
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1692" id="l1692">  1692</a>         ) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1693" id="l1693">  1693</a>         {beginFieldDeclaration(); if(statementTrace&gt;=1) printf(&quot;member_declaration_7[%d]: Function definition\n&quot;, LT(1).getLine());}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1694" id="l1694">  1694</a>         function_definition
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1695" id="l1695">  1695</a>         { #member_declaration = #(#[CSM_FUNCTION_DEFINITION, &quot;CSM_FUNCTION_DEFINITION&quot;], #member_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1696" id="l1696">  1696</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1697" id="l1697">  1697</a>         // Member without a type (I guess it can only be a function declaration or definition)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1698" id="l1698">  1698</a>         ((LITERAL_static)? function_declarator[false, false, false] (EOF|SEMICOLON))=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1699" id="l1699">  1699</a> 		{beginFieldDeclaration();
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1700" id="l1700">  1700</a>                 if( reportOddWarnings ) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1701" id="l1701">  1701</a>                     printf(&quot;member_declaration[%d]: Warning Function declaration found without typename\n&quot;, LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1702" id="l1702">  1702</a>                 }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1703" id="l1703">  1703</a> 		if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1704" id="l1704">  1704</a> 			printf(&quot;member_declaration_11a[%d]: Function declaration\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1705" id="l1705">  1705</a> 				LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1706" id="l1706">  1706</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1707" id="l1707">  1707</a> 		(LITERAL_static)? function_declarator[false, false, false] 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1708" id="l1708">  1708</a>         ( EOF! { reportError(new NoViableAltException(org.netbeans.modules.cnd.apt.utils.APTUtils.EOF_TOKEN, getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1709" id="l1709">  1709</a>         | SEMICOLON ) //{end_of_stmt();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1710" id="l1710">  1710</a> 		{ #member_declaration = #(#[CSM_FUNCTION_DECLARATION, &quot;CSM_FUNCTION_DECLARATION&quot;], #member_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1711" id="l1711">  1711</a> 	|
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1712" id="l1712">  1712</a> 		// Member without a type (I guess it can only be a function definition)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1713" id="l1713">  1713</a> 		((LITERAL_static)? function_declarator[true, false, false] LCURLY)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1714" id="l1714">  1714</a> 		{
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1715" id="l1715">  1715</a>                     if( reportOddWarnings ) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1716" id="l1716">  1716</a>                         printf(&quot;member_function[%d]: Warning Function definition found without typename\n&quot;, LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1717" id="l1717">  1717</a>                     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1718" id="l1718">  1718</a> 		    if (statementTrace&gt;=1) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1719" id="l1719">  1719</a> 			printf(&quot;member_declaration_11b[%d]: Function definition\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1720" id="l1720">  1720</a> 				LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1721" id="l1721">  1721</a> 		    }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1722" id="l1722">  1722</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1723" id="l1723">  1723</a> 		(LITERAL_static)? function_declarator[true, false, false] compound_statement //{endFunctionDefinition();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1724" id="l1724">  1724</a> 		{ #member_declaration = #(#[CSM_FUNCTION_DEFINITION, &quot;CSM_FUNCTION_DEFINITION&quot;], #member_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1725" id="l1725">  1725</a>         |       
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1726" id="l1726">  1726</a>                 // function declaration with function as return type
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1727" id="l1727">  1727</a> 		((LITERAL___extension__)? declaration_specifiers[false, false] function_declarator_with_fun_as_ret_type[false] (EOF|SEMICOLON))=&gt; 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1728" id="l1728">  1728</a> 		{if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1729" id="l1729">  1729</a> 			printf(&quot;external_declaration_7a[%d]: Function prototype with function as return type\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1730" id="l1730">  1730</a> 				LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1731" id="l1731">  1731</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1732" id="l1732">  1732</a> 		function_declaration_with_fun_as_ret_type
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1733" id="l1733">  1733</a> 		{ #member_declaration = #(#[CSM_FUNCTION_RET_FUN_DECLARATION, &quot;CSM_FUNCTION_RET_FUN_DECLARATION&quot;], #member_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1734" id="l1734">  1734</a>                 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1735" id="l1735">  1735</a>         |       // function definition with function as return type
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1736" id="l1736">  1736</a>                 ((LITERAL___extension__)? declaration_specifiers[false, false] function_declarator_with_fun_as_ret_type[true] LCURLY)=&gt; 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1737" id="l1737">  1737</a> 		{if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1738" id="l1738">  1738</a> 			printf(&quot;external_declaration_8b[%d]: Function definition with function as return type\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1739" id="l1739">  1739</a> 				LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1740" id="l1740">  1740</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1741" id="l1741">  1741</a> 		function_definition_with_fun_as_ret_type
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1742" id="l1742">  1742</a> 		{ #member_declaration = #(#[CSM_FUNCTION_RET_FUN_DEFINITION, &quot;CSM_FUNCTION_RET_FUN_DEFINITION&quot;], #member_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1743" id="l1743">  1743</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1744" id="l1744">  1744</a>         // User-defined type cast
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1745" id="l1745">  1745</a>         (   ((options {greedy=true;} :function_attribute_specification)|literal_inline|LITERAL_virtual|LITERAL_constexpr|LITERAL_explicit)*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1746" id="l1746">  1746</a>             conversion_function_decl_or_def
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1747" id="l1747">  1747</a>         ) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1748" id="l1748">  1748</a>         {if (statementTrace&gt;=1) printf(&quot;member_declaration_8[%d]: Operator function\n&quot;, LT(1).getLine());}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1749" id="l1749">  1749</a>         ((options {greedy=true;} :function_attribute_specification)|literal_inline|LITERAL_virtual|LITERAL_constexpr|LITERAL_explicit)*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1750" id="l1750">  1750</a>         definition = conversion_function_decl_or_def
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1751" id="l1751">  1751</a>         {if( definition )   #member_declaration = #(#[CSM_USER_TYPE_CAST_DEFINITION, &quot;CSM_USER_TYPE_CAST_DEFINITION&quot;], #member_declaration);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1752" id="l1752">  1752</a>          else               #member_declaration = #(#[CSM_USER_TYPE_CAST_DECLARATION, &quot;CSM_USER_TYPE_CAST_DECLARATION&quot;], #member_declaration);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1753" id="l1753">  1753</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1754" id="l1754">  1754</a>         // Hack to handle decls like &quot;superclass::member&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1755" id="l1755">  1755</a>         // to redefine access to private base class public members
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1756" id="l1756">  1756</a>         (qualified_id (EOF|SEMICOLON))=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1757" id="l1757">  1757</a>         {if (statementTrace&gt;=1) printf(&quot;member_declaration_9[%d]: Qualified literal_ident\n&quot;, LT(1).getLine());}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1758" id="l1758">  1758</a>         visibility_redef_declaration
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1759" id="l1759">  1759</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1760" id="l1760">  1760</a> 		// Member with a type or just a type def
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1761" id="l1761">  1761</a> 		// A::T a(), ::T a, ::B a, void a, E a (where E is the enclosing class)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1762" id="l1762">  1762</a> 		((LITERAL___extension__)? declaration_specifiers[true, false])=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1763" id="l1763">  1763</a> 		{beginFieldDeclaration();
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1764" id="l1764">  1764</a> 		 if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1765" id="l1765">  1765</a> 			printf(&quot;member_declaration_10[%d]: Declaration(s)\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1766" id="l1766">  1766</a> 				LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1767" id="l1767">  1767</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1768" id="l1768">  1768</a> 		(LITERAL___extension__!)? declaration_specifiers[true, false] (member_declarator_list)? 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1769" id="l1769">  1769</a>         ( EOF! { reportError(new NoViableAltException(org.netbeans.modules.cnd.apt.utils.APTUtils.EOF_TOKEN, getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1770" id="l1770">  1770</a>         | SEMICOLON) //{end_of_stmt();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1771" id="l1771">  1771</a>                 // now member typedefs are placed under CSM_FIELD, so we do this here as well
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1772" id="l1772">  1772</a>                 // TODO: separate imaginery AST nodes for typedefs and fields
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1773" id="l1773">  1773</a> 		{ #member_declaration = #(#[CSM_FIELD, &quot;CSM_FIELD&quot;], #member_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1774" id="l1774">  1774</a> 	|  
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1775" id="l1775">  1775</a> 		{isCPlusPlus()}? ((LITERAL_export)? LITERAL_template) =&gt; member_declaration_template
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1776" id="l1776">  1776</a> 	|  
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1777" id="l1777">  1777</a> 		{if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1778" id="l1778">  1778</a> 			printf(&quot;member_declaration_14[%d]: Access specifier\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1779" id="l1779">  1779</a> 			    LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1780" id="l1780">  1780</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1781" id="l1781">  1781</a> 		access_specifier COLON!
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1782" id="l1782">  1782</a> 	|  
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1783" id="l1783">  1783</a> 		{if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1784" id="l1784">  1784</a> 			printf(&quot;member_declaration_15[%d]: Semicolon\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1785" id="l1785">  1785</a> 				LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1786" id="l1786">  1786</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1787" id="l1787">  1787</a> 		SEMICOLON! //{end_of_stmt();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1788" id="l1788">  1788</a>         |       (LITERAL_using literal_ident ASSIGNEQUAL) =&gt; alias_declaration
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1789" id="l1789">  1789</a>                 { #member_declaration = #(#[CSM_FIELD, &quot;CSM_FIELD&quot;], #member_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1790" id="l1790">  1790</a> 	|	using_declaration
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1791" id="l1791">  1791</a>         |       static_assert_declaration
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1792" id="l1792">  1792</a> 	)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1793" id="l1793">  1793</a> 	;	// end member_declaration
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1794" id="l1794">  1794</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1795" id="l1795">  1795</a> // FIXUP: till qualifiedItemIsOneOf(qiType | qiCtor) is not correct in function_definition
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1796" id="l1796">  1796</a> function_definition_no_ret_type
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1797" id="l1797">  1797</a> 	:	// don't want next action as an init-action due to (...)=&gt; caller
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1798" id="l1798">  1798</a> 	//{ beginFunctionDefinition(); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1799" id="l1799">  1799</a> 	(	// Next line is equivalent to guarded predicate in PCCTS
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1800" id="l1800">  1800</a> 		function_declarator[true, false, false]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1801" id="l1801">  1801</a> 		(	options{warnWhenFollowAmbig = false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1802" id="l1802">  1802</a> 			//(declaration)*	// Possible for K &amp; R definition
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1803" id="l1803">  1803</a>                         (function_K_R_parameter_list)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1804" id="l1804">  1804</a> 			{in_parameter_list = false;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1805" id="l1805">  1805</a> 		)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1806" id="l1806">  1806</a> 		compound_statement
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1807" id="l1807">  1807</a> 	)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1808" id="l1808">  1808</a> 	//{endFunctionDefinition();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1809" id="l1809">  1809</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1810" id="l1810">  1810</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1811" id="l1811">  1811</a> function_declarator_with_fun_as_ret_type  [boolean definition]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1812" id="l1812">  1812</a>         :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1813" id="l1813">  1813</a>                 (ptr_operator)=&gt; ptr_operator function_declarator_with_fun_as_ret_type[definition]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1814" id="l1814">  1814</a>             |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1815" id="l1815">  1815</a>                 LPAREN function_declarator[definition, false, false] RPAREN 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1816" id="l1816">  1816</a>                 function_params
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1817" id="l1817">  1817</a>                 (options{greedy = true;} : fun_cv_qualifier_seq)? // TODO: check if here could be cv qualifiers
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1818" id="l1818">  1818</a>                 (options{greedy = true;} : ref_qualifier)?        // TODO: check if here could be ref qualifier
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1819" id="l1819">  1819</a>                 (exception_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1820" id="l1820">  1820</a>         ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1821" id="l1821">  1821</a>     
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1822" id="l1822">  1822</a> function_declaration_with_fun_as_ret_type
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1823" id="l1823">  1823</a>         :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1824" id="l1824">  1824</a>             declaration_specifiers[false, false] function_declarator_with_fun_as_ret_type[false] 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1825" id="l1825">  1825</a>             ( EOF! { reportError(new NoViableAltException(org.netbeans.modules.cnd.apt.utils.APTUtils.EOF_TOKEN, getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1826" id="l1826">  1826</a>             | SEMICOLON )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1827" id="l1827">  1827</a>         ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1828" id="l1828">  1828</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1829" id="l1829">  1829</a> function_definition_with_fun_as_ret_type
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1830" id="l1830">  1830</a>         :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1831" id="l1831">  1831</a> 		declaration_specifiers[false, false] function_declarator_with_fun_as_ret_type[true]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1832" id="l1832">  1832</a> 		(	options{warnWhenFollowAmbig = false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1833" id="l1833">  1833</a> 			//(declaration)*	// Possible for K &amp; R definition
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1834" id="l1834">  1834</a>                         (function_K_R_parameter_list)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1835" id="l1835">  1835</a> 			{in_parameter_list = false;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1836" id="l1836">  1836</a> 		)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1837" id="l1837">  1837</a> 		compound_statement
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1838" id="l1838">  1838</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1839" id="l1839">  1839</a>         ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1840" id="l1840">  1840</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1841" id="l1841">  1841</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1842" id="l1842">  1842</a> function_K_R_parameter_list
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1843" id="l1843">  1843</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1844" id="l1844">  1844</a>     (function_K_R_parameter)+
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1845" id="l1845">  1845</a>     {#function_K_R_parameter_list = #(#[CSM_KR_PARMLIST, &quot;CSM_KR_PARMLIST&quot;], #function_K_R_parameter_list);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1846" id="l1846">  1846</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1847" id="l1847">  1847</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1848" id="l1848">  1848</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1849" id="l1849">  1849</a> function_K_R_parameter
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1850" id="l1850">  1850</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1851" id="l1851">  1851</a>     declaration[declFunctionParam]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1852" id="l1852">  1852</a>     {#function_K_R_parameter=#(#[CSM_PARAMETER_DECLARATION, &quot;CSM_PARAMETER_DECLARATION&quot;], #function_K_R_parameter);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1853" id="l1853">  1853</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1854" id="l1854">  1854</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1855" id="l1855">  1855</a> function_definition
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1856" id="l1856">  1856</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1857" id="l1857">  1857</a>     // don't want next action as an init-action due to (...)=&gt; caller
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1858" id="l1858">  1858</a>     // IZ 132404 : Parser failed on code taken from boost
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1859" id="l1859">  1859</a>     //	//{ beginFunctionDefinition(); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1860" id="l1860">  1860</a>     //	(	// Next line is equivalent to guarded predicate in PCCTS
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1861" id="l1861">  1861</a>     //		// (SCOPE | literal_ident)? =&gt; &lt;&lt;qualifiedItemIsOneOf(qiType|qiCtor)&gt;&gt;?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1862" id="l1862">  1862</a>     //              {( !(LA(1)==SCOPE || LA(1)==literal_ident) || qualifiedItemIsOneOf(qiType | qiCtor) )}?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1863" id="l1863">  1863</a>     declaration_specifiers[false, false]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1864" id="l1864">  1864</a>     (options {greedy=true;} :function_attribute_specification!)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1865" id="l1865">  1865</a>     function_declarator[true, false, false]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1866" id="l1866">  1866</a>     (   options{warnWhenFollowAmbig = false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1867" id="l1867">  1867</a>         //(declaration)*	// Possible for K &amp; R definition
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1868" id="l1868">  1868</a>         (function_K_R_parameter_list)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1869" id="l1869">  1869</a>         {in_parameter_list = false;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1870" id="l1870">  1870</a>     )?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1871" id="l1871">  1871</a>     (   ASSIGNEQUAL (LITERAL_default | LITERAL_delete)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1872" id="l1872">  1872</a>     |   compound_statement
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1873" id="l1873">  1873</a>     |   function_try_block[false]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1874" id="l1874">  1874</a>     )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1875" id="l1875">  1875</a>     //	|	// Next line is equivalent to guarded predicate in PCCTS
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1876" id="l1876">  1876</a>     //		// (SCOPE | literal_ident)? =&gt; &lt;&lt;qualifiedItemIsOneOf(qiPtrMember)&gt;&gt;?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1877" id="l1877">  1877</a>     //		//{( !(LA(1)==SCOPE||LA(1)==literal_ident) || (qualifiedItemIsOneOf(qiPtrMember)) )}?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1878" id="l1878">  1878</a>     //		function_declarator[true]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1879" id="l1879">  1879</a>     //		(	options{warnWhenFollowAmbig = false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1880" id="l1880">  1880</a>     //			(declaration)*	// Possible for K &amp; R definition
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1881" id="l1881">  1881</a>     //			{in_parameter_list = false;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1882" id="l1882">  1882</a>     //		)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1883" id="l1883">  1883</a>     //                compound_statement
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1884" id="l1884">  1884</a>     //	)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1885" id="l1885">  1885</a>     //	//{endFunctionDefinition();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1886" id="l1886">  1886</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1887" id="l1887">  1887</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1888" id="l1888">  1888</a> // rule for predicting &quot;declaration&quot;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1889" id="l1889">  1889</a> // must be updated together with declaration rule
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1890" id="l1890">  1890</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1891" id="l1891">  1891</a> is_declaration
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1892" id="l1892">  1892</a>         :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1893" id="l1893">  1893</a>         LITERAL_extern | LITERAL_using | (declaration_specifiers[true, false] declarator[declOther, 0])
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1894" id="l1894">  1894</a>         ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1895" id="l1895">  1895</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1896" id="l1896">  1896</a> declaration[int kind]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1897" id="l1897">  1897</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1898" id="l1898">  1898</a>         (LITERAL_extern STRING_LITERAL)=&gt; linkage_specification
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1899" id="l1899">  1899</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1900" id="l1900">  1900</a>         {kind == declExternFunction}? (LITERAL_extern) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1901" id="l1901">  1901</a>         {beginDeclaration();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1902" id="l1902">  1902</a>         LITERAL_extern
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1903" id="l1903">  1903</a>         ((COMMA!)? init_declarator_list[kind])?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1904" id="l1904">  1904</a>         ( EOF! { reportError(new NoViableAltException(org.netbeans.modules.cnd.apt.utils.APTUtils.EOF_TOKEN, getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1905" id="l1905">  1905</a>         | SEMICOLON )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1906" id="l1906">  1906</a>         {endDeclaration();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1907" id="l1907">  1907</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1908" id="l1908">  1908</a>         {kind == declSimpleFunction}? (literal_ident LPAREN) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1909" id="l1909">  1909</a>         {beginDeclaration();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1910" id="l1910">  1910</a>         init_declarator_list[kind]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1911" id="l1911">  1911</a>         ( EOF! { reportError(new NoViableAltException(org.netbeans.modules.cnd.apt.utils.APTUtils.EOF_TOKEN, getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1912" id="l1912">  1912</a>         | SEMICOLON )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1913" id="l1913">  1913</a>         {endDeclaration();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1914" id="l1914">  1914</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1915" id="l1915">  1915</a>         {beginDeclaration();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1916" id="l1916">  1916</a>         
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1917" id="l1917">  1917</a>         // LL 31/1/97: added (COMMA) ? below. This allows variables to
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1918" id="l1918">  1918</a>         // typedef'ed more than once. DW 18/08/03 ?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1919" id="l1919">  1919</a>         {action.decl_specifiers(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1920" id="l1920">  1920</a>         declaration_specifiers[true, false] 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1921" id="l1921">  1921</a>         {action.end_decl_specifiers(LT(0));}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1922" id="l1922">  1922</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1923" id="l1923">  1923</a>         ((COMMA!)? init_declarator_list[kind])?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1924" id="l1924">  1924</a>         ( EOF! { reportError(new NoViableAltException(org.netbeans.modules.cnd.apt.utils.APTUtils.EOF_TOKEN, getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1925" id="l1925">  1925</a>         | SEMICOLON )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1926" id="l1926">  1926</a>         //{end_of_stmt();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1927" id="l1927">  1927</a>         {endDeclaration();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1928" id="l1928">  1928</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1929" id="l1929">  1929</a>         (LITERAL_using literal_ident ASSIGNEQUAL) =&gt; alias_declaration
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1930" id="l1930">  1930</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1931" id="l1931">  1931</a> 	using_declaration	// DW 19/04/04
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1932" id="l1932">  1932</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1933" id="l1933">  1933</a>         namespace_alias_definition
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1934" id="l1934">  1934</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1935" id="l1935">  1935</a>         static_assert_declaration
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1936" id="l1936">  1936</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1937" id="l1937">  1937</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1938" id="l1938">  1938</a> linkage_specification
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1939" id="l1939">  1939</a> 	:	LITERAL_extern STRING_LITERAL
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1940" id="l1940">  1940</a> 		(	LCURLY (external_declaration)* RCURLY
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1941" id="l1941">  1941</a> 		|	external_declaration
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1942" id="l1942">  1942</a> 		)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1943" id="l1943">  1943</a> 		{ #linkage_specification = #(#[CSM_LINKAGE_SPECIFICATION,&quot;CSM_LINKAGE_SPECIFICATION&quot;], #linkage_specification);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1944" id="l1944">  1944</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1945" id="l1945">  1945</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1946" id="l1946">  1946</a> declaration_specifiers [boolean allowTypedef, boolean noTypeId]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1947" id="l1947">  1947</a> {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1948" id="l1948">  1948</a>     // Global flags to allow for nested declarations
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1949" id="l1949">  1949</a>     _td = false;        // For typedef
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1950" id="l1950">  1950</a>     _fd = false;        // For friend
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1951" id="l1951">  1951</a>     _sc = scInvalid;    // For StorageClass
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1952" id="l1952">  1952</a>     _tq = tqInvalid;    // For TypeQualifier
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1953" id="l1953">  1953</a>     _ts = tsInvalid;    // For TypeSpecifier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1954" id="l1954">  1954</a>     _ds = dsInvalid;    // For DeclSpecifier
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1955" id="l1955">  1955</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1956" id="l1956">  1956</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1957" id="l1957">  1957</a>     // Locals
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1958" id="l1958">  1958</a>     boolean td = false; // For typedef
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1959" id="l1959">  1959</a>     boolean fd = false; // For friend
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1960" id="l1960">  1960</a>     StorageClass sc = scInvalid;        // auto,register,static,extern,mutable
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1961" id="l1961">  1961</a>     TypeQualifier tq = tqInvalid;       // const,const_cast,volatile,cdecl
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1962" id="l1962">  1962</a>     /*TypeSpecifier*/int ts = tsInvalid;// char,int,double, etc., class,struct,union
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1963" id="l1963">  1963</a>     DeclSpecifier ds = dsInvalid;       // inline,virtual,explicit
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1964" id="l1964">  1964</a> }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1965" id="l1965">  1965</a> :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1966" id="l1966">  1966</a> (
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1967" id="l1967">  1967</a>     // fix for unknown specifiers
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1968" id="l1968">  1968</a>     unknown_pretype_declaration_specifiers
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1969" id="l1969">  1969</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1970" id="l1970">  1970</a>     ((LITERAL_static literal_ident (SEMICOLON | ASSIGNEQUAL | COMMA)) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1971" id="l1971">  1971</a>         sc = storage_class_specifier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1972" id="l1972">  1972</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1973" id="l1973">  1973</a>         (   ( (LITERAL_constexpr | cv_qualifier | LITERAL_static | literal_inline | LITERAL_friend)* 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1974" id="l1974">  1974</a>               LITERAL_auto 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1975" id="l1975">  1975</a>               (postfix_cv_qualifier | LITERAL_constexpr)? 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1976" id="l1976">  1976</a>               (literal_inline | storage_class_specifier | LITERAL_virtual)*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1977" id="l1977">  1977</a>               declarator[declOther, 0]) =&gt; 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1978" id="l1978">  1978</a>             (LITERAL_constexpr | tq = cv_qualifier | LITERAL_static | literal_inline | LITERAL_friend)*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1979" id="l1979">  1979</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1980" id="l1980">  1980</a>             (   options {warnWhenFollowAmbig = false;} : 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1981" id="l1981">  1981</a>                 {isCPlusPlus11()}? sc = cpp11_storage_class_specifier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1982" id="l1982">  1982</a>             |   {!isCPlusPlus11()}? sc = storage_class_specifier
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1983" id="l1983">  1983</a>             |   tq = cv_qualifier 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1984" id="l1984">  1984</a>             |   literal_inline {ds = dsINLINE;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1985" id="l1985">  1985</a>             |   LITERAL__Noreturn
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1986" id="l1986">  1986</a>             |   LITERAL_virtual {ds = dsVIRTUAL;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1987" id="l1987">  1987</a>             |   LITERAL_explicit {ds = dsEXPLICIT;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1988" id="l1988">  1988</a>             |   LITERAL_final
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1989" id="l1989">  1989</a> //              Here we could include enum and handle creating of enums on declaration level with predicates
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1990" id="l1990">  1990</a> //              This may be better because we will not accept enums in return types and parameters in such case
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1991" id="l1991">  1991</a> //          |   LITERAL_enum  
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1992" id="l1992">  1992</a>             |   {if (statementTrace&gt;=1) printf(&quot;declaration_specifiers_1[%d]: Typedef\n&quot;, LT(1).getLine());}                        
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1993" id="l1993">  1993</a>                 {allowTypedef}? LITERAL_typedef (options {greedy=true;} : LITERAL_typename)? {td=true;} 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1994" id="l1994">  1994</a>             |   LITERAL_typename
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1995" id="l1995">  1995</a>             |   LITERAL_friend {fd=true;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1996" id="l1996">  1996</a>             |   LITERAL_constexpr
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1997" id="l1997">  1997</a>             |   literal_stdcall
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1998" id="l1998">  1998</a>             |   literal_clrcall
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1999" id="l1999">  1999</a>             |   (options {greedy=true;} : type_attribute_specification!)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2000" id="l2000">  2000</a>             )*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2001" id="l2001">  2001</a>         ) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2002" id="l2002">  2002</a>         (
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2003" id="l2003">  2003</a>             (options {greedy=true;} :type_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2004" id="l2004">  2004</a>             ts = type_specifier[ds, noTypeId]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2005" id="l2005">  2005</a>             // support for &quot;A const*&quot;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2006" id="l2006">  2006</a>             // need to catch postfix_cv_qualifier
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2007" id="l2007">  2007</a>             (postfix_cv_qualifier | LITERAL_constexpr)? 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2008" id="l2008">  2008</a>             (
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2009" id="l2009">  2009</a>                 (literal_inline {ds = dsINLINE;})
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2010" id="l2010">  2010</a>             |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2011" id="l2011">  2011</a>                 (sc = storage_class_specifier)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2012" id="l2012">  2012</a>             | 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2013" id="l2013">  2013</a>                 LITERAL_virtual
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2014" id="l2014">  2014</a>             )*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2015" id="l2015">  2015</a>             (options {greedy=true;} :type_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2016" id="l2016">  2016</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2017" id="l2017">  2017</a>             // fix for unknown specifiers
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2018" id="l2018">  2018</a>             unknown_posttype_declaration_specifiers
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2019" id="l2019">  2019</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2020" id="l2020">  2020</a>     //  |   LITERAL_typename	{td=true;}	direct_declarator 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2021" id="l2021">  2021</a>         |   literal_typeof LPAREN typeof_param RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2022" id="l2022">  2022</a>         )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2023" id="l2023">  2023</a>     )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2024" id="l2024">  2024</a>     ({allowTypedef}? LITERAL_typedef {td=true;})?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2025" id="l2025">  2025</a> )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2026" id="l2026">  2026</a> {declarationSpecifier(td, fd, sc, tq, ts, ds);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2027" id="l2027">  2027</a> ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2028" id="l2028">  2028</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2029" id="l2029">  2029</a> unknown_pretype_declaration_specifiers
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2030" id="l2030">  2030</a>     {String s;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2031" id="l2031">  2031</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2032" id="l2032">  2032</a>     unknown_pretype_declaration_specifiers_list
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2033" id="l2033">  2033</a>     ((literal_ident 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2034" id="l2034">  2034</a>         (
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2035" id="l2035">  2035</a>             LITERAL_friend | LITERAL_typedef | LITERAL_virtual | LITERAL_explicit | LITERAL_final 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2036" id="l2036">  2036</a>         |   LITERAL_enum | LITERAL_typename | literal_stdcall | literal_clrcall
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2037" id="l2037">  2037</a>         |   (postfix_cv_qualifier | LITERAL_constexpr | literal_inline | storage_class_specifier)* literal_ident 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2038" id="l2038">  2038</a>             (postfix_cv_qualifier | LITERAL_constexpr | literal_inline | storage_class_specifier)* literal_ident
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2039" id="l2039">  2039</a>         )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2040" id="l2040">  2040</a>     ) =&gt; s=literal_ident!)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2041" id="l2041">  2041</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2042" id="l2042">  2042</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2043" id="l2043">  2043</a> unknown_pretype_declaration_specifiers_list
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2044" id="l2044">  2044</a>     {String s;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2045" id="l2045">  2045</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2046" id="l2046">  2046</a>     ((literal_ident literal_ident literal_ident) =&gt; s=literal_ident! unknown_pretype_declaration_specifiers_list)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2047" id="l2047">  2047</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2048" id="l2048">  2048</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2049" id="l2049">  2049</a> unknown_posttype_declaration_specifiers
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2050" id="l2050">  2050</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2051" id="l2051">  2051</a>     unknown_posttype_declaration_specifiers_list
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2052" id="l2052">  2052</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2053" id="l2053">  2053</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2054" id="l2054">  2054</a> unknown_posttype_declaration_specifiers_list 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2055" id="l2055">  2055</a>     {String s;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2056" id="l2056">  2056</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2057" id="l2057">  2057</a>     ((literal_ident literal_ident) =&gt; s=literal_ident! unknown_posttype_declaration_specifiers_list)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2058" id="l2058">  2058</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2059" id="l2059">  2059</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2060" id="l2060">  2060</a> decl_specifiers_before_type
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2061" id="l2061">  2061</a>     {StorageClass sc; TypeQualifier tq;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2062" id="l2062">  2062</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2063" id="l2063">  2063</a>         (
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2064" id="l2064">  2064</a>             sc = storage_class_specifier
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2065" id="l2065">  2065</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2066" id="l2066">  2066</a>             tq = cv_qualifier
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2067" id="l2067">  2067</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2068" id="l2068">  2068</a>             LITERAL_friend
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2069" id="l2069">  2069</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2070" id="l2070">  2070</a>             LITERAL_constexpr
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2071" id="l2071">  2071</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2072" id="l2072">  2072</a>             LITERAL_typedef
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2073" id="l2073">  2073</a>         )+
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2074" id="l2074">  2074</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2075" id="l2075">  2075</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2076" id="l2076">  2076</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2077" id="l2077">  2077</a> typeof_param :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2078" id="l2078">  2078</a>             // fast check of simple typeof (type) but skip typeof (type1() + type2()) which would be considered as expression
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2079" id="l2079">  2079</a>             (type_name {LA(1) != PLUS}?) =&gt; type_name
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2080" id="l2080">  2080</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2081" id="l2081">  2081</a>             expression
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2082" id="l2082">  2082</a>         ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2083" id="l2083">  2083</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2084" id="l2084">  2084</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2085" id="l2085">  2085</a> storage_class_specifier returns [CPPParser.StorageClass sc = scInvalid]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2086" id="l2086">  2086</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2087" id="l2087">  2087</a>         LITERAL_auto {sc = scAUTO;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2088" id="l2088">  2088</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2089" id="l2089">  2089</a>         sc = common_storage_class_specifier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2090" id="l2090">  2090</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2091" id="l2091">  2091</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2092" id="l2092">  2092</a> cpp11_storage_class_specifier returns [CPPParser.StorageClass sc = scInvalid]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2093" id="l2093">  2093</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2094" id="l2094">  2094</a>         sc = common_storage_class_specifier
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2095" id="l2095">  2095</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2096" id="l2096">  2096</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2097" id="l2097">  2097</a> common_storage_class_specifier returns [CPPParser.StorageClass sc = scInvalid]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2098" id="l2098">  2098</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2099" id="l2099">  2099</a>         LITERAL_register    {sc = scREGISTER;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2100" id="l2100">  2100</a>     |   LITERAL_static      {sc = scSTATIC;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2101" id="l2101">  2101</a>     |   LITERAL_extern      {sc = scEXTERN;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2102" id="l2102">  2102</a>     |   LITERAL_mutable     {sc = scMUTABLE;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2103" id="l2103">  2103</a>     |   LITERAL___thread    {sc = scTHREAD;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2104" id="l2104">  2104</a>     |   LITERAL__STORAGE_CLASS_SPECIFIER__ {sc = scOTHER;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2105" id="l2105">  2105</a>     |   LITERAL___symbolic {sc = scOTHER;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2106" id="l2106">  2106</a>     |   LITERAL___global {sc = scOTHER;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2107" id="l2107">  2107</a>     |   LITERAL___hidden {sc = scOTHER;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2108" id="l2108">  2108</a>     |   LITERAL_thread_local {sc = scOTHER;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2109" id="l2109">  2109</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2110" id="l2110">  2110</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2111" id="l2111">  2111</a> cv_qualifier returns [CPPParser.TypeQualifier tq = tqInvalid] // aka cv_qualifier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2112" id="l2112">  2112</a> 	:  (literal_const|LITERAL_const_cast)	{tq = tqCONST;} 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2113" id="l2113">  2113</a> 	|  literal_volatile			{tq = tqVOLATILE;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2114" id="l2114">  2114</a> 	|  LITERAL__TYPE_QUALIFIER__    {tq = tqOTHER;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2115" id="l2115">  2115</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2116" id="l2116">  2116</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2117" id="l2117">  2117</a> ref_qualifier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2118" id="l2118">  2118</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2119" id="l2119">  2119</a>         AMPERSAND | AND
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2120" id="l2120">  2120</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2121" id="l2121">  2121</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2122" id="l2122">  2122</a> type_specifier[DeclSpecifier ds, boolean noTypeId] returns [/*TypeSpecifier*/int ts = tsInvalid]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2123" id="l2123">  2123</a> :   ts = simple_type_specifier[noTypeId]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2124" id="l2124">  2124</a> |   ts = class_specifier[ds]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2125" id="l2125">  2125</a> |   enum_specifier {ts=tsENUM;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2126" id="l2126">  2126</a> |   LITERAL_auto {ts=tsAUTO;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2127" id="l2127">  2127</a>     { #type_specifier = #([CSM_TYPE_BUILTIN, &quot;CSM_TYPE_BUILTIN&quot;], #type_specifier); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2128" id="l2128">  2128</a> ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2129" id="l2129">  2129</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2130" id="l2130">  2130</a> simple_type_specifier[boolean noTypeId] returns [/*TypeSpecifier*/int ts = tsInvalid]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2131" id="l2131">  2131</a> 	:	(	{!noTypeId &amp;&amp; qualifiedItemIsOneOf(qiType|qiCtor)}? 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2132" id="l2132">  2132</a> 			qualified_type {ts=tsTYPEID;}	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2133" id="l2133">  2133</a> 			{ #simple_type_specifier = #([CSM_TYPE_COMPOUND, &quot;CSM_TYPE_COMPOUND&quot;], #simple_type_specifier); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2134" id="l2134">  2134</a> 		|	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2135" id="l2135">  2135</a>                         ts = builtin_cv_type_specifier[ts]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2136" id="l2136">  2136</a> 			{ #simple_type_specifier = #([CSM_TYPE_BUILTIN, &quot;CSM_TYPE_BUILTIN&quot;], #simple_type_specifier); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2137" id="l2137">  2137</a> 		|
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2138" id="l2138">  2138</a>                         {!noTypeId}?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2139" id="l2139">  2139</a> 			// Fix towards allowing us to parse *.cpp files directly
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2140" id="l2140">  2140</a> 			
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2141" id="l2141">  2141</a>                         // IZ 132404 : Parser failed on code taken from boost
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2142" id="l2142">  2142</a>                         //(qualified_type qualified_id)=&gt; qualified_type { ts=tsTYPEID; }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2143" id="l2143">  2143</a>                         (qualified_type) =&gt; qualified_type { ts=tsTYPEID; }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2144" id="l2144">  2144</a> 			
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2145" id="l2145">  2145</a>                         { #simple_type_specifier = #([CSM_TYPE_COMPOUND, &quot;CSM_TYPE_COMPOUND&quot;], #simple_type_specifier); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2146" id="l2146">  2146</a> 		)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2147" id="l2147">  2147</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2148" id="l2148">  2148</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2149" id="l2149">  2149</a> builtin_cv_type_specifier[/*TypeSpecifier*/int old_ts] returns [/*TypeSpecifier*/int ts = old_ts]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2150" id="l2150">  2150</a> {TypeQualifier tq;StorageClass sc;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2151" id="l2151">  2151</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2152" id="l2152">  2152</a>         (options{greedy = true;}: ts = builtin_type[ts])+
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2153" id="l2153">  2153</a>         ((cv_qualifier builtin_type[ts]) =&gt; 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2154" id="l2154">  2154</a>         tq = cv_qualifier ts = builtin_cv_type_specifier[ts])?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2155" id="l2155">  2155</a>         ((storage_class_specifier builtin_type[ts]) =&gt; 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2156" id="l2156">  2156</a>         sc = storage_class_specifier ts = builtin_cv_type_specifier[ts])?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2157" id="l2157">  2157</a>         ((LITERAL_virtual builtin_type[ts]) =&gt; 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2158" id="l2158">  2158</a>         LITERAL_virtual ts = builtin_cv_type_specifier[ts])?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2159" id="l2159">  2159</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2160" id="l2160">  2160</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2161" id="l2161">  2161</a> builtin_type[/*TypeSpecifier*/int old_ts] returns [/*TypeSpecifier*/int ts = old_ts]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2162" id="l2162">  2162</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2163" id="l2163">  2163</a> 	  LITERAL_char          {ts |= tsCHAR;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2164" id="l2164">  2164</a>         | LITERAL_wchar_t       {ts |= tsWCHAR_T;}  
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2165" id="l2165">  2165</a>         | LITERAL_char16_t      {ts |= tsOTHER;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2166" id="l2166">  2166</a>         | LITERAL_char32_t      {ts |= tsOTHER;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2167" id="l2167">  2167</a>         | LITERAL_bool          {ts |= tsBOOL;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2168" id="l2168">  2168</a>         | LITERAL__Bool         {ts |= tsBOOL;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2169" id="l2169">  2169</a>         | LITERAL_short         {ts |= tsSHORT;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2170" id="l2170">  2170</a>         | LITERAL_int           {ts |= tsINT;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2171" id="l2171">  2171</a>         | literal_int64         {ts |= tsLONG;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2172" id="l2172">  2172</a>         | LITERAL___w64         {ts |= tsLONG;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2173" id="l2173">  2173</a>         | LITERAL_long          {ts |= tsLONG;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2174" id="l2174">  2174</a>         | literal_signed        {ts |= tsSIGNED;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2175" id="l2175">  2175</a>         | literal_unsigned      {ts |= tsUNSIGNED;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2176" id="l2176">  2176</a>         | LITERAL_float         {ts |= tsFLOAT;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2177" id="l2177">  2177</a>         | LITERAL_double        {ts |= tsDOUBLE;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2178" id="l2178">  2178</a>         | LITERAL_void          {ts |= tsVOID;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2179" id="l2179">  2179</a>         | literal_complex       {ts |= tsCOMPLEX;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2180" id="l2180">  2180</a>         | LITERAL__Imaginary    {ts |= tsIMAGINARY;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2181" id="l2181">  2181</a>         | LITERAL_bit           {ts |= tsBOOL;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2182" id="l2182">  2182</a>         | LITERAL__BUILT_IN_TYPE__ {ts |= tsOTHER;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2183" id="l2183">  2183</a>         | LITERAL___builtin_va_list {ts |= tsOTHER;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2184" id="l2184">  2184</a> //        | literal_decltype LPAREN expression RPAREN {ts |= tsOTHER;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2185" id="l2185">  2185</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2186" id="l2186">  2186</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2187" id="l2187">  2187</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2188" id="l2188">  2188</a> qualified_type
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2189" id="l2189">  2189</a> 	{String s;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2190" id="l2190">  2190</a> 	: 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2191" id="l2191">  2191</a> 		// JEL 3/29/96 removed this predicate and moved it upwards to
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2192" id="l2192">  2192</a> 		// simple_type_specifier.  This was done to allow parsing of ~literal_ident to 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2193" id="l2193">  2193</a> 		// be a unary_expression, which was never reached with this 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2194" id="l2194">  2194</a> 		// predicate on
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2195" id="l2195">  2195</a> 		// {qualifiedItemIsOneOf(qiType|qiCtor)}?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2196" id="l2196">  2196</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2197" id="l2197">  2197</a> 		s = scope_override
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2198" id="l2198">  2198</a>         
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2199" id="l2199">  2199</a>         (s = literal_ident | type_decltype)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2200" id="l2200">  2200</a>         
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2201" id="l2201">  2201</a> //                {if(s.isEmpty()) {action.simple_type_id(id);} }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2202" id="l2202">  2202</a> //                {if(s.isEmpty()) {action.id(id);} }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2203" id="l2203">  2203</a> 		(options {warnWhenFollowAmbig = false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2204" id="l2204">  2204</a> 		 LESSTHAN template_argument_list GREATERTHAN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2205" id="l2205">  2205</a> 		)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2206" id="l2206">  2206</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2207" id="l2207">  2207</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2208" id="l2208">  2208</a> class_specifier[DeclSpecifier ds] returns [/*TypeSpecifier*/int ts = tsInvalid]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2209" id="l2209">  2209</a>     {String saveClass = &quot;&quot;; String id = &quot;&quot;; StorageClass sc = scInvalid;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2210" id="l2210">  2210</a>     :   
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2211" id="l2211">  2211</a>         {action.class_kind(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2212" id="l2212">  2212</a>         (   LITERAL_class  {ts = tsCLASS;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2213" id="l2213">  2213</a>         |   LITERAL_struct {ts = tsSTRUCT;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2214" id="l2214">  2214</a>         |   LITERAL_union  {ts = tsUNION;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2215" id="l2215">  2215</a>         )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2216" id="l2216">  2216</a>         (options {greedy=true;} : type_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2217" id="l2217">  2217</a>         (sc = storage_class_specifier!)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2218" id="l2218">  2218</a>         (   id = class_qualified_id
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2219" id="l2219">  2219</a>             (options{generateAmbigWarnings = false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2220" id="l2220">  2220</a>                 (LITERAL_final | LITERAL_explicit)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2221" id="l2221">  2221</a>                 (base_clause)?                
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2222" id="l2222">  2222</a>                 // parse class body if nesting limit not exceed
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2223" id="l2223">  2223</a>                 (
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2224" id="l2224">  2224</a>                     {checkClassDefinitionDepth(NESTED_CLASSES_LIMIT)}?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2225" id="l2225">  2225</a>                         {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2226" id="l2226">  2226</a>                             saveClass = enclosingClass;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2227" id="l2227">  2227</a>                             enclosingClass = id;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2228" id="l2228">  2228</a>                         }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2229" id="l2229">  2229</a>                         {action.class_body(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2230" id="l2230">  2230</a>                         LCURLY
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2231" id="l2231">  2231</a>                         // This stores class name in dictionary
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2232" id="l2232">  2232</a>                         {beginClassDefinition(ts, id);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2233" id="l2233">  2233</a>                         class_members
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2234" id="l2234">  2234</a>                         {endClassDefinition();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2235" id="l2235">  2235</a>                         {enclosingClass = saveClass;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2236" id="l2236">  2236</a>                         {action.end_class_body(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2237" id="l2237">  2237</a>                         {action.end_class_declaration(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2238" id="l2238">  2238</a>                         {action.end_simple_declaration(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2239" id="l2239">  2239</a>                         ( EOF! { reportError(new NoViableAltException(org.netbeans.modules.cnd.apt.utils.APTUtils.EOF_TOKEN, getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2240" id="l2240">  2240</a>                         | RCURLY )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2241" id="l2241">  2241</a>                     |   
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2242" id="l2242">  2242</a>                         balanceCurlies
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2243" id="l2243">  2243</a>                 )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2244" id="l2244">  2244</a>             |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2245" id="l2245">  2245</a>                 {classForwardDeclaration(ts, ds, id);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2246" id="l2246">  2246</a>             )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2247" id="l2247">  2247</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2248" id="l2248">  2248</a>             (   
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2249" id="l2249">  2249</a>                 {checkClassDefinitionDepth(NESTED_CLASSES_LIMIT)}?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2250" id="l2250">  2250</a>                     {action.class_body(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2251" id="l2251">  2251</a>                     LCURLY
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2252" id="l2252">  2252</a>                     {saveClass = enclosingClass; enclosingClass = (String ) &quot;__anonymous&quot;;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2253" id="l2253">  2253</a>                     {beginClassDefinition(ts, &quot;anonymous&quot;);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2254" id="l2254">  2254</a>                     (member_declaration)*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2255" id="l2255">  2255</a>                     {endClassDefinition();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2256" id="l2256">  2256</a>                     {action.end_class_body(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2257" id="l2257">  2257</a>                     {action.end_class_declaration(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2258" id="l2258">  2258</a>                     {action.end_simple_declaration(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2259" id="l2259">  2259</a>                     ( EOF! { reportError(new NoViableAltException(org.netbeans.modules.cnd.apt.utils.APTUtils.EOF_TOKEN, getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2260" id="l2260">  2260</a>                     | RCURLY )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2261" id="l2261">  2261</a>                     {enclosingClass = saveClass;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2262" id="l2262">  2262</a>                 |     
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2263" id="l2263">  2263</a>                     balanceCurlies
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2264" id="l2264">  2264</a>             )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2265" id="l2265">  2265</a>         )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2266" id="l2266">  2266</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2267" id="l2267">  2267</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2268" id="l2268">  2268</a> class_members
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2269" id="l2269">  2269</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2270" id="l2270">  2270</a>     (options{generateAmbigWarnings = false;greedy=false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2271" id="l2271">  2271</a>         member_declaration
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2272" id="l2272">  2272</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2273" id="l2273">  2273</a>         // IZ 136081 : Wrong parser recovering in class
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2274" id="l2274">  2274</a>         balanceCurlies { reportError(new NoViableAltException(LT(0), getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2275" id="l2275">  2275</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2276" id="l2276">  2276</a>         // IZ 138291 : Completion does not work for unfinished constructor
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2277" id="l2277">  2277</a>         // On unfinished construction we skip some symbols for class parsing process recovery
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2278" id="l2278">  2278</a>         (~(LCURLY))! { reportError(new NoViableAltException(LT(0), getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2279" id="l2279">  2279</a>     )*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2280" id="l2280">  2280</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2281" id="l2281">  2281</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2282" id="l2282">  2282</a> fix_fake_class_members
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2283" id="l2283">  2283</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2284" id="l2284">  2284</a>         class_members
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2285" id="l2285">  2285</a>         { #fix_fake_class_members = #(#[CSM_CLASS_DECLARATION, &quot;CSM_CLASS_DECLARATION&quot;], #fix_fake_class_members); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2286" id="l2286">  2286</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2287" id="l2287">  2287</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2288" id="l2288">  2288</a> fix_fake_enum_members
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2289" id="l2289">  2289</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2290" id="l2290">  2290</a>         enumerator_list
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2291" id="l2291">  2291</a>         { #fix_fake_enum_members = #(#[CSM_ENUM_DECLARATION, &quot;CSM_ENUM_DECLARATION&quot;], #fix_fake_enum_members); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2292" id="l2292">  2292</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2293" id="l2293">  2293</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2294" id="l2294">  2294</a> enum_specifier
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2295" id="l2295">  2295</a> {int ts = 0;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2296" id="l2296">  2296</a>  String qid;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2297" id="l2297">  2297</a> :   LITERAL_enum
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2298" id="l2298">  2298</a>     (options {greedy=true;} : type_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2299" id="l2299">  2299</a>     (
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2300" id="l2300">  2300</a>         (LITERAL_class | LITERAL_struct)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2301" id="l2301">  2301</a>         {action.enum_strongly_typed(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2302" id="l2302">  2302</a>     )?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2303" id="l2303">  2303</a>     (   (COLON ts = builtin_cv_type_specifier[ts])?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2304" id="l2304">  2304</a>         (type_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2305" id="l2305">  2305</a>         LCURLY enumerator_list 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2306" id="l2306">  2306</a>         ( EOF! { reportError(new NoViableAltException(org.netbeans.modules.cnd.apt.utils.APTUtils.EOF_TOKEN, getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2307" id="l2307">  2307</a>         | RCURLY )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2308" id="l2308">  2308</a>     |   
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2309" id="l2309">  2309</a>         qid = enum_qualified_id
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2310" id="l2310">  2310</a>         // elaborated_type_specifier        
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2311" id="l2311">  2311</a>         (   (options {greedy=true;} : 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2312" id="l2312">  2312</a>                 COLON ts = type_specifier[dsInvalid, false]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2313" id="l2313">  2313</a>             )?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2314" id="l2314">  2314</a>             (options {greedy=true;} :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2315" id="l2315">  2315</a>                 {action.enum_body(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2316" id="l2316">  2316</a>                         (type_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2317" id="l2317">  2317</a>                 LCURLY enumerator_list 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2318" id="l2318">  2318</a>                 {action.end_enum_body(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2319" id="l2319">  2319</a>                 ( EOF! { reportError(new NoViableAltException(org.netbeans.modules.cnd.apt.utils.APTUtils.EOF_TOKEN, getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2320" id="l2320">  2320</a>                 | RCURLY )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2321" id="l2321">  2321</a>             )?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2322" id="l2322">  2322</a>         )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2323" id="l2323">  2323</a>     {endEnumDefinition();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2324" id="l2324">  2324</a>     )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2325" id="l2325">  2325</a> ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2326" id="l2326">  2326</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2327" id="l2327">  2327</a> enum_qualified_id returns [String qid = &quot;&quot;]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2328" id="l2328">  2328</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2329" id="l2329">  2329</a>             (SCOPE literal_ident ) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2330" id="l2330">  2330</a>             qid = qualified_id
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2331" id="l2331">  2331</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2332" id="l2332">  2332</a>             (literal_ident (SCOPE | LESSTHAN) ) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2333" id="l2333">  2333</a>             qid = qualified_id
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2334" id="l2334">  2334</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2335" id="l2335">  2335</a>             qid = literal_ident     // DW 22/04/03 Suggest qualified_id here to satisfy
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2336" id="l2336">  2336</a> //            {qid = id.getText();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2337" id="l2337">  2337</a>             {#enum_qualified_id = #(#[CSM_QUALIFIED_ID, qid], #enum_qualified_id);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2338" id="l2338">  2338</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2339" id="l2339">  2339</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2340" id="l2340">  2340</a> enumerator_list
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2341" id="l2341">  2341</a>     :           
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2342" id="l2342">  2342</a>                 enumerator
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2343" id="l2343">  2343</a>                 ( options {greedy=true;} : (COMMA!) enumerator )*  
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2344" id="l2344">  2344</a>                 (COMMA!)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2345" id="l2345">  2345</a> 		{ #enumerator_list = #(#[CSM_ENUMERATOR_LIST, &quot;CSM_ENUMERATOR_LIST&quot;], #enumerator_list); }           
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2346" id="l2346">  2346</a>     | 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2347" id="l2347">  2347</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2348" id="l2348">  2348</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2349" id="l2349">  2349</a> enumerator
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2350" id="l2350">  2350</a>     {String id = &quot;&quot;;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2351" id="l2351">  2351</a> 	:	id = literal_ident (ASSIGNEQUAL constant_expression)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2352" id="l2352">  2352</a>         /*{action.enumerator(id);}*/
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2353" id="l2353">  2353</a> //		{enumElement(id.getText());}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2354" id="l2354">  2354</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2355" id="l2355">  2355</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2356" id="l2356">  2356</a> /* This matches a generic qualified identifier ::T::B::foo
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2357" id="l2357">  2357</a>  * (including LITERAL_OPERATOR).
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2358" id="l2358">  2358</a>  * It might be a good idea to put T::~dtor in here
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2359" id="l2359">  2359</a>  * as well, but id_expression in expr.g puts it in manually.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2360" id="l2360">  2360</a>  * Maybe not, 'cause many people use this assuming only A::B.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2361" id="l2361">  2361</a>  * How about a 'qualified_complex_id'?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2362" id="l2362">  2362</a>  */
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2363" id="l2363">  2363</a> qualified_id returns [String q = &quot;&quot;]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2364" id="l2364">  2364</a> 	{
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2365" id="l2365">  2365</a> 	    String so, id;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2366" id="l2366">  2366</a> 	    StringBuilder qitem = new StringBuilder();
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2367" id="l2367">  2367</a> 	}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2368" id="l2368">  2368</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2369" id="l2369">  2369</a>     (literal_cdecl)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2370" id="l2370">  2370</a> 	so = scope_override { qitem.append(so); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2371" id="l2371">  2371</a> 	(  
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2372" id="l2372">  2372</a> 		id = literal_ident	(options{warnWhenFollowAmbig = false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2373" id="l2373">  2373</a> 				 LESSTHAN template_argument_list GREATERTHAN)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2374" id="l2374">  2374</a>                 //{action.simple_template_id_or_ident(id);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2375" id="l2375">  2375</a>                 //{action.using_directive(action.USING_DIRECTIVE__IDENT, id);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2376" id="l2376">  2376</a> 		{qitem.append(id);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2377" id="l2377">  2377</a> 		|  
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2378" id="l2378">  2378</a> 		LITERAL_OPERATOR optor (options{warnWhenFollowAmbig = false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2379" id="l2379">  2379</a> 				 LESSTHAN template_argument_list GREATERTHAN)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2380" id="l2380">  2380</a> 		{qitem.append(&quot;operator&quot;); qitem.append(&quot;NYI&quot;);} // TODO: understand
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2381" id="l2381">  2381</a> 		|
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2382" id="l2382">  2382</a> 		LITERAL_OPERATOR STRING_LITERAL id=literal_ident (options{warnWhenFollowAmbig = false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2383" id="l2383">  2383</a> 				 LESSTHAN template_argument_list GREATERTHAN)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2384" id="l2384">  2384</a> 		{qitem.append(&quot;operator&quot;); qitem.append(&quot;NYI&quot;);} // TODO: understand
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2385" id="l2385">  2385</a> 		|
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2386" id="l2386">  2386</a> 		LITERAL_this  // DW 21/07/03 fix to pass test8.i
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2387" id="l2387">  2387</a> 		|
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2388" id="l2388">  2388</a> 		(LITERAL_true|LITERAL_false)	// DW 21/07/03 fix to pass test8.i
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2389" id="l2389">  2389</a> 	)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2390" id="l2390">  2390</a> 	{q = qitem.toString(); #qualified_id = #(#[CSM_QUALIFIED_ID, q], #qualified_id);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2391" id="l2391">  2391</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2392" id="l2392">  2392</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2393" id="l2393">  2393</a> unqualified_id returns [String q = &quot;&quot;]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2394" id="l2394">  2394</a> 	{
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2395" id="l2395">  2395</a> 	    String so, id;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2396" id="l2396">  2396</a> 	    StringBuilder qitem = new StringBuilder();
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2397" id="l2397">  2397</a> 	}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2398" id="l2398">  2398</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2399" id="l2399">  2399</a> 	so = scope_override {qitem.append(so);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2400" id="l2400">  2400</a> 	(  
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2401" id="l2401">  2401</a> 		id = literal_ident (options{warnWhenFollowAmbig = false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2402" id="l2402">  2402</a>                  LESSTHAN template_argument_list GREATERTHAN)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2403" id="l2403">  2403</a>         //{action.simple_template_id_or_ident(id);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2404" id="l2404">  2404</a> 		{qitem.append(id);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2405" id="l2405">  2405</a>     |  
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2406" id="l2406">  2406</a>         LITERAL_OPERATOR 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2407" id="l2407">  2407</a>         (
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2408" id="l2408">  2408</a>             (optor) =&gt; // predicate to avoid nondeterminism between optor and declaration_specifiers
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2409" id="l2409">  2409</a>                 optor (options{warnWhenFollowAmbig = false;}: 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2410" id="l2410">  2410</a>                         LESSTHAN template_argument_list GREATERTHAN)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2411" id="l2411">  2411</a>                 {qitem.append(&quot;operator&quot;); qitem.append(&quot;NYI&quot;);} // TODO: understand
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2412" id="l2412">  2412</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2413" id="l2413">  2413</a>             STRING_LITERAL id=literal_ident (options{warnWhenFollowAmbig = false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2414" id="l2414">  2414</a>                     LESSTHAN template_argument_list GREATERTHAN)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2415" id="l2415">  2415</a>             {qitem.append(&quot;operator&quot;); qitem.append(&quot;NYI&quot;);} // TODO: understand
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2416" id="l2416">  2416</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2417" id="l2417">  2417</a>             declaration_specifiers[false, false]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2418" id="l2418">  2418</a>             (ptr_operator)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2419" id="l2419">  2419</a>             (options{warnWhenFollowAmbig = false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2420" id="l2420">  2420</a>                 LESSTHAN template_parameter_list GREATERTHAN)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2421" id="l2421">  2421</a>             {qitem.append(&quot;operator&quot;); qitem.append(&quot;NYI&quot;);} // TODO: understand            
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2422" id="l2422">  2422</a>         )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2423" id="l2423">  2423</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2424" id="l2424">  2424</a> 		LITERAL_this  // DW 21/07/03 fix to pass test8.i
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2425" id="l2425">  2425</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2426" id="l2426">  2426</a> 		(LITERAL_true|LITERAL_false)	// DW 21/07/03 fix to pass test8.i
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2427" id="l2427">  2427</a> 	)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2428" id="l2428">  2428</a> 	{q = qitem.toString(); #unqualified_id = #(#[CSM_QUALIFIED_ID, q], #unqualified_id);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2429" id="l2429">  2429</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2430" id="l2430">  2430</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2431" id="l2431">  2431</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2432" id="l2432">  2432</a> class_qualified_id returns [String q = &quot;&quot;]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2433" id="l2433">  2433</a> {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2434" id="l2434">  2434</a>     String so;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2435" id="l2435">  2435</a>     String id;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2436" id="l2436">  2436</a>     StringBuilder qitem = new StringBuilder();
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2437" id="l2437">  2437</a> }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2438" id="l2438">  2438</a> :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2439" id="l2439">  2439</a>     so =  scope_override { qitem.append(so); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2440" id="l2440">  2440</a>     (  
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2441" id="l2441">  2441</a>             id = literal_ident
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2442" id="l2442">  2442</a> //        { if(so.isEmpty()) action.class_name(id);} }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2443" id="l2443">  2443</a>             (options{warnWhenFollowAmbig = false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2444" id="l2444">  2444</a>             LESSTHAN template_argument_list GREATERTHAN)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2445" id="l2445">  2445</a>             {qitem.append(id);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2446" id="l2446">  2446</a>         |  
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2447" id="l2447">  2447</a>             LITERAL_OPERATOR optor (options{warnWhenFollowAmbig = false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2448" id="l2448">  2448</a>             LESSTHAN template_argument_list GREATERTHAN)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2449" id="l2449">  2449</a>             {qitem.append(&quot;operator&quot;); qitem.append(&quot;NYI&quot;);} // TODO: understand
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2450" id="l2450">  2450</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2451" id="l2451">  2451</a>             LITERAL_this  // DW 21/07/03 fix to pass test8.i
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2452" id="l2452">  2452</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2453" id="l2453">  2453</a>             (LITERAL_true|LITERAL_false) // DW 21/07/03 fix to pass test8.i
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2454" id="l2454">  2454</a>     )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2455" id="l2455">  2455</a>     {q = qitem.toString(); #class_qualified_id = #(#[CSM_QUALIFIED_ID, q], #class_qualified_id);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2456" id="l2456">  2456</a> ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2457" id="l2457">  2457</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2458" id="l2458">  2458</a> typeID
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2459" id="l2459">  2459</a>     {String s;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2460" id="l2460">  2460</a> 	:	{isTypeName((LT(1).getText()))}?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2461" id="l2461">  2461</a> 		s=literal_ident
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2462" id="l2462">  2462</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2463" id="l2463">  2463</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2464" id="l2464">  2464</a> init_declarator_list[int kind]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2465" id="l2465">  2465</a> 	:	init_declarator[kind] (COMMA init_declarator[declNotFirst])*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2466" id="l2466">  2466</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2467" id="l2467">  2467</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2468" id="l2468">  2468</a> init_declarator[int kind]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2469" id="l2469">  2469</a> 	:	declarator[kind, 0]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2470" id="l2470">  2470</a> 		(	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2471" id="l2471">  2471</a> 			ASSIGNEQUAL 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2472" id="l2472">  2472</a>             (cast_array_initializer_head) =&gt; initializer
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2473" id="l2473">  2473</a>         |	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2474" id="l2474">  2474</a>             LPAREN (expression_list | array_initializer) RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2475" id="l2475">  2475</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2476" id="l2476">  2476</a>             array_initializer
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2477" id="l2477">  2477</a> 		)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2478" id="l2478">  2478</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2479" id="l2479">  2479</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2480" id="l2480">  2480</a> initializer
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2481" id="l2481">  2481</a>     {String s;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2482" id="l2482">  2482</a>     : 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2483" id="l2483">  2483</a>         ((LITERAL___extension__)? cast_array_initializer_head) =&gt; (LITERAL___extension__)? cast_array_initializer
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2484" id="l2484">  2484</a>     |   
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2485" id="l2485">  2485</a>         array_initializer
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2486" id="l2486">  2486</a>     | 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2487" id="l2487">  2487</a>         (
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2488" id="l2488">  2488</a>             // GCC designated initializer
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2489" id="l2489">  2489</a>             (literal_ident COLON)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2490" id="l2490">  2490</a>                 s=literal_ident 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2491" id="l2491">  2491</a>                 COLON 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2492" id="l2492">  2492</a>                 (options {greedy=true;} : initializer)? 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2493" id="l2493">  2493</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2494" id="l2494">  2494</a>             lazy_expression[false, false, 0] 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2495" id="l2495">  2495</a>             (options {greedy=true;}:	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2496" id="l2496">  2496</a>                 ( ASSIGNEQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2497" id="l2497">  2497</a>                 | TIMESEQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2498" id="l2498">  2498</a>                 | DIVIDEEQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2499" id="l2499">  2499</a>                 | MINUSEQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2500" id="l2500">  2500</a>                 | PLUSEQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2501" id="l2501">  2501</a>                 | MODEQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2502" id="l2502">  2502</a>                 | SHIFTLEFTEQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2503" id="l2503">  2503</a>                 | SHIFTRIGHTEQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2504" id="l2504">  2504</a>                 | BITWISEANDEQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2505" id="l2505">  2505</a>                 | BITWISEXOREQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2506" id="l2506">  2506</a>                 | BITWISEOREQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2507" id="l2507">  2507</a>                 )            
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2508" id="l2508">  2508</a>                 initializer
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2509" id="l2509">  2509</a>             )?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2510" id="l2510">  2510</a>         )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2511" id="l2511">  2511</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2512" id="l2512">  2512</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2513" id="l2513">  2513</a> cast_array_initializer:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2514" id="l2514">  2514</a>     // it's better to have LPAREN type RPAREN, but we use simple balanceParensInExpression
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2515" id="l2515">  2515</a>     (AMPERSAND)? (balanceParensInExpression)+ array_initializer
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2516" id="l2516">  2516</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2517" id="l2517">  2517</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2518" id="l2518">  2518</a> array_initializer:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2519" id="l2519">  2519</a>         LCURLY RCURLY
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2520" id="l2520">  2520</a>     |   
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2521" id="l2521">  2521</a>         LCURLY initializer (ELLIPSIS)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2522" id="l2522">  2522</a>         (
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2523" id="l2523">  2523</a>             // empty comma
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2524" id="l2524">  2524</a>             (COMMA (RCURLY|EOF)) =&gt; COMMA
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2525" id="l2525">  2525</a>             |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2526" id="l2526">  2526</a>             COMMA initializer (ELLIPSIS)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2527" id="l2527">  2527</a>         )*  
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2528" id="l2528">  2528</a>         ( EOF! { reportError(new NoViableAltException(org.netbeans.modules.cnd.apt.utils.APTUtils.EOF_TOKEN, getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2529" id="l2529">  2529</a>         | RCURLY )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2530" id="l2530">  2530</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2531" id="l2531">  2531</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2532" id="l2532">  2532</a> // only for predicates
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2533" id="l2533">  2533</a> cast_array_initializer_head
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2534" id="l2534">  2534</a> :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2535" id="l2535">  2535</a>     (AMPERSAND)? (balanceParensInExpression)* LCURLY
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2536" id="l2536">  2536</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2537" id="l2537">  2537</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2538" id="l2538">  2538</a> // so far this one is used in predicates only
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2539" id="l2539">  2539</a> class_head     
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2540" id="l2540">  2540</a>         { String s; StorageClass sc = scInvalid; }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2541" id="l2541">  2541</a> 	:	// Used only by predicates	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2542" id="l2542">  2542</a>     (   LITERAL_struct  
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2543" id="l2543">  2543</a>     |	LITERAL_union 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2544" id="l2544">  2544</a>     |	LITERAL_class)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2545" id="l2545">  2545</a>     (options {greedy=true;} : type_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2546" id="l2546">  2546</a>     (sc = storage_class_specifier)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2547" id="l2547">  2547</a> 	(
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2548" id="l2548">  2548</a>         s = scope_override  
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2549" id="l2549">  2549</a>         s = literal_ident	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2550" id="l2550">  2550</a>         (LESSTHAN template_argument_list GREATERTHAN)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2551" id="l2551">  2551</a>         (LITERAL_final | LITERAL_explicit)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2552" id="l2552">  2552</a>         (base_clause)? 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2553" id="l2553">  2553</a> 	)? LCURLY
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2554" id="l2554">  2554</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2555" id="l2555">  2555</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2556" id="l2556">  2556</a> // for predicates
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2557" id="l2557">  2557</a> enum_head
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2558" id="l2558">  2558</a>     { String s; int ts; }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2559" id="l2559">  2559</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2560" id="l2560">  2560</a>         LITERAL_enum 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2561" id="l2561">  2561</a>         (options {greedy=true;} : type_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2562" id="l2562">  2562</a>         (LITERAL_class | LITERAL_struct)? 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2563" id="l2563">  2563</a>         (s = enum_qualified_id)? 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2564" id="l2564">  2564</a>         (COLON ts = type_specifier[dsInvalid, false])?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2565" id="l2565">  2565</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2566" id="l2566">  2566</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2567" id="l2567">  2567</a> // for predicates
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2568" id="l2568">  2568</a> enum_def_head
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2569" id="l2569">  2569</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2570" id="l2570">  2570</a>         enum_head LCURLY
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2571" id="l2571">  2571</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2572" id="l2572">  2572</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2573" id="l2573">  2573</a> // for predicates
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2574" id="l2574">  2574</a> enum_fwd_head
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2575" id="l2575">  2575</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2576" id="l2576">  2576</a>         enum_head SEMICOLON        
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2577" id="l2577">  2577</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2578" id="l2578">  2578</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2579" id="l2579">  2579</a> // so far this one is used in predicates only
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2580" id="l2580">  2580</a> class_forward_declaration
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2581" id="l2581">  2581</a>         { String s; }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2582" id="l2582">  2582</a> 	:	// Used only by predicates
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2583" id="l2583">  2583</a> 	(   LITERAL_struct
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2584" id="l2584">  2584</a> 	|	LITERAL_union
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2585" id="l2585">  2585</a> 	|	LITERAL_class)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2586" id="l2586">  2586</a>     (options {greedy=true;} : type_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2587" id="l2587">  2587</a> 	(
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2588" id="l2588">  2588</a>         s = scope_override
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2589" id="l2589">  2589</a>         s = literal_ident
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2590" id="l2590">  2590</a> 		(LESSTHAN template_argument_list GREATERTHAN)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2591" id="l2591">  2591</a>         (LITERAL_final | LITERAL_explicit)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2592" id="l2592">  2592</a> 		(base_clause)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2593" id="l2593">  2593</a> 	)? SEMICOLON
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2594" id="l2594">  2594</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2595" id="l2595">  2595</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2596" id="l2596">  2596</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2597" id="l2597">  2597</a> typedef_class_fwd
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2598" id="l2598">  2598</a> { String id = &quot;&quot;, td = &quot;&quot;; }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2599" id="l2599">  2599</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2600" id="l2600">  2600</a>     LITERAL_typedef
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2601" id="l2601">  2601</a> 	(
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2602" id="l2602">  2602</a> 		LITERAL_struct
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2603" id="l2603">  2603</a> 	|	LITERAL_union
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2604" id="l2604">  2604</a> 	|	LITERAL_class
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2605" id="l2605">  2605</a> 	)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2606" id="l2606">  2606</a>     id = qualified_id
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2607" id="l2607">  2607</a>     td = qualified_id
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2608" id="l2608">  2608</a>     SEMICOLON
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2609" id="l2609">  2609</a> ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2610" id="l2610">  2610</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2611" id="l2611">  2611</a> base_clause
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2612" id="l2612">  2612</a> 	:	COLON base_specifier (ELLIPSIS)? (COMMA base_specifier (ELLIPSIS)? )*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2613" id="l2613">  2613</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2614" id="l2614">  2614</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2615" id="l2615">  2615</a> base_specifier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2616" id="l2616">  2616</a> 	:	// DW 13/08/03 Should check qualified_type for class-name?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2617" id="l2617">  2617</a> 	(	LITERAL_virtual (access_specifier)? qualified_type 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2618" id="l2618">  2618</a> 	|	access_specifier (LITERAL_virtual)? qualified_type
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2619" id="l2619">  2619</a> 	|	qualified_type
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2620" id="l2620">  2620</a> 	)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2621" id="l2621">  2621</a> 	{#base_specifier=#(#[CSM_BASE_SPECIFIER,&quot;CSM_BASE_SPECIFIER&quot;], #base_specifier);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2622" id="l2622">  2622</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2623" id="l2623">  2623</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2624" id="l2624">  2624</a> access_specifier
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2625" id="l2625">  2625</a> 	:	LITERAL_public
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2626" id="l2626">  2626</a> 	|	LITERAL_protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2627" id="l2627">  2627</a> 	|	LITERAL_private
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2628" id="l2628">  2628</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2629" id="l2629">  2629</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2630" id="l2630">  2630</a> member_declarator_list
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2631" id="l2631">  2631</a> 	:	member_declarator
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2632" id="l2632">  2632</a> 		(COMMA member_declarator)*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2633" id="l2633">  2633</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2634" id="l2634">  2634</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2635" id="l2635">  2635</a> member_declarator
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2636" id="l2636">  2636</a>     {String s;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2637" id="l2637">  2637</a> 	:	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2638" id="l2638">  2638</a> 		((literal_ident)? COLON constant_expression)=&gt;(s=literal_ident)? COLON constant_expression
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2639" id="l2639">  2639</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2640" id="l2640">  2640</a> 		init_declarator[declOther] 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2641" id="l2641">  2641</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2642" id="l2642">  2642</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2643" id="l2643">  2643</a> conversion_function_head
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2644" id="l2644">  2644</a>     {CPPParser.TypeQualifier tq; }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2645" id="l2645">  2645</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2646" id="l2646">  2646</a>         LITERAL_OPERATOR declaration_specifiers[true, false]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2647" id="l2647">  2647</a>         (ptr_operator)*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2648" id="l2648">  2648</a>         (LESSTHAN template_parameter_list GREATERTHAN)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2649" id="l2649">  2649</a>         LPAREN (parameter_list[false])? RPAREN	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2650" id="l2650">  2650</a>         (tq = cv_qualifier)*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2651" id="l2651">  2651</a>         (ref_qualifier)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2652" id="l2652">  2652</a>         (exception_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2653" id="l2653">  2653</a>         (virt_specifiers)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2654" id="l2654">  2654</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2655" id="l2655">  2655</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2656" id="l2656">  2656</a> conversion_function_decl 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2657" id="l2657">  2657</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2658" id="l2658">  2658</a>         conversion_function_head
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2659" id="l2659">  2659</a>         SEMICOLON!
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2660" id="l2660">  2660</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2661" id="l2661">  2661</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2662" id="l2662">  2662</a> conversion_function_decl_or_def returns [boolean definition = false]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2663" id="l2663">  2663</a> 	:	// DW 01/08/03 Use type_specifier here? see syntax
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2664" id="l2664">  2664</a> 		conversion_function_head
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2665" id="l2665">  2665</a> 		(	compound_statement { definition = true; }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2666" id="l2666">  2666</a>                     |	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2667" id="l2667">  2667</a>                         ((conversion_function_special_definition)=&gt; definition = conversion_function_special_definition)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2668" id="l2668">  2668</a>                         SEMICOLON! //{end_of_stmt();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2669" id="l2669">  2669</a> 		)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2670" id="l2670">  2670</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2671" id="l2671">  2671</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2672" id="l2672">  2672</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2673" id="l2673">  2673</a> conversion_function_special_definition returns [boolean definition = false]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2674" id="l2674">  2674</a>     :         
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2675" id="l2675">  2675</a>         ASSIGNEQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2676" id="l2676">  2676</a>         (
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2677" id="l2677">  2677</a>                OCTALINT
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2678" id="l2678">  2678</a>            |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2679" id="l2679">  2679</a>                LITERAL_delete { definition = true; }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2680" id="l2680">  2680</a>         )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2681" id="l2681">  2681</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2682" id="l2682">  2682</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2683" id="l2683">  2683</a> fun_cv_qualifier_seq
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2684" id="l2684">  2684</a>     {CPPParser.TypeQualifier tq;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2685" id="l2685">  2685</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2686" id="l2686">  2686</a>         // IZ#134182 : missed const in function parameter
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2687" id="l2687">  2687</a>         // we should add &quot;const&quot; to function only if it's not K&amp;R style function
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2688" id="l2688">  2688</a>         (   ((cv_qualifier)* 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2689" id="l2689">  2689</a>              (is_post_declarator_token | LITERAL_throw | LITERAL_noexcept | literal_attribute | POINTERTO | 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2690" id="l2690">  2690</a>               LITERAL_override | LITERAL_final | LITERAL_new | AMPERSAND | AND))
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2691" id="l2691">  2691</a>             =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2692" id="l2692">  2692</a>             (options{warnWhenFollowAmbig = false;}: tq = cv_qualifier)* 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2693" id="l2693">  2693</a>         )?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2694" id="l2694">  2694</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2695" id="l2695">  2695</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2696" id="l2696">  2696</a> // JEL note:  does not use (const|volatile)* to avoid lookahead problems
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2697" id="l2697">  2697</a> cv_qualifier_seq
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2698" id="l2698">  2698</a> 	{TypeQualifier tq;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2699" id="l2699">  2699</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2700" id="l2700">  2700</a> 	(options {warnWhenFollowAmbig = false;}:tq = cv_qualifier)*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2701" id="l2701">  2701</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2702" id="l2702">  2702</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2703" id="l2703">  2703</a> declarator[int kind, int level]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2704" id="l2704">  2704</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2705" id="l2705">  2705</a>         // Fix for IZ#136947: IDE highlights code with 'typedef' as wrong
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2706" id="l2706">  2706</a>         // This rule adds support for declarations like
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2707" id="l2707">  2707</a>         // void (__attribute__((noreturn)) ****f) (void);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2708" id="l2708">  2708</a>         {level &lt; 5}? (attribute_specification)=&gt; attribute_specification!
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2709" id="l2709">  2709</a>         declarator[kind, level + 1]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2710" id="l2710">  2710</a>     |   //{( !(LA(1)==SCOPE||LA(1)==literal_ident) || qualifiedItemIsOneOf(qiPtrMember) )}?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2711" id="l2711">  2711</a>         // VV: 23/05/06 added support for __restrict after pointers
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2712" id="l2712">  2712</a>         //i.e. void foo (char **__restrict a)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2713" id="l2713">  2713</a>         {level &lt; 5}? (ptr_operator)=&gt; ptr_operator // AMPERSAND or STAR
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2714" id="l2714">  2714</a>         restrict_declarator[kind, level + 1]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2715" id="l2715">  2715</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2716" id="l2716">  2716</a>         // typedef ((...));
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2717" id="l2717">  2717</a>         // int (i);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2718" id="l2718">  2718</a>         // or
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2719" id="l2719">  2719</a>         // type(var);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2720" id="l2720">  2720</a>         {level &lt; 5 &amp;&amp; (_td || (_ts != tsInvalid))}? (LPAREN declarator[kind, level + 1] RPAREN is_post_declarator_token) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2721" id="l2721">  2721</a>         LPAREN declarator[kind, level + 1] RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2722" id="l2722">  2722</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2723" id="l2723">  2723</a>         // type (var) = {...}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2724" id="l2724">  2724</a>         {level &lt; 5}? (LPAREN declarator[kind, level + 1] RPAREN ASSIGNEQUAL LCURLY) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2725" id="l2725">  2725</a>         LPAREN declarator[kind, level + 1] RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2726" id="l2726">  2726</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2727" id="l2727">  2727</a>         {level &lt; 5}? direct_declarator[kind, level + 1]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2728" id="l2728">  2728</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2729" id="l2729">  2729</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2730" id="l2730">  2730</a> restrict_declarator[int kind, int level]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2731" id="l2731">  2731</a> {CPPParser.TypeQualifier tq; }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2732" id="l2732">  2732</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2733" id="l2733">  2733</a>         // IZ 109079 : Parser reports &quot;unexpexted token&quot; on parenthesized pointer to array
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2734" id="l2734">  2734</a>         // IZ 140559 : parser fails on code from boost
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2735" id="l2735">  2735</a>         (LPAREN declarator[kind, level] RPAREN is_post_declarator_token) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2736" id="l2736">  2736</a>         LPAREN declarator[kind, level] RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2737" id="l2737">  2737</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2738" id="l2738">  2738</a>         // Fix for IZ#136947: IDE highlights code with 'typedef' as wrong
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2739" id="l2739">  2739</a>         // This rule adds support for declarations like
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2740" id="l2740">  2740</a>         // char *__attribute__((aligned(8))) *f;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2741" id="l2741">  2741</a>         (attribute_specification)=&gt; attribute_specification!
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2742" id="l2742">  2742</a>         restrict_declarator[kind, level]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2743" id="l2743">  2743</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2744" id="l2744">  2744</a>         //{( !(LA(1)==SCOPE||LA(1)==literal_ident) || qualifiedItemIsOneOf(qiPtrMember) )}?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2745" id="l2745">  2745</a>         (ptr_operator)=&gt; ptr_operator // AMPERSAND or STAR
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2746" id="l2746">  2746</a>         restrict_declarator[kind, level]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2747" id="l2747">  2747</a>     |   
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2748" id="l2748">  2748</a>         (literal_restrict! (tq = cv_qualifier)* )? direct_declarator[kind, level]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2749" id="l2749">  2749</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2750" id="l2750">  2750</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2751" id="l2751">  2751</a> direct_declarator[int kind, int level]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2752" id="l2752">  2752</a> {String id; TypeQualifier tq;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2753" id="l2753">  2753</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2754" id="l2754">  2754</a>         // Must be function declaration
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2755" id="l2755">  2755</a>         (function_like_var_declarator) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2756" id="l2756">  2756</a>         function_like_var_declarator
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2757" id="l2757">  2757</a>         {if(kind != declFunctionParam &amp;&amp; (kind == declStatement || kind == declNotFirst || LA(1) == COMMA)) {#direct_declarator = #(#[CSM_VARIABLE_LIKE_FUNCTION_DECLARATION, &quot;CSM_VARIABLE_LIKE_FUNCTION_DECLARATION&quot;], #direct_declarator);}}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2758" id="l2758">  2758</a>     |   
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2759" id="l2759">  2759</a>         ((ELLIPSIS)? qualified_id LPAREN ~LCURLY) =&gt; // Must be class instantiation
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2760" id="l2760">  2760</a>         (ELLIPSIS)? id = qualified_id
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2761" id="l2761">  2761</a>         {declaratorID(id, qiVar);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2762" id="l2762">  2762</a>         (variable_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2763" id="l2763">  2763</a>         LPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2764" id="l2764">  2764</a>         (expression_list)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2765" id="l2765">  2765</a>         RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2766" id="l2766">  2766</a>         {#direct_declarator = #(#[CSM_VARIABLE_DECLARATION, &quot;CSM_VARIABLE_DECLARATION&quot;], #direct_declarator);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2767" id="l2767">  2767</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2768" id="l2768">  2768</a>         (options {greedy=true;} : variable_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2769" id="l2769">  2769</a>         (
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2770" id="l2770">  2770</a>             ((ELLIPSIS)? qualified_id LSQUARE)=&gt;	// Must be array declaration
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2771" id="l2771">  2771</a>             (ELLIPSIS)? id = qualified_id 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2772" id="l2772">  2772</a>             {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2773" id="l2773">  2773</a>                  if (_td==true) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2774" id="l2774">  2774</a>                     declaratorID(id,qiType);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2775" id="l2775">  2775</a>                  } else {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2776" id="l2776">  2776</a>                     declaratorID(id,qiVar);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2777" id="l2777">  2777</a>                  }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2778" id="l2778">  2778</a>                  is_address = false; is_pointer = false;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2779" id="l2779">  2779</a>             }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2780" id="l2780">  2780</a>             (options {warnWhenFollowAmbig = false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2781" id="l2781">  2781</a>              LSQUARE (constant_expression)? RSQUARE)+
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2782" id="l2782">  2782</a>             {declaratorArray();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2783" id="l2783">  2783</a>             {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2784" id="l2784">  2784</a>                 if (_td==true) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2785" id="l2785">  2785</a>                     // todo: build tree in this case
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2786" id="l2786">  2786</a>                 } else  {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2787" id="l2787">  2787</a>                     #direct_declarator = #(#[CSM_ARRAY_DECLARATION, &quot;CSM_ARRAY_DECLARATION&quot;], #direct_declarator);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2788" id="l2788">  2788</a>                 }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2789" id="l2789">  2789</a>             }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2790" id="l2790">  2790</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2791" id="l2791">  2791</a>             (ELLIPSIS)? id = qualified_id
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2792" id="l2792">  2792</a>             {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2793" id="l2793">  2793</a>                  if (_td==true) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2794" id="l2794">  2794</a>                     // todo: build tree in this case
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2795" id="l2795">  2795</a>                     declaratorID(id,qiType);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2796" id="l2796">  2796</a>                  } else {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2797" id="l2797">  2797</a>                     #direct_declarator = #(#[CSM_VARIABLE_DECLARATION, &quot;CSM_VARIABLE_DECLARATION&quot;], #direct_declarator);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2798" id="l2798">  2798</a>                     declaratorID(id,qiVar);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2799" id="l2799">  2799</a>                  }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2800" id="l2800">  2800</a>                  is_address = false; is_pointer = false;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2801" id="l2801">  2801</a>             }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2802" id="l2802">  2802</a>         )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2803" id="l2803">  2803</a>         (options {greedy=true;} :variable_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2804" id="l2804">  2804</a>         (asm_block!)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2805" id="l2805">  2805</a>         (options {greedy=true;} :variable_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2806" id="l2806">  2806</a> 	|	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2807" id="l2807">  2807</a> 		// DW 24/05/04 This block probably never entered as dtor selected out earlier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2808" id="l2808">  2808</a> 		//	Note 1: In fact no dictionary entries for ctor or dtor	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2809" id="l2809">  2809</a> 		//	Note 2: 2: &quot;class&quot; not recorded in CPPSymbol
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2810" id="l2810">  2810</a> 		TILDE id = literal_ident {declaratorID(id,qiDtor);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2811" id="l2811">  2811</a> 		{
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2812" id="l2812">  2812</a>             if( reportOddWarnings ) printf(&quot;direct_declarator[%d]: Warning direct_declarator5 entered unexpectedly with %s\n&quot;, LT(1).getLine(),(id));
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2813" id="l2813">  2813</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2814" id="l2814">  2814</a> 		LPAREN //{declaratorParameterList(false);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2815" id="l2815">  2815</a> 		(parameter_list[false])?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2816" id="l2816">  2816</a> 		RPAREN //{declaratorEndParameterList(false);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2817" id="l2817">  2817</a> 	|	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2818" id="l2818">  2818</a> 		LPAREN declarator[kind, level+1] RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2819" id="l2819">  2819</a>                 (options {greedy=true;} :variable_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2820" id="l2820">  2820</a>                 (
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2821" id="l2821">  2821</a>                     {_ts != tsInvalid}?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2822" id="l2822">  2822</a>                         (options {greedy=true;} : declarator_suffixes)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2823" id="l2823">  2823</a>                 |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2824" id="l2824">  2824</a>                     declarator_suffixes
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2825" id="l2825">  2825</a>                 )   
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2826" id="l2826">  2826</a>                 (options {greedy=true;} :variable_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2827" id="l2827">  2827</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2828" id="l2828">  2828</a> /* **            
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2829" id="l2829">  2829</a>              // Issue #87792  Parser reports error on declarations with name in parenthesis.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2830" id="l2830">  2830</a>                 (  (LPAREN | LSQUARE)=&gt; (declarator_suffixes)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2831" id="l2831">  2831</a>                    | 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2832" id="l2832">  2832</a>                 ) 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2833" id="l2833">  2833</a> ** */
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2834" id="l2834">  2834</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2835" id="l2835">  2835</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2836" id="l2836">  2836</a> function_like_var_declarator
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2837" id="l2837">  2837</a> {String id; TypeQualifier tq;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2838" id="l2838">  2838</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2839" id="l2839">  2839</a>         // TODO: refactor the grammar and use function_declarator here
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2840" id="l2840">  2840</a>         (options {greedy=true;} :function_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2841" id="l2841">  2841</a>         id = idInBalanceParensHard
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2842" id="l2842">  2842</a>         {declaratorID(id, qiFun);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2843" id="l2843">  2843</a>         (variable_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2844" id="l2844">  2844</a>         LPAREN //{declaratorParameterList(false);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2845" id="l2845">  2845</a>         (parameter_list[false])?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2846" id="l2846">  2846</a>         RPAREN //{declaratorEndParameterList(false);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2847" id="l2847">  2847</a>         (options{greedy = true;} : cv_qualifier_seq)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2848" id="l2848">  2848</a>         (ref_qualifier)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2849" id="l2849">  2849</a>         (exception_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2850" id="l2850">  2850</a>         (trailing_type)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2851" id="l2851">  2851</a>         (options {greedy = true;} : virt_specifiers)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2852" id="l2852">  2852</a>         (options {greedy=true;} :function_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2853" id="l2853">  2853</a>         (asm_block!)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2854" id="l2854">  2854</a>         (options {greedy=true;} :function_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2855" id="l2855">  2855</a>         (options {greedy=true;} : LITERAL_override | LITERAL_final | LITERAL_new)*                
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2856" id="l2856">  2856</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2857" id="l2857">  2857</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2858" id="l2858">  2858</a> declarator_suffixes
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2859" id="l2859">  2859</a> 	{TypeQualifier tq;}  
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2860" id="l2860">  2860</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2861" id="l2861">  2861</a> 	(
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2862" id="l2862">  2862</a> 		(options {warnWhenFollowAmbig = false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2863" id="l2863">  2863</a> 		 LSQUARE (constant_expression)? RSQUARE)+
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2864" id="l2864">  2864</a> 		{declaratorArray();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2865" id="l2865">  2865</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2866" id="l2866">  2866</a>                 (LPAREN RPAREN) =&gt; declarator_param_list
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2867" id="l2867">  2867</a> 	|	{(!((LA(1)==LPAREN)&amp;&amp;(LA(2)==IDENT||LA(2)==LITERAL_final))||(qualifiedItemIsOneOf(qiType|qiCtor,1)))}?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2868" id="l2868">  2868</a> 		declarator_param_list
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2869" id="l2869">  2869</a> //	|	// DW 28/06/04 deleted Assume either following bracketed declaration
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2870" id="l2870">  2870</a> //		// empty
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2871" id="l2871">  2871</a> 	)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2872" id="l2872">  2872</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2873" id="l2873">  2873</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2874" id="l2874">  2874</a> /* I think something is weird with the context-guards for predicates;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2875" id="l2875">  2875</a>  * as a result I manually hoist the appropriate pred from ptr_to_member
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2876" id="l2876">  2876</a>  *
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2877" id="l2877">  2877</a>  * TER: warning: seems that &quot;literal_ident::&quot; will always bypass and go to 2nd alt :(
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2878" id="l2878">  2878</a>  */
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2879" id="l2879">  2879</a> function_declarator [boolean definition, boolean allowParens, boolean symTabCheck]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2880" id="l2880">  2880</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2881" id="l2881">  2881</a>         //{( !(LA(1)==SCOPE||LA(1)==literal_ident) || qualifiedItemIsOneOf(qiPtrMember) )}?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2882" id="l2882">  2882</a>         (ptr_operator)=&gt; ptr_operator function_declarator[definition, allowParens, symTabCheck]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2883" id="l2883">  2883</a>     |	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2884" id="l2884">  2884</a>         // int (i);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2885" id="l2885">  2885</a>         {_td || (_ts != tsInvalid) || allowParens}? (LPAREN function_declarator[definition, allowParens, symTabCheck] RPAREN is_post_declarator_token) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2886" id="l2886">  2886</a>         LPAREN function_declarator[definition, allowParens, symTabCheck] RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2887" id="l2887">  2887</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2888" id="l2888">  2888</a>         function_direct_declarator[definition, symTabCheck] 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2889" id="l2889">  2889</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2890" id="l2890">  2890</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2891" id="l2891">  2891</a> function_direct_declarator [boolean definition, boolean symTabCheck] 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2892" id="l2892">  2892</a> 	{String q;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2893" id="l2893">  2893</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2894" id="l2894">  2894</a>         (options {greedy=true;} : function_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2895" id="l2895">  2895</a>         (function_direct_declarator_2[definition, symTabCheck])
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2896" id="l2896">  2896</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2897" id="l2897">  2897</a>         fun_cv_qualifier_seq
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2898" id="l2898">  2898</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2899" id="l2899">  2899</a>         (options{greedy=true;} : ref_qualifier)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2900" id="l2900">  2900</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2901" id="l2901">  2901</a>         (exception_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2902" id="l2902">  2902</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2903" id="l2903">  2903</a>         (trailing_type)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2904" id="l2904">  2904</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2905" id="l2905">  2905</a>         (options {greedy = true;} : virt_specifiers)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2906" id="l2906">  2906</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2907" id="l2907">  2907</a>         //{functionEndParameterList(definition);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2908" id="l2908">  2908</a>         (( ASSIGNEQUAL ~(LITERAL_default | LITERAL_delete)) =&gt; ASSIGNEQUAL OCTALINT)?	// The value of the octal must be 0
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2909" id="l2909">  2909</a>         (options {greedy=true;} :function_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2910" id="l2910">  2910</a>         (options {greedy=true;} :asm_block!)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2911" id="l2911">  2911</a>         (options {greedy=true;} :function_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2912" id="l2912">  2912</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2913" id="l2913">  2913</a>  
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2914" id="l2914">  2914</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2915" id="l2915">  2915</a> is_post_declarator_token
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2916" id="l2916">  2916</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2917" id="l2917">  2917</a>         SEMICOLON | ASSIGNEQUAL | LCURLY | EOF | RPAREN | literal_try
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2918" id="l2918">  2918</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2919" id="l2919">  2919</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2920" id="l2920">  2920</a> trailing_type
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2921" id="l2921">  2921</a> {int ts = tsInvalid; TypeQualifier tq;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2922" id="l2922">  2922</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2923" id="l2923">  2923</a>         POINTERTO 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2924" id="l2924">  2924</a>         cv_qualifier_seq
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2925" id="l2925">  2925</a>         ts=trailing_type_specifier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2926" id="l2926">  2926</a>         cv_qualifier_seq
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2927" id="l2927">  2927</a>         (options {greedy=true;} : greedy_abstract_declarator)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2928" id="l2928">  2928</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2929" id="l2929">  2929</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2930" id="l2930">  2930</a> trailing_type_specifier returns [/*TypeSpecifier*/int ts = tsInvalid]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2931" id="l2931">  2931</a> {String id;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2932" id="l2932">  2932</a> :   
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2933" id="l2933">  2933</a>         ts = simple_type_specifier[false]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2934" id="l2934">  2934</a>     |   
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2935" id="l2935">  2935</a>         (LITERAL_class|LITERAL_struct|LITERAL_union|LITERAL_enum|LITERAL_typename)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2936" id="l2936">  2936</a>         id = qualified_id
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2937" id="l2937">  2937</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2938" id="l2938">  2938</a>         LITERAL_auto
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2939" id="l2939">  2939</a> ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2940" id="l2940">  2940</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2941" id="l2941">  2941</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2942" id="l2942">  2942</a> function_direct_declarator_2 [boolean definition, boolean symTabCheck] 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2943" id="l2943">  2943</a>     {String q; CPPParser.TypeQualifier tq;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2944" id="l2944">  2944</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2945" id="l2945">  2945</a>     /* predicate indicate that plain literal_ident is ok here; this counteracts any
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2946" id="l2946">  2946</a>      * other predicate that gets hoisted (along with this one) that
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2947" id="l2947">  2947</a>      * indicates that an literal_ident is a type or whatever.  E.g.,
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2948" id="l2948">  2948</a>      * another rule testing isTypeName() alone, implies that the
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2949" id="l2949">  2949</a>      * the literal_ident *MUST* be a type name.  Combining isTypeName() and
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2950" id="l2950">  2950</a>      * this predicate in an OR situation like this one:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2951" id="l2951">  2951</a>      * ( declaration_specifiers ... | function_declarator ... )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2952" id="l2952">  2952</a>      * would imply that literal_ident can be a type name OR a plain literal_ident.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2953" id="l2953">  2953</a>      */
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2954" id="l2954">  2954</a> /*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2955" id="l2955">  2955</a> 		(	// fix prompted by (isdigit)() in xlocnum
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2956" id="l2956">  2956</a> 			LPAREN q = qualified_id { declaratorID(q, qiFun); } RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2957" id="l2957">  2957</a> 		|
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2958" id="l2958">  2958</a> 			q = qualified_id { declaratorID(q, qiFun);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2959" id="l2959">  2959</a> 		)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2960" id="l2960">  2960</a> */
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2961" id="l2961">  2961</a>         q = idInBalanceParensHard { declaratorID(q, qiFun);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2962" id="l2962">  2962</a>         (function_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2963" id="l2963">  2963</a>         function_parameters[symTabCheck]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2964" id="l2964">  2964</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2965" id="l2965">  2965</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2966" id="l2966">  2966</a> function_parameters [boolean symTabCheck]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2967" id="l2967">  2967</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2968" id="l2968">  2968</a>     LPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2969" id="l2969">  2969</a>     (
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2970" id="l2970">  2970</a>         (LPAREN) =&gt; function_parameters[symTabCheck]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2971" id="l2971">  2971</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2972" id="l2972">  2972</a>         {   //functionParameterList();
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2973" id="l2973">  2973</a>             if (K_and_R == false) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2974" id="l2974">  2974</a>                 in_parameter_list = true;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2975" id="l2975">  2975</a>             }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2976" id="l2976">  2976</a>         }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2977" id="l2977">  2977</a>         (parameter_list[symTabCheck])?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2978" id="l2978">  2978</a>         {   if (K_and_R == false) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2979" id="l2979">  2979</a>                 in_parameter_list = false;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2980" id="l2980">  2980</a>             } else {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2981" id="l2981">  2981</a>                 in_parameter_list = true;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2982" id="l2982">  2982</a>             }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2983" id="l2983">  2983</a>         }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2984" id="l2984">  2984</a>     )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2985" id="l2985">  2985</a>     RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2986" id="l2986">  2986</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2987" id="l2987">  2987</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2988" id="l2988">  2988</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2989" id="l2989">  2989</a> function_params
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2990" id="l2990">  2990</a>         :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2991" id="l2991">  2991</a> 		LPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2992" id="l2992">  2992</a> 		{
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2993" id="l2993">  2993</a> 		    //functionParameterList();
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2994" id="l2994">  2994</a> 		    if (K_and_R == false) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2995" id="l2995">  2995</a> 			    in_parameter_list = true;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2996" id="l2996">  2996</a> 		    }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2997" id="l2997">  2997</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2998" id="l2998">  2998</a> 		(parameter_list[false])? 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l2999" id="l2999">  2999</a> 		{
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3000" id="l3000">  3000</a> 		    if (K_and_R == false) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3001" id="l3001">  3001</a> 	  		in_parameter_list = false;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3002" id="l3002">  3002</a> 		    } else {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3003" id="l3003">  3003</a> 			in_parameter_list = true;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3004" id="l3004">  3004</a> 		    }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3005" id="l3005">  3005</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3006" id="l3006">  3006</a> 		RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3007" id="l3007">  3007</a>         ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3008" id="l3008">  3008</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3009" id="l3009">  3009</a> ctor_definition 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3010" id="l3010">  3010</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3011" id="l3011">  3011</a>     ctor_head
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3012" id="l3012">  3012</a>     (   ctor_body
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3013" id="l3013">  3013</a>     |   ASSIGNEQUAL (LITERAL_default | LITERAL_delete)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3014" id="l3014">  3014</a>     )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3015" id="l3015">  3015</a>     //{endConstructorDefinition();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3016" id="l3016">  3016</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3017" id="l3017">  3017</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3018" id="l3018">  3018</a> ctor_head 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3019" id="l3019">  3019</a> {boolean friend = false; boolean ctorName = false;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3020" id="l3020">  3020</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3021" id="l3021">  3021</a> 	friend = ctor_decl_spec
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3022" id="l3022">  3022</a> 	ctorName = ctor_declarator[true]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3023" id="l3023">  3023</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3024" id="l3024">  3024</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3025" id="l3025">  3025</a> ctor_decl_spec returns [boolean friend = false]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3026" id="l3026">  3026</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3027" id="l3027">  3027</a>     ((options {greedy=true;} :function_attribute_specification)|literal_inline|LITERAL_explicit|LITERAL_friend {friend = true;} | LITERAL_constexpr )*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3028" id="l3028">  3028</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3029" id="l3029">  3029</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3030" id="l3030">  3030</a> ctor_declarator[boolean definition] returns [boolean isCtor = false]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3031" id="l3031">  3031</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3032" id="l3032">  3032</a>         (LPAREN ctor_declarator[definition] RPAREN is_post_declarator_token)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3033" id="l3033">  3033</a>             LPAREN isCtor = ctor_declarator[definition] RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3034" id="l3034">  3034</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3035" id="l3035">  3035</a>             isCtor = ctor_direct_declarator[definition]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3036" id="l3036">  3036</a>     ;   
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3037" id="l3037">  3037</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3038" id="l3038">  3038</a> ctor_direct_declarator[boolean definition] returns [boolean isCtor = false]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3039" id="l3039">  3039</a>     {String q;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3040" id="l3040">  3040</a>     : 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3041" id="l3041">  3041</a> 	// JEL 4/3/96 qualified_id too broad DW 10/06/03 ?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3042" id="l3042">  3042</a>         {isCtor = qualifiedItemIsOneOf(qiCtor);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3043" id="l3043">  3043</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3044" id="l3044">  3044</a> 	q = qualified_ctor_id
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3045" id="l3045">  3045</a>         // VV: 06/06/06 handle constructor of class template explicite specialization
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3046" id="l3046">  3046</a>         (LESSTHAN template_argument_list GREATERTHAN)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3047" id="l3047">  3047</a> 	//{declaratorParameterList(definition);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3048" id="l3048">  3048</a> 	LPAREN (parameter_list[false])? RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3049" id="l3049">  3049</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3050" id="l3050">  3050</a>         (options{greedy = true;} : cv_qualifier_seq)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3051" id="l3051">  3051</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3052" id="l3052">  3052</a>         (ref_qualifier)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3053" id="l3053">  3053</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3054" id="l3054">  3054</a>         (exception_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3055" id="l3055">  3055</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3056" id="l3056">  3056</a>         (options {greedy = true;} : virt_specifiers)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3057" id="l3057">  3057</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3058" id="l3058">  3058</a> 	//{declaratorEndParameterList(definition);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3059" id="l3059">  3059</a>         ((ASSIGNEQUAL OCTALINT) =&gt; ASSIGNEQUAL OCTALINT)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3060" id="l3060">  3060</a>         // IZ 136239 : C++ grammar does not allow attributes after constructor
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3061" id="l3061">  3061</a>         (function_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3062" id="l3062">  3062</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3063" id="l3063">  3063</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3064" id="l3064">  3064</a> qualified_ctor_id returns [String q = &quot;&quot;]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3065" id="l3065">  3065</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3066" id="l3066">  3066</a>         LPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3067" id="l3067">  3067</a>         q = qualified_ctor_id                 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3068" id="l3068">  3068</a>         RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3069" id="l3069">  3069</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3070" id="l3070">  3070</a>         q = qualified_ctor_direct_id
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3071" id="l3071">  3071</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3072" id="l3072">  3072</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3073" id="l3073">  3073</a> // This matches a generic qualified identifier ::T::B::foo
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3074" id="l3074">  3074</a> // that is satisfactory for a ctor (no operator, no trailing &lt;&gt;)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3075" id="l3075">  3075</a> qualified_ctor_direct_id returns [String q = &quot;&quot;]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3076" id="l3076">  3076</a> 	{
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3077" id="l3077">  3077</a> 	    String str;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3078" id="l3078">  3078</a> 	    StringBuilder  qitem = new StringBuilder();
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3079" id="l3079">  3079</a> 	}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3080" id="l3080">  3080</a> 	: 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3081" id="l3081">  3081</a> 	str = scope_override
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3082" id="l3082">  3082</a> 	{qitem.append(str);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3083" id="l3083">  3083</a> 	str = literal_ident	// DW 24/05/04 Note. Neither Ctor or Dtor recorded in dictionary
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3084" id="l3084">  3084</a> /* ****        
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3085" id="l3085">  3085</a> //       Issue 86695 &quot;Parser incorrect build CSM_QUALIFIED_ID branch for templated constructors&quot;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3086" id="l3086">  3086</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3087" id="l3087">  3087</a>         (options{warnWhenFollowAmbig = false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3088" id="l3088">  3088</a> 				 LESSTHAN template_argument_list GREATERTHAN)? 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3089" id="l3089">  3089</a> **** */
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3090" id="l3090">  3090</a> 	{qitem.append(str);        
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3091" id="l3091">  3091</a> 	 q = qitem.toString();
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3092" id="l3092">  3092</a> 	#qualified_ctor_direct_id = #(#[CSM_QUALIFIED_ID, q], #qualified_ctor_direct_id);} 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3093" id="l3093">  3093</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3094" id="l3094">  3094</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3095" id="l3095">  3095</a> ctor_body
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3096" id="l3096">  3096</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3097" id="l3097">  3097</a>     (  (ctor_initializer)? compound_statement
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3098" id="l3098">  3098</a>     |  function_try_block[true])
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3099" id="l3099">  3099</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3100" id="l3100">  3100</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3101" id="l3101">  3101</a> ctor_initializer
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3102" id="l3102">  3102</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3103" id="l3103">  3103</a> 	COLON! superclass_init (ELLIPSIS)? (COMMA! superclass_init (ELLIPSIS)? )*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3104" id="l3104">  3104</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3105" id="l3105">  3105</a>         {#ctor_initializer = #(#[CSM_CTOR_INITIALIZER_LIST, &quot;CSM_CTOR_INITIALIZER_LIST&quot;], #ctor_initializer);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3106" id="l3106">  3106</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3107" id="l3107">  3107</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3108" id="l3108">  3108</a> superclass_init
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3109" id="l3109">  3109</a> 	{String q;} 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3110" id="l3110">  3110</a> 	: 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3111" id="l3111">  3111</a> 	q = qualified_id 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3112" id="l3112">  3112</a>         (
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3113" id="l3113">  3113</a>             LPAREN! (expression_list | array_initializer)? RPAREN!
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3114" id="l3114">  3114</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3115" id="l3115">  3115</a>             array_initializer
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3116" id="l3116">  3116</a>         )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3117" id="l3117">  3117</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3118" id="l3118">  3118</a>         {#superclass_init = #(#[CSM_CTOR_INITIALIZER, &quot;CSM_CTOR_INITIALIZER&quot;], #superclass_init);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3119" id="l3119">  3119</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3120" id="l3120">  3120</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3121" id="l3121">  3121</a> dtor_definition
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3122" id="l3122">  3122</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3123" id="l3123">  3123</a> 	dtor_head[true]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3124" id="l3124">  3124</a> 	dtor_body
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3125" id="l3125">  3125</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3126" id="l3126">  3126</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3127" id="l3127">  3127</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3128" id="l3128">  3128</a> dtor_head[boolean definition] 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3129" id="l3129">  3129</a>     {boolean friend;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3130" id="l3130">  3130</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3131" id="l3131">  3131</a>         friend = dtor_decl_spec
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3132" id="l3132">  3132</a>         dtor_declarator[definition]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3133" id="l3133">  3133</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3134" id="l3134">  3134</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3135" id="l3135">  3135</a> dtor_decl_spec returns [boolean friend = false]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3136" id="l3136">  3136</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3137" id="l3137">  3137</a>         // TODO: think about flag if destructor is friend
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3138" id="l3138">  3138</a> 	((options {greedy=true;} :function_attribute_specification)|literal_inline|LITERAL_friend {friend = true;} |LITERAL_virtual)*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3139" id="l3139">  3139</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3140" id="l3140">  3140</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3141" id="l3141">  3141</a> /* ********
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3142" id="l3142">  3142</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3143" id="l3143">  3143</a> // Issue 86683 &quot;Parser incorrect build CSM_QUALIFIED_ID branch for destructors&quot;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3144" id="l3144">  3144</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3145" id="l3145">  3145</a> dtor_declarator[boolean definition]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3146" id="l3146">  3146</a> 	:	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3147" id="l3147">  3147</a> 	//({definition}? dtor_scope_override)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3148" id="l3148">  3148</a>         dtor_scope_override	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3149" id="l3149">  3149</a> 	//{declaratorParameterList(definition);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3150" id="l3150">  3150</a>         // VV: /06/06/06 ~dtor(void) is valid construction
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3151" id="l3151">  3151</a> 	LPAREN (LITERAL_void)? RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3152" id="l3152">  3152</a>         //{declaratorEndParameterList(definition);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3153" id="l3153">  3153</a>         (ASSIGNEQUAL OCTALINT)?	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3154" id="l3154">  3154</a> 	(exception_specification)?        
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3155" id="l3155">  3155</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3156" id="l3156">  3156</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3157" id="l3157">  3157</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3158" id="l3158">  3158</a> dtor_scope_override
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3159" id="l3159">  3159</a>         {String q; StringBuilder  qitem = new StringBuilder();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3160" id="l3160">  3160</a>         :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3161" id="l3161">  3161</a>         q = scope_override 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3162" id="l3162">  3162</a>         { qitem.append(q); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3163" id="l3163">  3163</a>         TILDE 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3164" id="l3164">  3164</a>         id:literal_ident
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3165" id="l3165">  3165</a>         (options{warnWhenFollowAmbig = false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3166" id="l3166">  3166</a> 				 LESSTHAN template_argument_list GREATERTHAN)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3167" id="l3167">  3167</a>         { qitem.append('~').append(id.getText()); 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3168" id="l3168">  3168</a>           q = qitem.toString();  
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3169" id="l3169">  3169</a>         }        
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3170" id="l3170">  3170</a>         { if( q.length() &gt; 0 ) #dtor_scope_override = #(#[CSM_QUALIFIED_ID, q], #dtor_scope_override); } 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3171" id="l3171">  3171</a>         ; 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3172" id="l3172">  3172</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3173" id="l3173">  3173</a> ****** */
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3174" id="l3174">  3174</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3175" id="l3175">  3175</a> dtor_declarator[boolean definition]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3176" id="l3176">  3176</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3177" id="l3177">  3177</a>         (LPAREN dtor_declarator[definition] RPAREN is_post_declarator_token)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3178" id="l3178">  3178</a>             LPAREN dtor_declarator[definition] RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3179" id="l3179">  3179</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3180" id="l3180">  3180</a>             dtor_direct_declarator[definition]        
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3181" id="l3181">  3181</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3182" id="l3182">  3182</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3183" id="l3183">  3183</a> dtor_direct_declarator[boolean definition]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3184" id="l3184">  3184</a> {String q;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3185" id="l3185">  3185</a> 	:	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3186" id="l3186">  3186</a> 	//({definition}? dtor_scope_override)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3187" id="l3187">  3187</a> //        dtor_scope_override
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3188" id="l3188">  3188</a> //	TILDE literal_ident
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3189" id="l3189">  3189</a>         q = qualified_dtor_id
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3190" id="l3190">  3190</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3191" id="l3191">  3191</a>        (LESSTHAN template_argument_list GREATERTHAN)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3192" id="l3192">  3192</a> 	//{declaratorParameterList(definition);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3193" id="l3193">  3193</a>         // VV: /06/06/06 ~dtor(void) is valid construction
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3194" id="l3194">  3194</a> 	LPAREN (LITERAL_void)? RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3195" id="l3195">  3195</a>         //{declaratorEndParameterList(definition);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3196" id="l3196">  3196</a>         (options{greedy = true;} : cv_qualifier_seq)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3197" id="l3197">  3197</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3198" id="l3198">  3198</a>         (ref_qualifier)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3199" id="l3199">  3199</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3200" id="l3200">  3200</a>         (exception_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3201" id="l3201">  3201</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3202" id="l3202">  3202</a>         (options {greedy = true;} : virt_specifiers)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3203" id="l3203">  3203</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3204" id="l3204">  3204</a>         ((ASSIGNEQUAL OCTALINT) =&gt; ASSIGNEQUAL OCTALINT)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3205" id="l3205">  3205</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3206" id="l3206">  3206</a>         (options {greedy=true;} :function_attribute_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3207" id="l3207">  3207</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3208" id="l3208">  3208</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3209" id="l3209">  3209</a> qualified_dtor_id returns [String q = &quot;&quot;]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3210" id="l3210">  3210</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3211" id="l3211">  3211</a>         LPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3212" id="l3212">  3212</a>         q = qualified_dtor_id                 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3213" id="l3213">  3213</a>         RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3214" id="l3214">  3214</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3215" id="l3215">  3215</a>         q = qualified_dtor_direct_id
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3216" id="l3216">  3216</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3217" id="l3217">  3217</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3218" id="l3218">  3218</a> // This matches a generic qualified identifier ::T::B::foo
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3219" id="l3219">  3219</a> // that is satisfactory for a ctor (no operator, no trailing &lt;&gt;)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3220" id="l3220">  3220</a> qualified_dtor_direct_id returns [String q = &quot;&quot;]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3221" id="l3221">  3221</a> 	{
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3222" id="l3222">  3222</a> 	    String str;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3223" id="l3223">  3223</a> 	    StringBuilder  qitem = new StringBuilder();
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3224" id="l3224">  3224</a> 	}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3225" id="l3225">  3225</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3226" id="l3226">  3226</a> 	str = scope_override
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3227" id="l3227">  3227</a> 	{qitem.append(str);}	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3228" id="l3228">  3228</a>     TILDE
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3229" id="l3229">  3229</a>     str = literal_ident
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3230" id="l3230">  3230</a>     {   
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3231" id="l3231">  3231</a>         qitem.append(&quot;~&quot;);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3232" id="l3232">  3232</a>         qitem.append(str);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3233" id="l3233">  3233</a>         q = qitem.toString();
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3234" id="l3234">  3234</a>         #qualified_dtor_direct_id = #(#[CSM_QUALIFIED_ID, q], #qualified_dtor_direct_id);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3235" id="l3235">  3235</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3236" id="l3236">  3236</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3237" id="l3237">  3237</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3238" id="l3238">  3238</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3239" id="l3239">  3239</a> //protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3240" id="l3240">  3240</a> //dtor_scope_override
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3241" id="l3241">  3241</a> //        {String q;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3242" id="l3242">  3242</a> //        :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3243" id="l3243">  3243</a> //        q = scope_override
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3244" id="l3244">  3244</a> //        { if( q.length() &gt; 0 ) #dtor_scope_override = #(#[CSM_QUALIFIED_ID, q], #dtor_scope_override); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3245" id="l3245">  3245</a> //        ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3246" id="l3246">  3246</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3247" id="l3247">  3247</a>       
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3248" id="l3248">  3248</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3249" id="l3249">  3249</a> dtor_body
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3250" id="l3250">  3250</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3251" id="l3251">  3251</a> 	compound_statement
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3252" id="l3252">  3252</a> 	//{endDestructorDefinition();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3253" id="l3253">  3253</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3254" id="l3254">  3254</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3255" id="l3255">  3255</a> parameter_list [boolean symTabCheck]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3256" id="l3256">  3256</a> 	:	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3257" id="l3257">  3257</a> 	parameter_declaration_list[symTabCheck] (ELLIPSIS)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3258" id="l3258">  3258</a> 	{ #parameter_list = #(#[CSM_PARMLIST, &quot;CSM_PARMLIST&quot;], #parameter_list); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3259" id="l3259">  3259</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3260" id="l3260">  3260</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3261" id="l3261">  3261</a> parameter_declaration_list [boolean symTabCheck]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3262" id="l3262">  3262</a> 	:	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3263" id="l3263">  3263</a> 	({!symTabCheck || action.isType(LT(1).getText())}?	parameter_declaration[false]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3264" id="l3264">  3264</a> 		(// Have not been able to find way of stopping warning of
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3265" id="l3265">  3265</a> 		 // non-determinism between alt 1 and exit branch of block
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3266" id="l3266">  3266</a> 		 COMMA! parameter_declaration[false]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3267" id="l3267">  3267</a> 		)*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3268" id="l3268">  3268</a> 	)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3269" id="l3269">  3269</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3270" id="l3270">  3270</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3271" id="l3271">  3271</a> parameter_declaration[boolean inTemplateParams]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3272" id="l3272">  3272</a> 	:	{beginParameterDeclaration();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3273" id="l3273">  3273</a> 		(
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3274" id="l3274">  3274</a> 			{!((LA(1)==SCOPE) &amp;&amp; (LA(2)==STAR||LA(2)==LITERAL_OPERATOR)) &amp;&amp;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3275" id="l3275">  3275</a> 			    (!(LA(1)==SCOPE||LA(1)==IDENT||LA(1)==LITERAL_final) ||
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3276" id="l3276">  3276</a> 			    qualifiedItemIsOneOf(qiType|qiCtor) )}?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3277" id="l3277">  3277</a> 			declaration_specifiers[true, false]	// DW 24/3/98 Mods for K &amp; R
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3278" id="l3278">  3278</a> 			(  
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3279" id="l3279">  3279</a> 				(declarator[declFunctionParam, 0])=&gt; declarator[declFunctionParam, 0]        // if arg name given
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3280" id="l3280">  3280</a> 			| 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3281" id="l3281">  3281</a> 				abstract_declarator  // if arg name not given  // can be empty
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3282" id="l3282">  3282</a> 			)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3283" id="l3283">  3283</a> 		|
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3284" id="l3284">  3284</a> 			(declarator[declOther, 0])=&gt; declarator[declOther, 0]	// DW 24/3/98 Mods for K &amp; R
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3285" id="l3285">  3285</a> 		|
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3286" id="l3286">  3286</a> 			ELLIPSIS
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3287" id="l3287">  3287</a> 		)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3288" id="l3288">  3288</a> 		(ASSIGNEQUAL 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3289" id="l3289">  3289</a>                     (   
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3290" id="l3290">  3290</a>                         {inTemplateParams}? template_param_expression
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3291" id="l3291">  3291</a>                     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3292" id="l3292">  3292</a>                         array_initializer // c++11 extended initilizer list
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3293" id="l3293">  3293</a>                     |	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3294" id="l3294">  3294</a>                         assignment_expression
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3295" id="l3295">  3295</a>                     )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3296" id="l3296">  3296</a> 		)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3297" id="l3297">  3297</a> 		{ #parameter_declaration = #(#[CSM_PARAMETER_DECLARATION, &quot;CSM_PARAMETER_DECLARATION&quot;], #parameter_declaration); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3298" id="l3298">  3298</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3299" id="l3299">  3299</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3300" id="l3300">  3300</a> simple_parameter_list
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3301" id="l3301">  3301</a>     :	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3302" id="l3302">  3302</a>     simple_parameter_declaration
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3303" id="l3303">  3303</a>     (COMMA! simple_parameter_declaration)*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3304" id="l3304">  3304</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3305" id="l3305">  3305</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3306" id="l3306">  3306</a> simple_parameter_declaration
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3307" id="l3307">  3307</a>     {String s;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3308" id="l3308">  3308</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3309" id="l3309">  3309</a>     declaration_specifiers[false, true]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3310" id="l3310">  3310</a>     (s=literal_ident)*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3311" id="l3311">  3311</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3312" id="l3312">  3312</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3313" id="l3313">  3313</a> type_name // aka type_id
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3314" id="l3314">  3314</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3315" id="l3315">  3315</a> 	declaration_specifiers[true, false] 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3316" id="l3316">  3316</a>         abstract_declarator
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3317" id="l3317">  3317</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3318" id="l3318">  3318</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3319" id="l3319">  3319</a> /* This rule looks a bit weird because (...) can happen in two
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3320" id="l3320">  3320</a>  * places within the declaration such as &quot;void (*)()&quot; (ptr to
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3321" id="l3321">  3321</a>  * function returning nothing).  However, the () of a function
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3322" id="l3322">  3322</a>  * can only occur after having seen either a (abstract_declarator)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3323" id="l3323">  3323</a>  * and not after a [..] or simple '*'.  These are the only two
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3324" id="l3324">  3324</a>  * valid () func-groups:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3325" id="l3325">  3325</a>  *    int (*)();     // ptr to func
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3326" id="l3326">  3326</a>  *    int (*[])();   // array of ptr to func
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3327" id="l3327">  3327</a>  */
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3328" id="l3328">  3328</a> abstract_declarator
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3329" id="l3329">  3329</a>     :	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3330" id="l3330">  3330</a>         ptr_operator (literal_restrict!)? abstract_declarator 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3331" id="l3331">  3331</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3332" id="l3332">  3332</a>         (abstract_declarator_suffix)+
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3333" id="l3333">  3333</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3334" id="l3334">  3334</a>         (ELLIPSIS) =&gt; ELLIPSIS
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3335" id="l3335">  3335</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3336" id="l3336">  3336</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3337" id="l3337">  3337</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3338" id="l3338">  3338</a> /**
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3339" id="l3339">  3339</a>  * This rule could be used when nothing goes after it (i.e. parent rule is not anchored).
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3340" id="l3340">  3340</a>  * NOTE: it doesn't handle top-level empty alternative
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3341" id="l3341">  3341</a>  */
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3342" id="l3342">  3342</a> greedy_abstract_declarator
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3343" id="l3343">  3343</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3344" id="l3344">  3344</a>         ptr_operator (literal_restrict!)? (options{greedy = true;} : greedy_abstract_declarator)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3345" id="l3345">  3345</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3346" id="l3346">  3346</a>         (options{greedy = true;} : abstract_declarator_suffix)+
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3347" id="l3347">  3347</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3348" id="l3348">  3348</a>         (ELLIPSIS) =&gt; ELLIPSIS
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3349" id="l3349">  3349</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3350" id="l3350">  3350</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3351" id="l3351">  3351</a> abstract_declarator_suffix
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3352" id="l3352">  3352</a> 	:	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3353" id="l3353">  3353</a>             LSQUARE (constant_expression)? RSQUARE
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3354" id="l3354">  3354</a>             {declaratorArray();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3355" id="l3355">  3355</a>         |   
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3356" id="l3356">  3356</a>             (LPAREN RPAREN) =&gt; declarator_param_list
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3357" id="l3357">  3357</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3358" id="l3358">  3358</a>             (LPAREN abstract_declarator RPAREN) =&gt; LPAREN abstract_declarator RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3359" id="l3359">  3359</a> 	|
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3360" id="l3360">  3360</a>             declarator_param_list
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3361" id="l3361">  3361</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3362" id="l3362">  3362</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3363" id="l3363">  3363</a> declarator_param_list
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3364" id="l3364">  3364</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3365" id="l3365">  3365</a>         LPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3366" id="l3366">  3366</a>         //{declaratorParameterList(false);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3367" id="l3367">  3367</a>         (parameter_list[false])?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3368" id="l3368">  3368</a>         RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3369" id="l3369">  3369</a>         cv_qualifier_seq
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3370" id="l3370">  3370</a>         (options{greedy = true;} : ref_qualifier)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3371" id="l3371">  3371</a>         //{declaratorEndParameterList(false);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3372" id="l3372">  3372</a>         (exception_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3373" id="l3373">  3373</a>         (options{greedy = true;} : trailing_type)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3374" id="l3374">  3374</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3375" id="l3375">  3375</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3376" id="l3376">  3376</a> exception_specification
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3377" id="l3377">  3377</a>     {String so;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3378" id="l3378">  3378</a>     :   LITERAL_throw 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3379" id="l3379">  3379</a>         LPAREN 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3380" id="l3380">  3380</a>         (exception_type_id (COMMA exception_type_id)* )? 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3381" id="l3381">  3381</a>         RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3382" id="l3382">  3382</a>     |   
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3383" id="l3383">  3383</a>         LITERAL_noexcept (options {greedy=true;} : LPAREN constant_expression RPAREN )?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3384" id="l3384">  3384</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3385" id="l3385">  3385</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3386" id="l3386">  3386</a> protected 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3387" id="l3387">  3387</a> virt_specifiers
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3388" id="l3388">  3388</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3389" id="l3389">  3389</a>         (LITERAL_override | LITERAL_final) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3390" id="l3390">  3390</a>         (options {greedy=true;} : LITERAL_override | LITERAL_final)*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3391" id="l3391">  3391</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3392" id="l3392">  3392</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3393" id="l3393">  3393</a> // simplified version of type_id that is used in exception specification
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3394" id="l3394">  3394</a> protected 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3395" id="l3395">  3395</a> exception_type_id
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3396" id="l3396">  3396</a> 	{ /*TypeSpecifier*/int ts; String so; }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3397" id="l3397">  3397</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3398" id="l3398">  3398</a> 	//( (so = scope_override literal_ident) | built_in_type ) (STAR | AMPERSAND)*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3399" id="l3399">  3399</a>         parameter_declaration[false]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3400" id="l3400">  3400</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3401" id="l3401">  3401</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3402" id="l3402">  3402</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3403" id="l3403">  3403</a> function_attribute_specification! 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3404" id="l3404">  3404</a>         : 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3405" id="l3405">  3405</a>             attribute_specification_list
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3406" id="l3406">  3406</a>         ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3407" id="l3407">  3407</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3408" id="l3408">  3408</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3409" id="l3409">  3409</a> variable_attribute_specification!
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3410" id="l3410">  3410</a>         :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3411" id="l3411">  3411</a>             attribute_specification_list
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3412" id="l3412">  3412</a>         ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3413" id="l3413">  3413</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3414" id="l3414">  3414</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3415" id="l3415">  3415</a> declspec!
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3416" id="l3416">  3416</a>         : 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3417" id="l3417">  3417</a>             literal_declspec balanceParens
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3418" id="l3418">  3418</a>         ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3419" id="l3419">  3419</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3420" id="l3420">  3420</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3421" id="l3421">  3421</a> type_attribute_specification!
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3422" id="l3422">  3422</a>         :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3423" id="l3423">  3423</a>             attribute_specification_list | declspec | LITERAL_alignas balanceParens
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3424" id="l3424">  3424</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3425" id="l3425">  3425</a>         ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3426" id="l3426">  3426</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3427" id="l3427">  3427</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3428" id="l3428">  3428</a> namespace_attribute_specification!
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3429" id="l3429">  3429</a>         :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3430" id="l3430">  3430</a>             attribute_specification_list
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3431" id="l3431">  3431</a>         ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3432" id="l3432">  3432</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3433" id="l3433">  3433</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3434" id="l3434">  3434</a> attribute_specification_list
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3435" id="l3435">  3435</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3436" id="l3436">  3436</a> 	    attribute_specification (options {greedy=true;} : attribute_specification_list)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3437" id="l3437">  3437</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3438" id="l3438">  3438</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3439" id="l3439">  3439</a> attribute_specification
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3440" id="l3440">  3440</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3441" id="l3441">  3441</a>         literal_attribute
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3442" id="l3442">  3442</a>         LPAREN balanceParens RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3443" id="l3443">  3443</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3444" id="l3444">  3444</a>         ({isCPlusPlus11()}? LSQUARE balanceSquares RSQUARE)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3445" id="l3445">  3445</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3446" id="l3446">  3446</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3447" id="l3447">  3447</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3448" id="l3448">  3448</a> balanceParens
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3449" id="l3449">  3449</a>         : 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3450" id="l3450">  3450</a>             LPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3451" id="l3451">  3451</a>             (options {greedy=false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3452" id="l3452">  3452</a>                 balanceParens | .
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3453" id="l3453">  3453</a>             )*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3454" id="l3454">  3454</a>             RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3455" id="l3455">  3455</a>         ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3456" id="l3456">  3456</a>  
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3457" id="l3457">  3457</a> protected    
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3458" id="l3458">  3458</a> balanceCurlies
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3459" id="l3459">  3459</a>         :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3460" id="l3460">  3460</a>             LCURLY
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3461" id="l3461">  3461</a>             // balanceBraces will consume all tokens till the first unbalanced RCURLY
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3462" id="l3462">  3462</a>             ({balanceBraces(CPPTokenTypes.LCURLY, CPPTokenTypes.RCURLY)}?) 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3463" id="l3463">  3463</a>             // consume last RCURLY
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3464" id="l3464">  3464</a>             (options {greedy=true;} : . )? 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3465" id="l3465">  3465</a>         ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3466" id="l3466">  3466</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3467" id="l3467">  3467</a> protected    
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3468" id="l3468">  3468</a> balanceSquares
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3469" id="l3469">  3469</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3470" id="l3470">  3470</a>         LSQUARE 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3471" id="l3471">  3471</a>             (options {greedy=false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3472" id="l3472">  3472</a>                 balanceSquares | .
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3473" id="l3473">  3473</a>             )*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3474" id="l3474">  3474</a>         RSQUARE
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3475" id="l3475">  3475</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3476" id="l3476">  3476</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3477" id="l3477">  3477</a> protected    
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3478" id="l3478">  3478</a> balanceLessthanGreaterthan
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3479" id="l3479">  3479</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3480" id="l3480">  3480</a>         LESSTHAN 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3481" id="l3481">  3481</a>             (options {greedy=false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3482" id="l3482">  3482</a>                 .
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3483" id="l3483">  3483</a>             )*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3484" id="l3484">  3484</a>         GREATERTHAN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3485" id="l3485">  3485</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3486" id="l3486">  3486</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3487" id="l3487">  3487</a> // Removed due to restrictions of clone antlr optimization
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3488" id="l3488">  3488</a> /*protected 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3489" id="l3489">  3489</a> idInBalanceParensLight returns [String id = &quot;&quot;]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3490" id="l3490">  3490</a>         { int count = 0; }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3491" id="l3491">  3491</a>         :               
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3492" id="l3492">  3492</a>             (   LPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3493" id="l3493">  3493</a>                 { count++; }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3494" id="l3494">  3494</a>             )*          
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3495" id="l3495">  3495</a>             id = qualified_id
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3496" id="l3496">  3496</a>             (    RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3497" id="l3497">  3497</a>                 { count--; }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3498" id="l3498">  3498</a>             )*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3499" id="l3499">  3499</a>            {count == 0}?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3500" id="l3500">  3500</a>        ;     */
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3501" id="l3501">  3501</a>  
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3502" id="l3502">  3502</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3503" id="l3503">  3503</a> idInBalanceParensHard returns [String id = &quot;&quot;]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3504" id="l3504">  3504</a>         :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3505" id="l3505">  3505</a>              (
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3506" id="l3506">  3506</a>                 LPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3507" id="l3507">  3507</a>                 id = idInBalanceParensHard                 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3508" id="l3508">  3508</a>                 RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3509" id="l3509">  3509</a>               )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3510" id="l3510">  3510</a>               |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3511" id="l3511">  3511</a>               id = qualified_id
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3512" id="l3512">  3512</a>         ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3513" id="l3513">  3513</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3514" id="l3514">  3514</a> template_head
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3515" id="l3515">  3515</a> 	:	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3516" id="l3516">  3516</a>                (LITERAL_export!)? 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3517" id="l3517">  3517</a> 		LITERAL_template^
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3518" id="l3518">  3518</a> 		LESSTHAN! tpl:template_parameter_list GREATERTHAN!
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3519" id="l3519">  3519</a> 		//{ #template_head = #(#[CSM_TEMPLATE_PARMLIST, &quot;CSM_TEMPLATE_PARMLIST&quot;], #tpl); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3520" id="l3520">  3520</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3521" id="l3521">  3521</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3522" id="l3522">  3522</a> template_parameter_list
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3523" id="l3523">  3523</a> 	:	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3524" id="l3524">  3524</a> 		//{beginTemplateParameterList();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3525" id="l3525">  3525</a> 		template_parameter (COMMA template_parameter)*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3526" id="l3526">  3526</a> 		//{endTemplateParameterList();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3527" id="l3527">  3527</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3528" id="l3528">  3528</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3529" id="l3529">  3529</a> /* Rule requires &gt;2 lookahead tokens. The ambiguity is resolved 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3530" id="l3530">  3530</a>  * correctly, however. According to the manual &quot;...A template argument
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3531" id="l3531">  3531</a>  * that can be interpreted either as a parameter-declaration or a
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3532" id="l3532">  3532</a>  * type-argument (because its identifier is the name of an
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3533" id="l3533">  3533</a>  * already existing class) is taken as type-argument.&quot;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3534" id="l3534">  3534</a>  * Therefore, any &quot;class literal_ident&quot; that is seen on the input, should
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3535" id="l3535">  3535</a>  * match the first alternative here (it should be a type-argument).
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3536" id="l3536">  3536</a>  */
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3537" id="l3537">  3537</a> template_parameter
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3538" id="l3538">  3538</a>     {String id = &quot;&quot;;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3539" id="l3539">  3539</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3540" id="l3540">  3540</a> 	(   ((LITERAL_class|LITERAL_typename) (ELLIPSIS)? (literal_ident (ELLIPSIS)? )? (ASSIGNEQUAL | COMMA | GREATERTHAN)) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3541" id="l3541">  3541</a>                 (LITERAL_class|LITERAL_typename) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3542" id="l3542">  3542</a>                 (ELLIPSIS)? // support for variadic template params
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3543" id="l3543">  3543</a> 		(id = literal_ident (ELLIPSIS)? )? (ASSIGNEQUAL assigned_type_name)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3544" id="l3544">  3544</a> 		{templateTypeParameter((id == null) ? &quot;&quot; : id);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3545" id="l3545">  3545</a> 	|
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3546" id="l3546">  3546</a> 		template_template_parameter
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3547" id="l3547">  3547</a> 	|	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3548" id="l3548">  3548</a> 		parameter_declaration[true]	// DW 30/06/03 This doesn't seem to match the
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3549" id="l3549">  3549</a> 					// current standard
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3550" id="l3550">  3550</a> 	)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3551" id="l3551">  3551</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3552" id="l3552">  3552</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3553" id="l3553">  3553</a> protected template_template_parameter
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3554" id="l3554">  3554</a>     {String s;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3555" id="l3555">  3555</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3556" id="l3556">  3556</a>     template_head
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3557" id="l3557">  3557</a> 	LITERAL_class (ELLIPSIS)? (s=literal_ident)? (ASSIGNEQUAL assigned_type_name)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3558" id="l3558">  3558</a> 	{ #template_template_parameter = #(#[CSM_TEMPLATE_TEMPLATE_PARAMETER, &quot;CSM_TEMPLATE_TEMPLATE_PARAMETER&quot;], #template_template_parameter);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3559" id="l3559">  3559</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3560" id="l3560">  3560</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3561" id="l3561">  3561</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3562" id="l3562">  3562</a> /* This is to allow an assigned type_name in a template parameter
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3563" id="l3563">  3563</a>  *	list to be defined previously in the same parameter list,
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3564" id="l3564">  3564</a>  *	as type setting is ineffective whilst guessing
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3565" id="l3565">  3565</a>  */
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3566" id="l3566">  3566</a> assigned_type_name
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3567" id="l3567">  3567</a> 	{/*TypeSpecifier*/int ts;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3568" id="l3568">  3568</a>          TypeQualifier tq;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3569" id="l3569">  3569</a>          DeclSpecifier ds = dsInvalid;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3570" id="l3570">  3570</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3571" id="l3571">  3571</a>             (options {greedy=true;}: tq=cv_qualifier)? (LITERAL_typename)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3572" id="l3572">  3572</a>             ts = type_specifier[ds, false] (postfix_cv_qualifier)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3573" id="l3573">  3573</a>             abstract_declarator
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3574" id="l3574">  3574</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3575" id="l3575">  3575</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3576" id="l3576">  3576</a> // This rule refers to an instance of a template class or function
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3577" id="l3577">  3577</a> template_id	// aka template_class_name
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3578" id="l3578">  3578</a>     {String s;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3579" id="l3579">  3579</a> 	:	s=literal_ident LESSTHAN template_argument_list GREATERTHAN
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3580" id="l3580">  3580</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3581" id="l3581">  3581</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3582" id="l3582">  3582</a> template_argument_list
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3583" id="l3583">  3583</a> 	:	template_argument (ELLIPSIS)? (COMMA template_argument (ELLIPSIS)? )*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3584" id="l3584">  3584</a>         |    
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3585" id="l3585">  3585</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3586" id="l3586">  3586</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3587" id="l3587">  3587</a> // lazy_template_argument_list skips types and 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3588" id="l3588">  3588</a> // works faster then template_argument_list,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3589" id="l3589">  3589</a> // but it does not make correct AST.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3590" id="l3590">  3590</a> // It's used in predicates only.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3591" id="l3591">  3591</a> lazy_template_argument_list
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3592" id="l3592">  3592</a> 	:	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3593" id="l3593">  3593</a>         lazy_template_argument
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3594" id="l3594">  3594</a>         (   
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3595" id="l3595">  3595</a>             COMMA 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3596" id="l3596">  3596</a>             lazy_template_argument
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3597" id="l3597">  3597</a>         )*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3598" id="l3598">  3598</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3599" id="l3599">  3599</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3600" id="l3600">  3600</a> lazy_template_argument
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3601" id="l3601">  3601</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3602" id="l3602">  3602</a>         {(isTemplateTooDeep(1, 10))}? 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3603" id="l3603">  3603</a>         (~(GREATERTHAN | LESSTHAN | RCURLY | LCURLY))* 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3604" id="l3604">  3604</a>         (
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3605" id="l3605">  3605</a>             lazy_template 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3606" id="l3606">  3606</a>             (~(GREATERTHAN | LESSTHAN | RCURLY | LCURLY | COMMA | ELLIPSIS))*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3607" id="l3607">  3607</a>         )+
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3608" id="l3608">  3608</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3609" id="l3609">  3609</a>         template_param_expression
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3610" id="l3610">  3610</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3611" id="l3611">  3611</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3612" id="l3612">  3612</a> /* Here assignment_expression was changed to shift_expression to rule out
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3613" id="l3613">  3613</a>  *  x&lt; 1&lt;2 &gt; which causes ambiguities. As a result, these can be used only
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3614" id="l3614">  3614</a>  *  by enclosing parentheses x&lt;(1&lt;2)&gt;. This is true for x&lt;1+2&gt; ==&gt; bad,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3615" id="l3615">  3615</a>  *  x&lt;(1+2)&gt; ==&gt; ok.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3616" id="l3616">  3616</a>  */
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3617" id="l3617">  3617</a> template_argument
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3618" id="l3618">  3618</a>     {String s;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3619" id="l3619">  3619</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3620" id="l3620">  3620</a>         {(isTemplateTooDeep(1, 10))}? 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3621" id="l3621">  3621</a>         (~(GREATERTHAN | LESSTHAN | RCURLY | LCURLY))* 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3622" id="l3622">  3622</a>         (
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3623" id="l3623">  3623</a>             lazy_template 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3624" id="l3624">  3624</a>             (~(GREATERTHAN | LESSTHAN | RCURLY | LCURLY | COMMA | ELLIPSIS))*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3625" id="l3625">  3625</a>         )+
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3626" id="l3626">  3626</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3627" id="l3627">  3627</a>         // IZ 167547 : 100% CPU core usage with C++ project.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3628" id="l3628">  3628</a>         // This is check for too complicated tecmplates.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3629" id="l3629">  3629</a>         // If template depth is more then 20 we just skip it.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3630" id="l3630">  3630</a>         ((SCOPE)? (literal_ident SCOPE)* literal_ident templateDepthChecker[20]) =&gt; (SCOPE)? (s=literal_ident SCOPE)* s=literal_ident templateDepthChecker[20]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3631" id="l3631">  3631</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3632" id="l3632">  3632</a>         // IZ 140991 : Parser &quot;hangs&quot; on Loki.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3633" id="l3633">  3633</a>         // This is predicate for fast T&lt;T&lt;...&gt;&gt; pattern recognition.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3634" id="l3634">  3634</a>         ((SCOPE)? (literal_ident SCOPE)* literal_ident simpleBalanceLessthanGreaterthanInExpression (COMMA | GREATERTHAN)) =&gt; type_name
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3635" id="l3635">  3635</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3636" id="l3636">  3636</a>         (type_name (COMMA | GREATERTHAN)) =&gt; type_name
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3637" id="l3637">  3637</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3638" id="l3638">  3638</a>         template_param_expression
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3639" id="l3639">  3639</a> ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3640" id="l3640">  3640</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3641" id="l3641">  3641</a> lazy_template
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3642" id="l3642">  3642</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3643" id="l3643">  3643</a>         LESSTHAN
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3644" id="l3644">  3644</a>         (
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3645" id="l3645">  3645</a>             (   ~(GREATERTHAN | LESSTHAN | RCURLY | LCURLY)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3646" id="l3646">  3646</a>             |   lazy_template
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3647" id="l3647">  3647</a>             )*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3648" id="l3648">  3648</a>         )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3649" id="l3649">  3649</a>         GREATERTHAN
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3650" id="l3650">  3650</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3651" id="l3651">  3651</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3652" id="l3652">  3652</a> templateDepthChecker[int i]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3653" id="l3653">  3653</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3654" id="l3654">  3654</a>         LESSTHAN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3655" id="l3655">  3655</a>         (
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3656" id="l3656">  3656</a>             (   {(i &gt; 0)}? (~(LESSTHAN | GREATERTHAN | RCURLY | LCURLY))*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3657" id="l3657">  3657</a>                 templateDepthChecker[i - 1]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3658" id="l3658">  3658</a>                 (~(GREATERTHAN | RCURLY | LCURLY))*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3659" id="l3659">  3659</a>             |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3660" id="l3660">  3660</a>                 {(i &lt;= 0)}? (   ~(GREATERTHAN | LESSTHAN | RCURLY | LCURLY)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3661" id="l3661">  3661</a>                 |   templateDepthChecker[i - 1]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3662" id="l3662">  3662</a>                 )*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3663" id="l3663">  3663</a>             )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3664" id="l3664">  3664</a>         )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3665" id="l3665">  3665</a>         GREATERTHAN
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3666" id="l3666">  3666</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3667" id="l3667">  3667</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3668" id="l3668">  3668</a> ///////////////////////////////////////////////////////////////////////
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3669" id="l3669">  3669</a> ///////////////////////////////////////////////////////////////////////
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3670" id="l3670">  3670</a> //////////////////////////////  STATEMENTS ////////////////////////////
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3671" id="l3671">  3671</a> ///////////////////////////////////////////////////////////////////////
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3672" id="l3672">  3672</a> ///////////////////////////////////////////////////////////////////////
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3673" id="l3673">  3673</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3674" id="l3674">  3674</a> statement_list
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3675" id="l3675">  3675</a> 	:	(statement)+
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3676" id="l3676">  3676</a> 		//{#statement_list = #(#[CSM_STATEMENT_LIST, &quot;CSM_STATEMENT_LIST&quot;], #statement_list);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3677" id="l3677">  3677</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3678" id="l3678">  3678</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3679" id="l3679">  3679</a> single_statement
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3680" id="l3680">  3680</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3681" id="l3681">  3681</a>         (literal_ident COLON) =&gt; compound_labeled_statement
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3682" id="l3682">  3682</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3683" id="l3683">  3683</a>         statement
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3684" id="l3684">  3684</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3685" id="l3685">  3685</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3686" id="l3686">  3686</a> statement
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3687" id="l3687">  3687</a> 	{StorageClass sc = scInvalid; int ts = 0;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3688" id="l3688">  3688</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3689" id="l3689">  3689</a> 	(	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3690" id="l3690">  3690</a>                 // Issue 83496   C++ parser does not allow class definition inside function
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3691" id="l3691">  3691</a>                 ((  storage_class_specifier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3692" id="l3692">  3692</a> 		|   cv_qualifier 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3693" id="l3693">  3693</a> 		|   LITERAL_typedef
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3694" id="l3694">  3694</a> 		)* class_head) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3695" id="l3695">  3695</a> 		{if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3696" id="l3696">  3696</a> 			printf(&quot;statement_1[%d]: Class definition\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3697" id="l3697">  3697</a> 				LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3698" id="l3698">  3698</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3699" id="l3699">  3699</a> 		declaration[declOther]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3700" id="l3700">  3700</a> 		{ #statement = #(#[CSM_CLASS_DECLARATION, &quot;CSM_CLASS_DECLARATION&quot;], #statement); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3701" id="l3701">  3701</a> 	|  
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3702" id="l3702">  3702</a>                 ((  storage_class_specifier
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3703" id="l3703">  3703</a> 		|   cv_qualifier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3704" id="l3704">  3704</a> 		|   LITERAL_typedef
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3705" id="l3705">  3705</a> 		)* class_forward_declaration) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3706" id="l3706">  3706</a> 		{if (statementTrace&gt;=1)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3707" id="l3707">  3707</a> 			printf(&quot;statement_1[%d]: Class forward declaration\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3708" id="l3708">  3708</a> 				LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3709" id="l3709">  3709</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3710" id="l3710">  3710</a> 		declaration[declOther]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3711" id="l3711">  3711</a> 		{ #statement = #(#[CSM_GENERIC_DECLARATION, &quot;CSM_GENERIC_DECLARATION&quot;], #statement); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3712" id="l3712">  3712</a> 	|
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3713" id="l3713">  3713</a>                 // Issue 83996   Code completion list doesn't appear if enum defined within function (without messages)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3714" id="l3714">  3714</a> 		// Enum definition (don't want to backtrack over this in other alts)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3715" id="l3715">  3715</a> 		((storage_class_specifier)? LITERAL_enum (LITERAL_class | LITERAL_struct)? (literal_ident)? (COLON ts = builtin_cv_type_specifier[ts])? LCURLY)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3716" id="l3716">  3716</a>                 (sc = storage_class_specifier)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3717" id="l3717">  3717</a> 		{if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3718" id="l3718">  3718</a> 			printf(&quot;statement_2[%d]: Enum definition\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3719" id="l3719">  3719</a> 				LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3720" id="l3720">  3720</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3721" id="l3721">  3721</a> 		enum_specifier (member_declarator_list)? SEMICOLON!	//{end_of_stmt();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3722" id="l3722">  3722</a> 		{ #statement = #(#[CSM_ENUM_DECLARATION, &quot;CSM_ENUM_DECLARATION&quot;], #statement); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3723" id="l3723">  3723</a> 	|
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3724" id="l3724">  3724</a> 		( LITERAL_typedef ) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3725" id="l3725">  3725</a> 		// TODO: external_declaration is too generic here. Refactor this!
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3726" id="l3726">  3726</a> 		external_declaration
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3727" id="l3727">  3727</a> 	|
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3728" id="l3728">  3728</a>                 // Function definition in C language
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3729" id="l3729">  3729</a>                 {isC()}?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3730" id="l3730">  3730</a>                 ((LITERAL___extension__)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3731" id="l3731">  3731</a>                     (options {greedy=true;} :function_attribute_specification!)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3732" id="l3732">  3732</a>                     declaration_specifiers[false, false]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3733" id="l3733">  3733</a>                     (options {greedy=true;} :function_attribute_specification!)? 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3734" id="l3734">  3734</a>                     function_declarator[true, false, false] LCURLY
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3735" id="l3735">  3735</a>                 ) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3736" id="l3736">  3736</a>                 external_declaration {#statement = #(#[CSM_DECLARATION_STATEMENT, &quot;CSM_DECLARATION_STATEMENT&quot;], #statement);} // TODO: refactor this
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3737" id="l3737">  3737</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3738" id="l3738">  3738</a>                 { LT(1).getText().equals(LITERAL_EXEC) &amp;&amp; LT(2).getText().equals(LITERAL_SQL) }? (literal_ident literal_ident) =&gt; pro_c_statement
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3739" id="l3739">  3739</a>                 {if (statementTrace&gt;=1)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3740" id="l3740">  3740</a> 			printf(&quot;statement_13[%d]: pro_c_statement\n&quot;, LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3741" id="l3741">  3741</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3742" id="l3742">  3742</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3743" id="l3743">  3743</a>                 ( is_known_typename LPAREN literal_ident RPAREN) =&gt; // declaration like &quot;int(a);&quot;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3744" id="l3744">  3744</a>                 {if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3745" id="l3745">  3745</a>                         printf(&quot;statement_1a[%d]: declaration\n&quot;, LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3746" id="l3746">  3746</a>                 }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3747" id="l3747">  3747</a>                 declaration[declGeneric]  {#statement = #(#[CSM_DECLARATION_STATEMENT, &quot;CSM_DECLARATION_STATEMENT&quot;], #statement);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3748" id="l3748">  3748</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3749" id="l3749">  3749</a>                 // #227479 - SQL EXEC support is broken
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3750" id="l3750">  3750</a>                 // This alternative is greedy and must be after pro_c alternative
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3751" id="l3751">  3751</a>                 ( is_declaration | LITERAL_namespace | literal_inline LITERAL_namespace | LITERAL_static_assert ) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3752" id="l3752">  3752</a>                 {if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3753" id="l3753">  3753</a> 			printf(&quot;statement_1[%d]: declaration\n&quot;, LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3754" id="l3754">  3754</a> 		}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3755" id="l3755">  3755</a>                 declaration[declStatement]  {#statement = #(#[CSM_DECLARATION_STATEMENT, &quot;CSM_DECLARATION_STATEMENT&quot;], #statement);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3756" id="l3756">  3756</a> 	|	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3757" id="l3757">  3757</a>                 {if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3758" id="l3758">  3758</a> 			printf(&quot;statement_2[%d]: labeled_statement\n&quot;, LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3759" id="l3759">  3759</a> 		}                
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3760" id="l3760">  3760</a>                 (literal_ident COLON) =&gt; labeled_statement
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3761" id="l3761">  3761</a> 	|
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3762" id="l3762">  3762</a>                 {if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3763" id="l3763">  3763</a> 			printf(&quot;statement_3[%d]: case_statement\n&quot;, LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3764" id="l3764">  3764</a> 		}	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3765" id="l3765">  3765</a>                 case_statement
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3766" id="l3766">  3766</a> 	|
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3767" id="l3767">  3767</a>                 {if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3768" id="l3768">  3768</a> 			printf(&quot;statement_4[%d]: default_statement\n&quot;, LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3769" id="l3769">  3769</a> 		}	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3770" id="l3770">  3770</a>                 default_statement
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3771" id="l3771">  3771</a> 	|
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3772" id="l3772">  3772</a>                 {if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3773" id="l3773">  3773</a> 			printf(&quot;statement_5[%d]: expression\n&quot;, LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3774" id="l3774">  3774</a> 		}	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3775" id="l3775">  3775</a>                 expression SEMICOLON! {/*end_of_stmt();*/#statement = #(#[CSM_EXPRESSION_STATEMENT, &quot;CSM_EXPRESSION_STATEMENT&quot;], #statement);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3776" id="l3776">  3776</a> 	|
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3777" id="l3777">  3777</a>                 {if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3778" id="l3778">  3778</a> 			printf(&quot;statement_6[%d]: compound_statement\n&quot;, LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3779" id="l3779">  3779</a> 		}	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3780" id="l3780">  3780</a>                 compound_statement
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3781" id="l3781">  3781</a> 	|
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3782" id="l3782">  3782</a>                 {if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3783" id="l3783">  3783</a> 			printf(&quot;statement_7[%d]: selection_statement\n&quot;, LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3784" id="l3784">  3784</a> 		}	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3785" id="l3785">  3785</a>                 selection_statement
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3786" id="l3786">  3786</a> 	|
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3787" id="l3787">  3787</a>                 {if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3788" id="l3788">  3788</a> 			printf(&quot;statement_8[%d]: iteration_statement\n&quot;, LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3789" id="l3789">  3789</a> 		}	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3790" id="l3790">  3790</a>                 iteration_statement
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3791" id="l3791">  3791</a> 	|
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3792" id="l3792">  3792</a>                 {if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3793" id="l3793">  3793</a> 			printf(&quot;statement_9[%d]: jump_statement\n&quot;, LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3794" id="l3794">  3794</a> 		}	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3795" id="l3795">  3795</a>                 jump_statement
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3796" id="l3796">  3796</a> 	|
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3797" id="l3797">  3797</a>                 {if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3798" id="l3798">  3798</a> 			printf(&quot;statement_10[%d]: SEMICOLON\n&quot;, LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3799" id="l3799">  3799</a> 		}	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3800" id="l3800">  3800</a>                 SEMICOLON! //{end_of_stmt();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3801" id="l3801">  3801</a> 	|
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3802" id="l3802">  3802</a>                 {if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3803" id="l3803">  3803</a> 			printf(&quot;statement_11[%d]: try_block\n&quot;, LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3804" id="l3804">  3804</a> 		}	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3805" id="l3805">  3805</a>                 try_block[false]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3806" id="l3806">  3806</a> 	|
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3807" id="l3807">  3807</a>                 {if (statementTrace&gt;=1) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3808" id="l3808">  3808</a> 			printf(&quot;statement_13[%d]: asm_block\n&quot;, LT(1).getLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3809" id="l3809">  3809</a> 		}	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3810" id="l3810">  3810</a>                 asm_block
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3811" id="l3811">  3811</a> //	|	preprocDirective
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3812" id="l3812">  3812</a> //        |       member_declaration
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3813" id="l3813">  3813</a> )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3814" id="l3814">  3814</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3815" id="l3815">  3815</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3816" id="l3816">  3816</a> labeled_statement
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3817" id="l3817">  3817</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3818" id="l3818">  3818</a>     label COLON (options {greedy = true;} : attribute_specification!)? single_statement
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3819" id="l3819">  3819</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3820" id="l3820">  3820</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3821" id="l3821">  3821</a> compound_labeled_statement
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3822" id="l3822">  3822</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3823" id="l3823">  3823</a>         labeled_statement
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3824" id="l3824">  3824</a>         {#compound_labeled_statement = #([CSM_COMPOUND_STATEMENT, &quot;CSM_COMPOUND_STATEMENT&quot;], #compound_labeled_statement);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3825" id="l3825">  3825</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3826" id="l3826">  3826</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3827" id="l3827">  3827</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3828" id="l3828">  3828</a> is_known_typename
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3829" id="l3829">  3829</a> {/*TypeSpecifier*/int ts=0;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3830" id="l3830">  3830</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3831" id="l3831">  3831</a>         ts=builtin_type[0]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3832" id="l3832">  3832</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3833" id="l3833">  3833</a>         is_va_list_type
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3834" id="l3834">  3834</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3835" id="l3835">  3835</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3836" id="l3836">  3836</a> // This rule should use IDENT instead of literal_ident because in predicates 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3837" id="l3837">  3837</a> // rules don't return values, so contentEquals wouldn't work
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3838" id="l3838">  3838</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3839" id="l3839">  3839</a> is_va_list_type : id:IDENT {&quot;va_list&quot;.contentEquals(id.getText())}?; 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3840" id="l3840">  3840</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3841" id="l3841">  3841</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3842" id="l3842">  3842</a> label
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3843" id="l3843">  3843</a>     {String s;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3844" id="l3844">  3844</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3845" id="l3845">  3845</a> 	s=literal_ident
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3846" id="l3846">  3846</a> 	{#label = #([CSM_LABELED_STATEMENT, &quot;CSM_LABELED_STATEMENT&quot;], #label);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3847" id="l3847">  3847</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3848" id="l3848">  3848</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3849" id="l3849">  3849</a> case_statement
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3850" id="l3850">  3850</a> 	:	LITERAL_case
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3851" id="l3851">  3851</a> 		case_expression COLON single_statement
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3852" id="l3852">  3852</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3853" id="l3853">  3853</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3854" id="l3854">  3854</a> default_statement
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3855" id="l3855">  3855</a> 	:	default_label COLON single_statement
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3856" id="l3856">  3856</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3857" id="l3857">  3857</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3858" id="l3858">  3858</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3859" id="l3859">  3859</a> default_label
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3860" id="l3860">  3860</a> 	:	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3861" id="l3861">  3861</a> 	LITERAL_default
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3862" id="l3862">  3862</a> 		{#default_label = #(#[CSM_DEFAULT_STATEMENT, &quot;CSM_DEFAULT_STATEMENT&quot;], #default_label);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3863" id="l3863">  3863</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3864" id="l3864">  3864</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3865" id="l3865">  3865</a> compound_statement
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3866" id="l3866">  3866</a> 	:                    
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3867" id="l3867">  3867</a>             {isLazyCompound()}? balanceCurlies             
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3868" id="l3868">  3868</a>             {#compound_statement = #(#[CSM_COMPOUND_STATEMENT_LAZY, &quot;CSM_COMPOUND_STATEMENT_LAZY&quot;], #compound_statement);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3869" id="l3869">  3869</a>         |   {!isLazyCompound()}?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3870" id="l3870">  3870</a>             (
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3871" id="l3871">  3871</a>                 {action.compound_statement(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3872" id="l3872">  3872</a>                 LCURLY
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3873" id="l3873">  3873</a> 		/*{
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3874" id="l3874">  3874</a> 		    //end_of_stmt();
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3875" id="l3875">  3875</a> 		    //enterNewLocalScope();
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3876" id="l3876">  3876</a> 		}*/
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3877" id="l3877">  3877</a> 		(statement_list)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3878" id="l3878">  3878</a>                 {action.end_compound_statement(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3879" id="l3879">  3879</a> 		( EOF! { reportError(new NoViableAltException(org.netbeans.modules.cnd.apt.utils.APTUtils.EOF_TOKEN, getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3880" id="l3880">  3880</a>                 | RCURLY )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3881" id="l3881">  3881</a> 		//{exitLocalScope();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3882" id="l3882">  3882</a> 		{#compound_statement = #(#[CSM_COMPOUND_STATEMENT, &quot;CSM_COMPOUND_STATEMENT&quot;], #compound_statement);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3883" id="l3883">  3883</a>             )                      
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3884" id="l3884">  3884</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3885" id="l3885">  3885</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3886" id="l3886">  3886</a> function_try_block[boolean constructor]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3887" id="l3887">  3887</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3888" id="l3888">  3888</a>         {isLazyCompound()}?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3889" id="l3889">  3889</a>         literal_try
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3890" id="l3890">  3890</a>         ({(constructor)}?((COLON) =&gt; ctor_initializer)?)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3891" id="l3891">  3891</a>         balanceCurlies
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3892" id="l3892">  3892</a>         (options {greedy=true;} : 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3893" id="l3893">  3893</a>         (  
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3894" id="l3894">  3894</a>             LITERAL_catch LPAREN exception_declaration RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3895" id="l3895">  3895</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3896" id="l3896">  3896</a>             literal_finally
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3897" id="l3897">  3897</a>         )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3898" id="l3898">  3898</a>         balanceCurlies)*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3899" id="l3899">  3899</a>         {#function_try_block = #(#[CSM_TRY_CATCH_STATEMENT_LAZY, &quot;CSM_TRY_CATCH_STATEMENT_LAZY&quot;], #function_try_block);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3900" id="l3900">  3900</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3901" id="l3901">  3901</a>         {!isLazyCompound()}?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3902" id="l3902">  3902</a>         try_block[constructor]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3903" id="l3903">  3903</a>         {#function_try_block = #(#[CSM_COMPOUND_STATEMENT, &quot;CSM_COMPOUND_STATEMENT&quot;], #function_try_block);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3904" id="l3904">  3904</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3905" id="l3905">  3905</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3906" id="l3906">  3906</a> protected 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3907" id="l3907">  3907</a> condition
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3908" id="l3908">  3908</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3909" id="l3909">  3909</a>         (
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3910" id="l3910">  3910</a>             (condition_declaration) =&gt; condition_declaration
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3911" id="l3911">  3911</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3912" id="l3912">  3912</a>             condition_expression
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3913" id="l3913">  3913</a>         )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3914" id="l3914">  3914</a>         {#condition=#(#[CSM_CONDITION, &quot;CSM_CONDITION&quot;], #condition);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3915" id="l3915">  3915</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3916" id="l3916">  3916</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3917" id="l3917">  3917</a> protected 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3918" id="l3918">  3918</a> condition_expression
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3919" id="l3919">  3919</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3920" id="l3920">  3920</a> 	expression
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3921" id="l3921">  3921</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3922" id="l3922">  3922</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3923" id="l3923">  3923</a> protected 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3924" id="l3924">  3924</a> condition_declaration {int ts = tsInvalid;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3925" id="l3925">  3925</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3926" id="l3926">  3926</a>         declaration_specifiers[true, false]  
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3927" id="l3927">  3927</a>         declarator[declStatement, 0]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3928" id="l3928">  3928</a>         (   ASSIGNEQUAL assignment_expression
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3929" id="l3929">  3929</a>         |   array_initializer 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3930" id="l3930">  3930</a>         )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3931" id="l3931">  3931</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3932" id="l3932">  3932</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3933" id="l3933">  3933</a> //	(declaration)=&gt; declaration|	expression
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3934" id="l3934">  3934</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3935" id="l3935">  3935</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3936" id="l3936">  3936</a> /* NOTE: cannot remove ELSE ambiguity, but it parses correctly.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3937" id="l3937">  3937</a>  * The warning is removed with the options statement
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3938" id="l3938">  3938</a>  */
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3939" id="l3939">  3939</a> selection_statement
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3940" id="l3940">  3940</a> 	:	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3941" id="l3941">  3941</a> 		LITERAL_if LPAREN 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3942" id="l3942">  3942</a> 		condition RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3943" id="l3943">  3943</a> 		single_statement
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3944" id="l3944">  3944</a> 		(options {warnWhenFollowAmbig = false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3945" id="l3945">  3945</a> 		 LITERAL_else single_statement)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3946" id="l3946">  3946</a> 		{#selection_statement = #(#[CSM_IF_STATEMENT, &quot;CSM_IF_STATEMENT&quot;], #selection_statement);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3947" id="l3947">  3947</a> 	|	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3948" id="l3948">  3948</a> 		LITERAL_switch LPAREN  condition RPAREN single_statement
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3949" id="l3949">  3949</a> 		{#selection_statement = #(#[CSM_SWITCH_STATEMENT, &quot;CSM_SWITCH_STATEMENT&quot;], #selection_statement);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3950" id="l3950">  3950</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3951" id="l3951">  3951</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3952" id="l3952">  3952</a> iteration_statement
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3953" id="l3953">  3953</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3954" id="l3954">  3954</a> 	while_statement | do_while_statement | for_statement
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3955" id="l3955">  3955</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3956" id="l3956">  3956</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3957" id="l3957">  3957</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3958" id="l3958">  3958</a> while_statement
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3959" id="l3959">  3959</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3960" id="l3960">  3960</a> 		LITERAL_while	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3961" id="l3961">  3961</a> 		LPAREN! condition RPAREN! 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3962" id="l3962">  3962</a> 		single_statement
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3963" id="l3963">  3963</a> 		{#while_statement = #(#[CSM_WHILE_STATEMENT, &quot;CSM_WHILE_STATEMENT&quot;], #while_statement);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3964" id="l3964">  3964</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3965" id="l3965">  3965</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3966" id="l3966">  3966</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3967" id="l3967">  3967</a> do_while_statement
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3968" id="l3968">  3968</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3969" id="l3969">  3969</a> 		LITERAL_do 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3970" id="l3970">  3970</a> 		single_statement LITERAL_while
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3971" id="l3971">  3971</a> 		LPAREN! expression RPAREN! 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3972" id="l3972">  3972</a> 		( EOF! { reportError(new NoViableAltException(org.netbeans.modules.cnd.apt.utils.APTUtils.EOF_TOKEN, getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3973" id="l3973">  3973</a>         | SEMICOLON ) //{end_of_stmt();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3974" id="l3974">  3974</a> 		{#do_while_statement = #(#[CSM_DO_WHILE_STATEMENT, &quot;CSM_DO_WHILE_STATEMENT&quot;], #do_while_statement);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3975" id="l3975">  3975</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3976" id="l3976">  3976</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3977" id="l3977">  3977</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3978" id="l3978">  3978</a> for_statement
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3979" id="l3979">  3979</a> :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3980" id="l3980">  3980</a>     LITERAL_for LPAREN!
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3981" id="l3981">  3981</a>     (
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3982" id="l3982">  3982</a>         (for_range_init_statement COLON) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3983" id="l3983">  3983</a>         for_range_init_statement COLON (expression | array_initializer)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3984" id="l3984">  3984</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3985" id="l3985">  3985</a>         for_init_statement
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3986" id="l3986">  3986</a>         (
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3987" id="l3987">  3987</a>             (condition)? 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3988" id="l3988">  3988</a>             ( EOF! { reportError(new NoViableAltException(org.netbeans.modules.cnd.apt.utils.APTUtils.EOF_TOKEN, getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3989" id="l3989">  3989</a>             | SEMICOLON )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3990" id="l3990">  3990</a>             (expression)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3991" id="l3991">  3991</a>         )?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3992" id="l3992">  3992</a>     )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3993" id="l3993">  3993</a>     RPAREN! single_statement
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3994" id="l3994">  3994</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3995" id="l3995">  3995</a>     {#for_statement = #(#[CSM_FOR_STATEMENT, &quot;CSM_FOR_STATEMENT&quot;], #for_statement);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3996" id="l3996">  3996</a> ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3997" id="l3997">  3997</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l3998" id="l3998">  3998</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3999" id="l3999">  3999</a> for_init_statement
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4000" id="l4000">  4000</a> :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4001" id="l4001">  4001</a>     (   (declaration[declStatement])=&gt; declaration[declStatement]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4002" id="l4002">  4002</a>     |   expression 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4003" id="l4003">  4003</a>         ( EOF! { reportError(new NoViableAltException(org.netbeans.modules.cnd.apt.utils.APTUtils.EOF_TOKEN, getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4004" id="l4004">  4004</a>         | SEMICOLON ) //{end_of_stmt();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4005" id="l4005">  4005</a>     |   ( EOF! { reportError(new NoViableAltException(org.netbeans.modules.cnd.apt.utils.APTUtils.EOF_TOKEN, getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4006" id="l4006">  4006</a>         | SEMICOLON) //{end_of_stmt();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4007" id="l4007">  4007</a>     )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4008" id="l4008">  4008</a>     {#for_init_statement = #(#[CSM_FOR_INIT_STATEMENT, &quot;CSM_FOR_INIT_STATEMENT&quot;], #for_init_statement);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4009" id="l4009">  4009</a> ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4010" id="l4010">  4010</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4011" id="l4011">  4011</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4012" id="l4012">  4012</a> for_range_init_statement
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4013" id="l4013">  4013</a> :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4014" id="l4014">  4014</a>     declaration_specifiers[true, false] init_declarator[declStatement]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4015" id="l4015">  4015</a>     {#for_range_init_statement = #(#[CSM_FOR_INIT_STATEMENT, &quot;CSM_FOR_INIT_STATEMENT&quot;], #for_range_init_statement);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4016" id="l4016">  4016</a> ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4017" id="l4017">  4017</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4018" id="l4018">  4018</a> jump_statement
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4019" id="l4019">  4019</a>     {String s;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4020" id="l4020">  4020</a> 	:	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4021" id="l4021">  4021</a> 	(	LITERAL_goto 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4022" id="l4022">  4022</a>                 ((literal_ident (EOF | SEMICOLON)) =&gt; s=literal_ident
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4023" id="l4023">  4023</a>                 | expression)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4024" id="l4024">  4024</a>                 (EOF! { reportError(new NoViableAltException(org.netbeans.modules.cnd.apt.utils.APTUtils.EOF_TOKEN, getFilename())); } |SEMICOLON)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4025" id="l4025">  4025</a>         {/*end_of_stmt();*/ #jump_statement = #(#[CSM_GOTO_STATEMENT, &quot;CSM_GOTO_STATEMENT&quot;], #jump_statement);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4026" id="l4026">  4026</a> 	|	LITERAL_continue (EOF! { reportError(new NoViableAltException(org.netbeans.modules.cnd.apt.utils.APTUtils.EOF_TOKEN, getFilename())); } |SEMICOLON)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4027" id="l4027">  4027</a>         {/*end_of_stmt();*/ #jump_statement = #(#[CSM_CONTINUE_STATEMENT, &quot;CSM_CONTINUE_STATEMENT&quot;], #jump_statement);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4028" id="l4028">  4028</a> 	|	LITERAL_break (EOF! { reportError(new NoViableAltException(org.netbeans.modules.cnd.apt.utils.APTUtils.EOF_TOKEN, getFilename())); } |SEMICOLON)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4029" id="l4029">  4029</a>         {/*end_of_stmt();*/ #jump_statement = #(#[CSM_BREAK_STATEMENT, &quot;CSM_BREAK_STATEMENT&quot;], #jump_statement);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4030" id="l4030">  4030</a> 		// DW 16/05/03 May be problem here if return is followed by a cast expression 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4031" id="l4031">  4031</a> 	|	LITERAL_return {in_return = true;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4032" id="l4032">  4032</a> 		(	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4033" id="l4033">  4033</a>                         // VV 22/05/06: commented out alternatives, 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4034" id="l4034">  4034</a>                         // because &quot;return (a)==(b);&quot; incorrectly handled
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4035" id="l4035">  4035</a> /*                        
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4036" id="l4036">  4036</a>                         options{warnWhenFollowAmbig = false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4037" id="l4037">  4037</a> 			(LPAREN {(qualifiedItemIsOneOf(qiType) )}? literal_ident RPAREN)=&gt; 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4038" id="l4038">  4038</a> 			LPAREN literal_ident RPAREN (expression)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4039" id="l4039">  4039</a> 			// This is an unsatisfactory fix
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4040" id="l4040">  4040</a> 			// for problem in xstring re
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4041" id="l4041">  4041</a> 			// &quot;return (allocator);&quot;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4042" id="l4042">  4042</a> 			//  and in xlocale re 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4043" id="l4043">  4043</a> 			// &quot;return (_E)(_Tolower((unsigned char)_C, &amp;_Ctype));'
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4044" id="l4044">  4044</a> 			//{printf(&quot;jump_statement[%d]: Return fix used\n&quot;,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4045" id="l4045">  4045</a> 			//		LT(1).getLine());}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4046" id="l4046">  4046</a> 		|	expression 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4047" id="l4047">  4047</a> */
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4048" id="l4048">  4048</a>                 (   ((LITERAL___extension__)? cast_array_initializer_head) =&gt; initializer
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4049" id="l4049">  4049</a>                 |   expression
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4050" id="l4050">  4050</a>                 )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4051" id="l4051">  4051</a> 	)?	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4052" id="l4052">  4052</a>         (EOF! { reportError(new NoViableAltException(org.netbeans.modules.cnd.apt.utils.APTUtils.EOF_TOKEN, getFilename())); } |SEMICOLON)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4053" id="l4053">  4053</a>         {in_return = false; /*end_of_stmt();*/ #jump_statement = #(#[CSM_RETURN_STATEMENT, &quot;CSM_RETURN_STATEMENT&quot;], #jump_statement);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4054" id="l4054">  4054</a> 	)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4055" id="l4055">  4055</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4056" id="l4056">  4056</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4057" id="l4057">  4057</a> try_block[boolean constructor]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4058" id="l4058">  4058</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4059" id="l4059">  4059</a>     literal_try
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4060" id="l4060">  4060</a>     ({(constructor)}?((COLON) =&gt; ctor_initializer)?)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4061" id="l4061">  4061</a>     compound_statement (options {greedy=true;} : handler)*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4062" id="l4062">  4062</a>     {#try_block = #(#[CSM_TRY_STATEMENT, &quot;CSM_TRY_STATEMENT&quot;], #try_block);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4063" id="l4063">  4063</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4064" id="l4064">  4064</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4065" id="l4065">  4065</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4066" id="l4066">  4066</a> handler
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4067" id="l4067">  4067</a> 	:	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4068" id="l4068">  4068</a>                 (  
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4069" id="l4069">  4069</a>                     LITERAL_catch LPAREN exception_declaration RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4070" id="l4070">  4070</a>                 |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4071" id="l4071">  4071</a>                     literal_finally
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4072" id="l4072">  4072</a>                 )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4073" id="l4073">  4073</a> 		compound_statement
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4074" id="l4074">  4074</a> 		{/*exceptionEndHandler();*/{#handler = #(#[CSM_CATCH_CLAUSE, &quot;CSM_CATCH_CLAUSE&quot;], #handler);}}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4075" id="l4075">  4075</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4076" id="l4076">  4076</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4077" id="l4077">  4077</a> exception_declaration
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4078" id="l4078">  4078</a> 	:	parameter_declaration_list[false]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4079" id="l4079">  4079</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4080" id="l4080">  4080</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4081" id="l4081">  4081</a> /* This is an expression of type void according to the ARM, which
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4082" id="l4082">  4082</a>  * to me means &quot;statement&quot;; it removes some ambiguity to put it in
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4083" id="l4083">  4083</a>  * as a statement also.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4084" id="l4084">  4084</a>  */
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4085" id="l4085">  4085</a> throw_expression
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4086" id="l4086">  4086</a> 	:	LITERAL_throw (options {greedy=true;}: assignment_expression) ? 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4087" id="l4087">  4087</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4088" id="l4088">  4088</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4089" id="l4089">  4089</a> using_declaration
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4090" id="l4090">  4090</a> 	{String qid=&quot;&quot;;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4091" id="l4091">  4091</a> 	:	u:LITERAL_using
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4092" id="l4092">  4092</a> 		(ns:LITERAL_namespace 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4093" id="l4093">  4093</a>                     {action.using_directive(u, ns);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4094" id="l4094">  4094</a>                     {if(LA(1) == SCOPE) {action.using_directive(action.USING_DIRECTIVE__SCOPE, LT(1));}} 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4095" id="l4095">  4095</a>                     qid = qualified_id	// Using-directive
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4096" id="l4096">  4096</a>                     {action.end_using_directive(LT(0));}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4097" id="l4097">  4097</a> 		    {#using_declaration = #[CSM_USING_DIRECTIVE, qid]; #using_declaration.addChild(#u);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4098" id="l4098">  4098</a> 		|
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4099" id="l4099">  4099</a>                     {action.using_declaration(u);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4100" id="l4100">  4100</a>                     {if(LA(1) == SCOPE) {action.using_declaration(action.USING_DECLARATION__SCOPE, LT(1));}} 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4101" id="l4101">  4101</a>                     (LITERAL_typename)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4102" id="l4102">  4102</a>                     qid = unqualified_id				// Using-declaration
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4103" id="l4103">  4103</a>                     {action.end_using_declaration(LT(1));}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4104" id="l4104">  4104</a> 		    {#using_declaration = #[CSM_USING_DECLARATION, qid]; #using_declaration.addChild(#u);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4105" id="l4105">  4105</a> 		)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4106" id="l4106">  4106</a>                 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4107" id="l4107">  4107</a> 		SEMICOLON! //{end_of_stmt();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4108" id="l4108">  4108</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4109" id="l4109">  4109</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4110" id="l4110">  4110</a> alias_declaration
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4111" id="l4111">  4111</a>     {String s;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4112" id="l4112">  4112</a> 	:	LITERAL_using
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4113" id="l4113">  4113</a> 		s=literal_ident ASSIGNEQUAL alias_declaration_type
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4114" id="l4114">  4114</a> 		SEMICOLON //{end_of_stmt();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4115" id="l4115">  4115</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4116" id="l4116">  4116</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4117" id="l4117">  4117</a> // Rule to catch class definition inside type alias
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4118" id="l4118">  4118</a> alias_declaration_type
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4119" id="l4119">  4119</a>         :   
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4120" id="l4120">  4120</a>             ( 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4121" id="l4121">  4121</a>                 // We do not need to process template classes here because of standard.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4122" id="l4122">  4122</a>                 // [dcl.type], point 3:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4123" id="l4123">  4123</a>                 // A type-specifier-seq shall not define a class or enumeration
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4124" id="l4124">  4124</a>                 // unless it appears in the type-id of an alias-declaration (7.1.3) that
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4125" id="l4125">  4125</a>                 // is not the declaration of a template-declaration.  
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4126" id="l4126">  4126</a>                 (class_head)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4127" id="l4127">  4127</a>                     type_name
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4128" id="l4128">  4128</a>                     {#alias_declaration_type = #(#[CSM_CLASS_DECLARATION, &quot;CSM_CLASS_DECLARATION&quot;], #alias_declaration_type);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4129" id="l4129">  4129</a>             |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4130" id="l4130">  4130</a>                 (enum_def_head)=&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4131" id="l4131">  4131</a>                     // TODO: think about handling enums via type_name 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4132" id="l4132">  4132</a>                     {if(statementTrace&gt;=1) printf(&quot;typedef_enum [%d]\n&quot;,LT(1).getLine()); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4133" id="l4133">  4133</a>                     enum_specifier 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4134" id="l4134">  4134</a>                     (init_declarator_list[declOther])?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4135" id="l4135">  4135</a>                     {#alias_declaration_type = #(#[CSM_ENUM_DECLARATION, &quot;CSM_ENUM_DECLARATION&quot;], #alias_declaration_type);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4136" id="l4136">  4136</a>             |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4137" id="l4137">  4137</a>                 alias_type_name
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4138" id="l4138">  4138</a>             )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4139" id="l4139">  4139</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4140" id="l4140">  4140</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4141" id="l4141">  4141</a> alias_type_name
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4142" id="l4142">  4142</a>         :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4143" id="l4143">  4143</a>             type_name
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4144" id="l4144">  4144</a>             (trailing_type)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4145" id="l4145">  4145</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4146" id="l4146">  4146</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4147" id="l4147">  4147</a> visibility_redef_declaration
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4148" id="l4148">  4148</a> {String qid=&quot;&quot;;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4149" id="l4149">  4149</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4150" id="l4150">  4150</a>         qid = qualified_id
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4151" id="l4151">  4151</a>         ( EOF! { reportError(new NoViableAltException(org.netbeans.modules.cnd.apt.utils.APTUtils.EOF_TOKEN, getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4152" id="l4152">  4152</a>         | SEMICOLON!) //{end_of_stmt();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4153" id="l4153">  4153</a>         {#visibility_redef_declaration = #(#[CSM_VISIBILITY_REDEF, qid], #visibility_redef_declaration);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4154" id="l4154">  4154</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4155" id="l4155">  4155</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4156" id="l4156">  4156</a> asm_block 	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4157" id="l4157">  4157</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4158" id="l4158">  4158</a>     (
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4159" id="l4159">  4159</a>         literal_asm LCURLY (~RCURLY)*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4160" id="l4160">  4160</a>         (EOF! { reportError(new NoViableAltException(org.netbeans.modules.cnd.apt.utils.APTUtils.EOF_TOKEN, getFilename())); } |RCURLY)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4161" id="l4161">  4161</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4162" id="l4162">  4162</a>         literal_asm (literal_volatile | LITERAL_goto)? ({LA(1)==LPAREN}? balanceParens) // (gcc_asm_expr)* (EOF|RPAREN)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4163" id="l4163">  4163</a> //		{balanceBraces(CPPTokenTypes.LPAREN, CPPTokenTypes.RPAREN);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4164" id="l4164">  4164</a>     )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4165" id="l4165">  4165</a>     {#asm_block = #(#[CSM_ASM_BLOCK, &quot;CSM_ASM_BLOCK&quot;], #asm_block);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4166" id="l4166">  4166</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4167" id="l4167">  4167</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4168" id="l4168">  4168</a> static_assert_declaration
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4169" id="l4169">  4169</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4170" id="l4170">  4170</a>         LITERAL_static_assert LPAREN constant_expression COMMA (STRING_LITERAL)+ RPAREN SEMICOLON
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4171" id="l4171">  4171</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4172" id="l4172">  4172</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4173" id="l4173">  4173</a> pro_c_statement
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4174" id="l4174">  4174</a>     {String s;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4175" id="l4175">  4175</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4176" id="l4176">  4176</a>         s=literal_ident s=literal_ident
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4177" id="l4177">  4177</a>         (options {greedy=false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4178" id="l4178">  4178</a>                 balanceCurlies
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4179" id="l4179">  4179</a>             |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4180" id="l4180">  4180</a>                 balanceSquaresInExpression
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4181" id="l4181">  4181</a>             |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4182" id="l4182">  4182</a>                 balanceParensInExpression
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4183" id="l4183">  4183</a>             |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4184" id="l4184">  4184</a>                 ~(SEMICOLON | RCURLY | LCURLY | LSQUARE | LPAREN | RPAREN)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4185" id="l4185">  4185</a>             |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4186" id="l4186">  4186</a>                 (RCURLY | RPAREN)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4187" id="l4187">  4187</a>                 { reportError(new NoViableAltException(LT(0), getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4188" id="l4188">  4188</a>         )*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4189" id="l4189">  4189</a>         ( EOF! { reportError(new NoViableAltException(org.netbeans.modules.cnd.apt.utils.APTUtils.EOF_TOKEN, getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4190" id="l4190">  4190</a>         | SEMICOLON!) //{end_of_stmt();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4191" id="l4191">  4191</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4192" id="l4192">  4192</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4193" id="l4193">  4193</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4194" id="l4194">  4194</a> ///////////////////////////////////////////////////////////////////////
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4195" id="l4195">  4195</a> ///////////////////////////////////////////////////////////////////////
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4196" id="l4196">  4196</a> //////////////////////////////  EXPRESSIONS ///////////////////////////
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4197" id="l4197">  4197</a> ///////////////////////////////////////////////////////////////////////
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4198" id="l4198">  4198</a> ///////////////////////////////////////////////////////////////////////
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4199" id="l4199">  4199</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4200" id="l4200">  4200</a> expression_list
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4201" id="l4201">  4201</a> 	:	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4202" id="l4202">  4202</a>         assignment_expression (COMMA assignment_expression)*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4203" id="l4203">  4203</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4204" id="l4204">  4204</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4205" id="l4205">  4205</a> expression
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4206" id="l4206">  4206</a> 	:	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4207" id="l4207">  4207</a>         assignment_expression (COMMA assignment_expression)*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4208" id="l4208">  4208</a> 		{#expression = #(#[CSM_EXPRESSION, &quot;CSM_EXPRESSION&quot;], #expression);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4209" id="l4209">  4209</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4210" id="l4210">  4210</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4211" id="l4211">  4211</a> assignment_expression
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4212" id="l4212">  4212</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4213" id="l4213">  4213</a>         (
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4214" id="l4214">  4214</a>             // IZ#152872: parser error in VLC on cast expression
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4215" id="l4215">  4215</a>             // #191198 -  Parser error in buf.c
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4216" id="l4216">  4216</a>             (cast_array_initializer_head)=&gt;cast_array_initializer
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4217" id="l4217">  4217</a>             |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4218" id="l4218">  4218</a>             lazy_expression[false, false, 0]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4219" id="l4219">  4219</a>             |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4220" id="l4220">  4220</a>             throw_expression
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4221" id="l4221">  4221</a>         )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4222" id="l4222">  4222</a> 	(options {greedy=true;}:	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4223" id="l4223">  4223</a>             ( ASSIGNEQUAL              
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4224" id="l4224">  4224</a>             | TIMESEQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4225" id="l4225">  4225</a>             | DIVIDEEQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4226" id="l4226">  4226</a>             | MINUSEQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4227" id="l4227">  4227</a>             | PLUSEQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4228" id="l4228">  4228</a>             | MODEQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4229" id="l4229">  4229</a>             | SHIFTLEFTEQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4230" id="l4230">  4230</a>             | SHIFTRIGHTEQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4231" id="l4231">  4231</a>             | BITWISEANDEQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4232" id="l4232">  4232</a>             | BITWISEXOREQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4233" id="l4233">  4233</a>             | BITWISEOREQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4234" id="l4234">  4234</a>             )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4235" id="l4235">  4235</a>             (assignment_expression
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4236" id="l4236">  4236</a>             | array_initializer)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4237" id="l4237">  4237</a>         )?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4238" id="l4238">  4238</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4239" id="l4239">  4239</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4240" id="l4240">  4240</a> constant_expression
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4241" id="l4241">  4241</a> 	:	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4242" id="l4242">  4242</a> 		lazy_expression[false, false, 0]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4243" id="l4243">  4243</a> 		{#constant_expression = #(#[CSM_EXPRESSION, &quot;CSM_EXPRESSION&quot;], #constant_expression);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4244" id="l4244">  4244</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4245" id="l4245">  4245</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4246" id="l4246">  4246</a> case_expression
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4247" id="l4247">  4247</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4248" id="l4248">  4248</a>         constant_expression
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4249" id="l4249">  4249</a>         {#case_expression = #(#[CSM_CASE_STATEMENT, &quot;CSM_CASE_STATEMENT&quot;], #case_expression);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4250" id="l4250">  4250</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4251" id="l4251">  4251</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4252" id="l4252">  4252</a> template_param_expression
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4253" id="l4253">  4253</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4254" id="l4254">  4254</a>         lazy_expression[true, false, 1]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4255" id="l4255">  4255</a>         {#template_param_expression = #(#[CSM_EXPRESSION, &quot;CSM_EXPRESSION&quot;], #template_param_expression);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4256" id="l4256">  4256</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4257" id="l4257">  4257</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4258" id="l4258">  4258</a> cast_expression
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4259" id="l4259">  4259</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4260" id="l4260">  4260</a>         lazy_expression[false, false, 0]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4261" id="l4261">  4261</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4262" id="l4262">  4262</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4263" id="l4263">  4263</a> // Rule for fast skiping expressions
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4264" id="l4264">  4264</a> //
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4265" id="l4265">  4265</a> // inTemplateParams - true if we parsing template parameter
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4266" id="l4266">  4266</a> // It means that we should stop on GREATERTHAN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4267" id="l4267">  4267</a> //
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4268" id="l4268">  4268</a> // searchingGreaterthen - indicates that we are searching '&gt;'
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4269" id="l4269">  4269</a> // and have no need to recognize some constructions.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4270" id="l4270">  4270</a> // (IZ 142022 : IDE hangs while parsing Boost)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4271" id="l4271">  4271</a> lazy_expression[boolean inTemplateParams, boolean searchingGreaterthen, int templateLevel]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4272" id="l4272">  4272</a> {/*TypeSpecifier*/int ts=0; String s;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4273" id="l4273">  4273</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4274" id="l4274">  4274</a>         (options {warnWhenFollowAmbig = false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4275" id="l4275">  4275</a>             (   OR 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4276" id="l4276">  4276</a>             |   AND 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4277" id="l4277">  4277</a>             |   BITWISEOR 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4278" id="l4278">  4278</a>             |   BITWISEXOR 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4279" id="l4279">  4279</a>             |   AMPERSAND 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4280" id="l4280">  4280</a>             |   NOTEQUAL 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4281" id="l4281">  4281</a>             |   EQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4282" id="l4282">  4282</a>             |   LESSTHAN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4283" id="l4283">  4283</a>             |   LESSTHANOREQUALTO
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4284" id="l4284">  4284</a>             |   GREATERTHANOREQUALTO
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4285" id="l4285">  4285</a>             |   QUESTIONMARK (expression)? COLON (assignment_expression)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4286" id="l4286">  4286</a>             |   SHIFTLEFT 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4287" id="l4287">  4287</a>             |   SHIFTRIGHT
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4288" id="l4288">  4288</a>             |   PLUS 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4289" id="l4289">  4289</a>             |   MINUS
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4290" id="l4290">  4290</a>             |   STAR 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4291" id="l4291">  4291</a>             |   DIVIDE 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4292" id="l4292">  4292</a>             |   MOD
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4293" id="l4293">  4293</a>             |   DOTMBR 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4294" id="l4294">  4294</a>             |   POINTERTOMBR
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4295" id="l4295">  4295</a>             |   PLUSPLUS
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4296" id="l4296">  4296</a>             |   MINUSMINUS
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4297" id="l4297">  4297</a>             |   DOT
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4298" id="l4298">  4298</a>             |   POINTERTO
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4299" id="l4299">  4299</a>             |   NOT    
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4300" id="l4300">  4300</a>             |   TILDE
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4301" id="l4301">  4301</a>             |   ELLIPSIS
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4302" id="l4302">  4302</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4303" id="l4303">  4303</a>             |   balanceParensInExpression 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4304" id="l4304">  4304</a>             |   balanceSquaresInExpression 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4305" id="l4305">  4305</a>                 ((lambda_expression_post_capture_predicate) =&gt; lambda_expression_post_capture)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4306" id="l4306">  4306</a>             |   constant
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4307" id="l4307">  4307</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4308" id="l4308">  4308</a>             |   LITERAL_typename
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4309" id="l4309">  4309</a>             |   LITERAL___interrupt 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4310" id="l4310">  4310</a>             |   LITERAL___extension__
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4311" id="l4311">  4311</a>             |   LITERAL_template
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4312" id="l4312">  4312</a>             |   LITERAL_new
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4313" id="l4313">  4313</a>             |   LITERAL_delete
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4314" id="l4314">  4314</a>             |   LITERAL_this
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4315" id="l4315">  4315</a>             |   literal_volatile
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4316" id="l4316">  4316</a>             |   literal_const
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4317" id="l4317">  4317</a>             |   LITERAL__TYPE_QUALIFIER__
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4318" id="l4318">  4318</a>             |   literal_cdecl 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4319" id="l4319">  4319</a>             |   literal_near
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4320" id="l4320">  4320</a>             |   literal_far 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4321" id="l4321">  4321</a>             |   literal_pascal 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4322" id="l4322">  4322</a>             |   literal_stdcall
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4323" id="l4323">  4323</a>             |   literal_clrcall
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4324" id="l4324">  4324</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4325" id="l4325">  4325</a>             |   ts=builtin_type[0] (options {greedy=true;}: balanceSquaresInExpression)* (balanceCurlies)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4326" id="l4326">  4326</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4327" id="l4327">  4327</a>             |   lazy_type_decltype[templateLevel] {ts = tsTYPEID;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4328" id="l4328">  4328</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4329" id="l4329">  4329</a>             |   LITERAL_struct
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4330" id="l4330">  4330</a>             |   LITERAL_union
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4331" id="l4331">  4331</a>             |   LITERAL_class
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4332" id="l4332">  4332</a>             |   LITERAL_enum
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4333" id="l4333">  4333</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4334" id="l4334">  4334</a>             |   LITERAL_sizeof
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4335" id="l4335">  4335</a>             |   LITERAL___real
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4336" id="l4336">  4336</a>             |   LITERAL___imag
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4337" id="l4337">  4337</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4338" id="l4338">  4338</a>             |   LITERAL_alignof
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4339" id="l4339">  4339</a>             |   LITERAL___alignof
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4340" id="l4340">  4340</a>             |   LITERAL___alignof__
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4341" id="l4341">  4341</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4342" id="l4342">  4342</a>             |   trait_type_literals
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4343" id="l4343">  4343</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4344" id="l4344">  4344</a>             |   LITERAL_auto
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4345" id="l4345">  4345</a>             |   LITERAL_override
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4346" id="l4346">  4346</a>             |   LITERAL_constexpr
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4347" id="l4347">  4347</a>             |   LITERAL_thread_local
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4348" id="l4348">  4348</a>             |   LITERAL_static_assert
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4349" id="l4349">  4349</a>             |   LITERAL_alignas
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4350" id="l4350">  4350</a>             |   LITERAL_noexcept
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4351" id="l4351">  4351</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4352" id="l4352">  4352</a>             |   LITERAL_OPERATOR 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4353" id="l4353">  4353</a>                 (options {warnWhenFollowAmbig = false;}: 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4354" id="l4354">  4354</a>                         optor_simple_tokclass
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4355" id="l4355">  4355</a>                     |   
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4356" id="l4356">  4356</a>                         (literal_volatile|literal_const|LITERAL__TYPE_QUALIFIER__)*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4357" id="l4357">  4357</a>                         (LITERAL_struct | LITERAL_union | LITERAL_class | LITERAL_enum)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4358" id="l4358">  4358</a>                         (options {warnWhenFollowAmbig = false;}: LITERAL_template | s=literal_ident | balanceLessthanGreaterthanInExpression[templateLevel] | SCOPE)+
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4359" id="l4359">  4359</a>                         (options {warnWhenFollowAmbig = false;}: lazy_base_close)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4360" id="l4360">  4360</a>                     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4361" id="l4361">  4361</a>                         // empty
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4362" id="l4362">  4362</a>                 )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4363" id="l4363">  4363</a>             |   (LITERAL_dynamic_cast | LITERAL_static_cast | LITERAL_reinterpret_cast | LITERAL_const_cast)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4364" id="l4364">  4364</a>                 balanceLessthanGreaterthanInExpression[templateLevel]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4365" id="l4365">  4365</a>             |   {(!inTemplateParams &amp;&amp; !searchingGreaterthen)}? (literal_ident balanceLessthanGreaterthanInExpression[templateLevel]) =&gt; s=literal_ident balanceLessthanGreaterthanInExpression[templateLevel] (balanceCurlies)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4366" id="l4366">  4366</a>             |   {(inTemplateParams &amp;&amp; !searchingGreaterthen)}? (literal_ident balanceLessthanGreaterthanInExpression[templateLevel] isGreaterthanInTheRestOfExpression[templateLevel]) =&gt; s=literal_ident balanceLessthanGreaterthanInExpression[templateLevel] (balanceCurlies)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4367" id="l4367">  4367</a>             |   SCOPE
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4368" id="l4368">  4368</a>             |   s=literal_ident /*{action.id(id);}*/ (options {greedy=true;}: balanceSquaresInExpression)* (balanceCurlies)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4369" id="l4369">  4369</a>             )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4370" id="l4370">  4370</a>         )+
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4371" id="l4371">  4371</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4372" id="l4372">  4372</a>         ({(!inTemplateParams)}?((GREATERTHAN lazy_expression_predicate) =&gt; (GREATERTHAN)+ lazy_expression[false, false, templateLevel])?)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4373" id="l4373">  4373</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4374" id="l4374">  4374</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4375" id="l4375">  4375</a> lambda_expression_post_capture_predicate
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4376" id="l4376">  4376</a>     : 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4377" id="l4377">  4377</a>         (balanceParensInExpression)? 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4378" id="l4378">  4378</a>         (LITERAL_mutable)? 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4379" id="l4379">  4379</a>         (exception_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4380" id="l4380">  4380</a>         (function_attribute_specification)? 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4381" id="l4381">  4381</a>         (trailing_type)? 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4382" id="l4382">  4382</a>         LCURLY
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4383" id="l4383">  4383</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4384" id="l4384">  4384</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4385" id="l4385">  4385</a> lambda_expression_post_capture
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4386" id="l4386">  4386</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4387" id="l4387">  4387</a>         (
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4388" id="l4388">  4388</a>             // Lambda function
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4389" id="l4389">  4389</a>             (LPAREN (parameter_list[false])? RPAREN)? 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4390" id="l4390">  4390</a>             (LITERAL_mutable)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4391" id="l4391">  4391</a>             (exception_specification)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4392" id="l4392">  4392</a>             (function_attribute_specification)? 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4393" id="l4393">  4393</a>             (trailing_type)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4394" id="l4394">  4394</a>             compound_statement
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4395" id="l4395">  4395</a>             {#lambda_expression_post_capture = #(#[CSM_FUNCTION_DEFINITION, &quot;CSM_FUNCTION_DEFINITION&quot;], #lambda_expression_post_capture);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4396" id="l4396">  4396</a>         )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4397" id="l4397">  4397</a>         {#lambda_expression_post_capture = #(#[CSM_DECLARATION_STATEMENT, &quot;CSM_DECLARATION_STATEMENT&quot;], #lambda_expression_post_capture);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4398" id="l4398">  4398</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4399" id="l4399">  4399</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4400" id="l4400">  4400</a> // Lazy expression including assignement expressions (like a = b = c;)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4401" id="l4401">  4401</a> protected 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4402" id="l4402">  4402</a> lazy_assignment_expression[boolean inTemplateParams, boolean searchingGreaterthen, int templateLevel]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4403" id="l4403">  4403</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4404" id="l4404">  4404</a>         lazy_expression[inTemplateParams, searchingGreaterthen, templateLevel]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4405" id="l4405">  4405</a>         (options {greedy=true;}:	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4406" id="l4406">  4406</a>             ( ASSIGNEQUAL              
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4407" id="l4407">  4407</a>             | TIMESEQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4408" id="l4408">  4408</a>             | DIVIDEEQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4409" id="l4409">  4409</a>             | MINUSEQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4410" id="l4410">  4410</a>             | PLUSEQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4411" id="l4411">  4411</a>             | MODEQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4412" id="l4412">  4412</a>             | SHIFTLEFTEQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4413" id="l4413">  4413</a>             | SHIFTRIGHTEQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4414" id="l4414">  4414</a>             | BITWISEANDEQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4415" id="l4415">  4415</a>             | BITWISEXOREQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4416" id="l4416">  4416</a>             | BITWISEOREQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4417" id="l4417">  4417</a>             )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4418" id="l4418">  4418</a>             (lazy_expression[inTemplateParams, searchingGreaterthen, templateLevel]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4419" id="l4419">  4419</a>             | array_initializer)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4420" id="l4420">  4420</a>         )*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4421" id="l4421">  4421</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4422" id="l4422">  4422</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4423" id="l4423">  4423</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4424" id="l4424">  4424</a> isGreaterthanInTheRestOfExpression[int templateLevel]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4425" id="l4425">  4425</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4426" id="l4426">  4426</a>         (lazy_assignment_expression[true, true, templateLevel])?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4427" id="l4427">  4427</a>         (   COMMA 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4428" id="l4428">  4428</a>             lazy_assignment_expression[true, true, templateLevel]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4429" id="l4429">  4429</a>         )*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4430" id="l4430">  4430</a>         GREATERTHAN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4431" id="l4431">  4431</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4432" id="l4432">  4432</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4433" id="l4433">  4433</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4434" id="l4434">  4434</a> balanceParensInExpression
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4435" id="l4435">  4435</a> {/*TypeSpecifier*/int ts=0; String s;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4436" id="l4436">  4436</a>         : 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4437" id="l4437">  4437</a>             LPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4438" id="l4438">  4438</a>             (options {greedy=false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4439" id="l4439">  4439</a>                     (literal_ident)=&gt; s=literal_ident (options {greedy=true;}: balanceSquaresInExpression)*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4440" id="l4440">  4440</a>                 |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4441" id="l4441">  4441</a>                     (builtin_type[0])=&gt; ts=builtin_type[0] (options {greedy=true;}: balanceSquaresInExpression)*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4442" id="l4442">  4442</a>                 |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4443" id="l4443">  4443</a>                     balanceCurlies
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4444" id="l4444">  4444</a>                 |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4445" id="l4445">  4445</a>                     balanceParensInExpression
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4446" id="l4446">  4446</a>                 |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4447" id="l4447">  4447</a>                     balanceSquaresInExpression
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4448" id="l4448">  4448</a>                     ((lambda_expression_post_capture_predicate) =&gt; lambda_expression_post_capture)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4449" id="l4449">  4449</a>                 |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4450" id="l4450">  4450</a>                     ~(SEMICOLON | RCURLY | LCURLY | LPAREN | LSQUARE | RSQUARE)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4451" id="l4451">  4451</a>                 |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4452" id="l4452">  4452</a>                     (RCURLY | RSQUARE)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4453" id="l4453">  4453</a>                     { reportError(new NoViableAltException(LT(0), getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4454" id="l4454">  4454</a>             )*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4455" id="l4455">  4455</a>             RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4456" id="l4456">  4456</a>         ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4457" id="l4457">  4457</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4458" id="l4458">  4458</a> protected    
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4459" id="l4459">  4459</a> balanceSquaresInExpression
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4460" id="l4460">  4460</a> {/*TypeSpecifier*/int ts=0; String s;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4461" id="l4461">  4461</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4462" id="l4462">  4462</a>         LSQUARE 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4463" id="l4463">  4463</a>             (options {greedy=false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4464" id="l4464">  4464</a>                     (literal_ident)=&gt; s=literal_ident (options {greedy=true;}: balanceSquaresInExpression)*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4465" id="l4465">  4465</a>                 |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4466" id="l4466">  4466</a>                     (builtin_type[0])=&gt; ts=builtin_type[0] (options {greedy=true;}: balanceSquaresInExpression)*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4467" id="l4467">  4467</a>                 |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4468" id="l4468">  4468</a>                     balanceCurlies
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4469" id="l4469">  4469</a>                 |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4470" id="l4470">  4470</a>                     balanceSquaresInExpression
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4471" id="l4471">  4471</a>                     ((lambda_expression_post_capture_predicate) =&gt; lambda_expression_post_capture)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4472" id="l4472">  4472</a>                 |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4473" id="l4473">  4473</a>                     balanceParensInExpression
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4474" id="l4474">  4474</a>                 |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4475" id="l4475">  4475</a>                     ~(SEMICOLON | RCURLY | LCURLY | LSQUARE | LPAREN | RPAREN)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4476" id="l4476">  4476</a>                 |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4477" id="l4477">  4477</a>                     (RCURLY | RPAREN)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4478" id="l4478">  4478</a>                     { reportError(new NoViableAltException(LT(0), getFilename())); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4479" id="l4479">  4479</a>             )*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4480" id="l4480">  4480</a>         RSQUARE
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4481" id="l4481">  4481</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4482" id="l4482">  4482</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4483" id="l4483">  4483</a> protected    
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4484" id="l4484">  4484</a> balanceLessthanGreaterthanInExpression[int templateLevel]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4485" id="l4485">  4485</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4486" id="l4486">  4486</a>         {(isTemplateTooDeep(templateLevel, 10))}? lazy_template
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4487" id="l4487">  4487</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4488" id="l4488">  4488</a>         // IZ 167547 : 100% CPU core usage with C++ project.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4489" id="l4489">  4489</a>         // This is check for too complicated tecmplates.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4490" id="l4490">  4490</a>         // If template depth is more then 20 we just skip it.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4491" id="l4491">  4491</a>         (templateDepthChecker[20]) =&gt; templateDepthChecker[20]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4492" id="l4492">  4492</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4493" id="l4493">  4493</a>         // IZ 140991 : Parser &quot;hangs&quot; on Loki.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4494" id="l4494">  4494</a>         // This is predicate for fast T&lt;T&lt;...&gt;&gt; pattern recognition.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4495" id="l4495">  4495</a>         (simpleBalanceLessthanGreaterthanInExpression)=&gt; simpleBalanceLessthanGreaterthanInExpression
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4496" id="l4496">  4496</a>     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4497" id="l4497">  4497</a>         LESSTHAN
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4498" id="l4498">  4498</a>         (lazy_expression[true, false, templateLevel + 1])?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4499" id="l4499">  4499</a>         (   COMMA
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4500" id="l4500">  4500</a>             lazy_expression[true, false, templateLevel + 1]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4501" id="l4501">  4501</a>         )*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4502" id="l4502">  4502</a>         GREATERTHAN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4503" id="l4503">  4503</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4504" id="l4504">  4504</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4505" id="l4505">  4505</a> simpleBalanceLessthanGreaterthanInExpression
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4506" id="l4506">  4506</a>     {String s;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4507" id="l4507">  4507</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4508" id="l4508">  4508</a>         LESSTHAN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4509" id="l4509">  4509</a>         (   (SCOPE)? (s=literal_ident SCOPE)* s=literal_ident (simpleBalanceLessthanGreaterthanInExpression)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4510" id="l4510">  4510</a>         |   constant
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4511" id="l4511">  4511</a>         )?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4512" id="l4512">  4512</a>         (   COMMA 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4513" id="l4513">  4513</a>             (   (SCOPE)? (s=literal_ident SCOPE)* s=literal_ident (simpleBalanceLessthanGreaterthanInExpression)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4514" id="l4514">  4514</a>             |   constant
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4515" id="l4515">  4515</a>             )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4516" id="l4516">  4516</a>         )*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4517" id="l4517">  4517</a>         GREATERTHAN
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4518" id="l4518">  4518</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4519" id="l4519">  4519</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4520" id="l4520">  4520</a> lazy_expression_predicate
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4521" id="l4521">  4521</a> {int ts = 0; String s;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4522" id="l4522">  4522</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4523" id="l4523">  4523</a>         OR 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4524" id="l4524">  4524</a>     |   AND 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4525" id="l4525">  4525</a>     |   BITWISEOR 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4526" id="l4526">  4526</a>     |   BITWISEXOR 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4527" id="l4527">  4527</a>     |   AMPERSAND 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4528" id="l4528">  4528</a>     |   NOTEQUAL 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4529" id="l4529">  4529</a>     |   EQUAL
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4530" id="l4530">  4530</a>     |   LESSTHAN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4531" id="l4531">  4531</a>     |   LESSTHANOREQUALTO
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4532" id="l4532">  4532</a>     |   GREATERTHANOREQUALTO
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4533" id="l4533">  4533</a>     |   QUESTIONMARK (expression) COLON (assignment_expression)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4534" id="l4534">  4534</a>     |   SHIFTLEFT 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4535" id="l4535">  4535</a>     |   SHIFTRIGHT
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4536" id="l4536">  4536</a>     |   PLUS 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4537" id="l4537">  4537</a>     |   MINUS
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4538" id="l4538">  4538</a>     |   STAR 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4539" id="l4539">  4539</a>     |   DIVIDE 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4540" id="l4540">  4540</a>     |   MOD
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4541" id="l4541">  4541</a>     |   DOTMBR 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4542" id="l4542">  4542</a>     |   POINTERTOMBR
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4543" id="l4543">  4543</a>     |   SCOPE
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4544" id="l4544">  4544</a>     |   PLUSPLUS
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4545" id="l4545">  4545</a>     |   MINUSMINUS
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4546" id="l4546">  4546</a>     |   DOT
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4547" id="l4547">  4547</a>     |   POINTERTO
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4548" id="l4548">  4548</a>     |   NOT    
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4549" id="l4549">  4549</a>     |   TILDE
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4550" id="l4550">  4550</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4551" id="l4551">  4551</a>     |   LPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4552" id="l4552">  4552</a>     |   LSQUARE
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4553" id="l4553">  4553</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4554" id="l4554">  4554</a>     |   s=literal_ident
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4555" id="l4555">  4555</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4556" id="l4556">  4556</a>     |   constant
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4557" id="l4557">  4557</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4558" id="l4558">  4558</a>     |   LITERAL___interrupt 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4559" id="l4559">  4559</a>     |   LITERAL___extension__
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4560" id="l4560">  4560</a>     |   LITERAL_template
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4561" id="l4561">  4561</a>     |   LITERAL_new
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4562" id="l4562">  4562</a>     |   LITERAL_delete
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4563" id="l4563">  4563</a>     |   LITERAL_this
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4564" id="l4564">  4564</a>     |   literal_volatile
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4565" id="l4565">  4565</a>     |   literal_const
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4566" id="l4566">  4566</a>     |   LITERAL__TYPE_QUALIFIER__
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4567" id="l4567">  4567</a>     |   literal_cdecl 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4568" id="l4568">  4568</a>     |   literal_near
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4569" id="l4569">  4569</a>     |   literal_far 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4570" id="l4570">  4570</a>     |   literal_pascal 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4571" id="l4571">  4571</a>     |   literal_stdcall
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4572" id="l4572">  4572</a>     |   literal_clrcall
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4573" id="l4573">  4573</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4574" id="l4574">  4574</a>     |   ts = builtin_type[0]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4575" id="l4575">  4575</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4576" id="l4576">  4576</a>     |   LITERAL_OPERATOR 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4577" id="l4577">  4577</a>     |   LITERAL_dynamic_cast 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4578" id="l4578">  4578</a>     |   LITERAL_static_cast 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4579" id="l4579">  4579</a>     |   LITERAL_reinterpret_cast 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4580" id="l4580">  4580</a>     |   LITERAL_const_cast
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4581" id="l4581">  4581</a>     |   LITERAL_sizeof
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4582" id="l4582">  4582</a>     |   LITERAL___real
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4583" id="l4583">  4583</a>     |   LITERAL___imag
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4584" id="l4584">  4584</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4585" id="l4585">  4585</a>     |   LITERAL_alignof
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4586" id="l4586">  4586</a>     |   LITERAL___alignof
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4587" id="l4587">  4587</a>     |   LITERAL___alignof__
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4588" id="l4588">  4588</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4589" id="l4589">  4589</a>     |   trait_type_literals
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4590" id="l4590">  4590</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4591" id="l4591">  4591</a>     |   LITERAL_auto
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4592" id="l4592">  4592</a>     |   LITERAL_override
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4593" id="l4593">  4593</a>     |   LITERAL_constexpr
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4594" id="l4594">  4594</a>     |   LITERAL_thread_local
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4595" id="l4595">  4595</a>     |   LITERAL_static_assert
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4596" id="l4596">  4596</a>     |   LITERAL_alignas
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4597" id="l4597">  4597</a>     |   LITERAL_noexcept
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4598" id="l4598">  4598</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4599" id="l4599">  4599</a>     |   GREATERTHAN lazy_expression_predicate
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4600" id="l4600">  4600</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4601" id="l4601">  4601</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4602" id="l4602">  4602</a> lazy_base_close
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4603" id="l4603">  4603</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4604" id="l4604">  4604</a>         (COLON)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4605" id="l4605">  4605</a>         (options {greedy=false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4606" id="l4606">  4606</a>             .
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4607" id="l4607">  4607</a>         )*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4608" id="l4608">  4608</a>         balanceCurlies
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4609" id="l4609">  4609</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4610" id="l4610">  4610</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4611" id="l4611">  4611</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4612" id="l4612">  4612</a> trait_type_literals
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4613" id="l4613">  4613</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4614" id="l4614">  4614</a>         LITERAL___is_pod | LITERAL___has_nothrow_assign | LITERAL___has_nothrow_copy | LITERAL___has_nothrow_constructor |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4615" id="l4615">  4615</a>         LITERAL___has_trivial_assign | LITERAL___has_trivial_copy | LITERAL___has_trivial_destructor | LITERAL___has_virtual_destructor |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4616" id="l4616">  4616</a>         LITERAL___is_abstract | LITERAL___is_empty | LITERAL___is_literal_type | LITERAL___is_polymorphic |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4617" id="l4617">  4617</a>         LITERAL___is_standard_layout | LITERAL___is_trivial | LITERAL___is_union | LITERAL___underlying_type | 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4618" id="l4618">  4618</a>         LITERAL___is_class | LITERAL___is_base_of | LITERAL___has_trivial_constructor
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4619" id="l4619">  4619</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4620" id="l4620">  4620</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4621" id="l4621">  4621</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4622" id="l4622">  4622</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4623" id="l4623">  4623</a> postfix_cv_qualifier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4624" id="l4624">  4624</a>         :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4625" id="l4625">  4625</a>             ((literal_volatile|literal_const|LITERAL__TYPE_QUALIFIER__) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4626" id="l4626">  4626</a>                 (options {greedy=true;}:unnamed_ptr_operator
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4627" id="l4627">  4627</a>                  { #postfix_cv_qualifier=#(#[CSM_PTR_OPERATOR,&quot;CSM_PTR_OPERATOR&quot;], #postfix_cv_qualifier);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4628" id="l4628">  4628</a>                 )*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4629" id="l4629">  4629</a>             )+
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4630" id="l4630">  4630</a>         ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4631" id="l4631">  4631</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4632" id="l4632">  4632</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4633" id="l4633">  4633</a> unnamed_ptr_operator
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4634" id="l4634">  4634</a> 	:	(	AMPERSAND 	{is_address = true;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4635" id="l4635">  4635</a>                 |       AND {is_address = true;} // r-value reference
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4636" id="l4636">  4636</a> 		|	literal_cdecl 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4637" id="l4637">  4637</a> 		|	literal_near
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4638" id="l4638">  4638</a> 		|	literal_far 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4639" id="l4639">  4639</a> 		|	LITERAL___interrupt 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4640" id="l4640">  4640</a> 		|	literal_pascal 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4641" id="l4641">  4641</a> 		|	literal_stdcall
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4642" id="l4642">  4642</a>                 |       literal_clrcall
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4643" id="l4643">  4643</a> 		|	STAR 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4644" id="l4644">  4644</a> 		)	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4645" id="l4645">  4645</a>    ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4646" id="l4646">  4646</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4647" id="l4647">  4647</a> ptr_operator
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4648" id="l4648">  4648</a> 	:	(	AMPERSAND 	{is_address = true;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4649" id="l4649">  4649</a>                 |       AND {is_address = true;} // r-value reference
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4650" id="l4650">  4650</a> 		|	literal_cdecl 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4651" id="l4651">  4651</a> 		|	literal_near
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4652" id="l4652">  4652</a> 		|	literal_far 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4653" id="l4653">  4653</a> 		|	LITERAL___interrupt 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4654" id="l4654">  4654</a> 		|	literal_pascal 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4655" id="l4655">  4655</a> 		|	literal_stdcall
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4656" id="l4656">  4656</a>                 |       literal_clrcall
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4657" id="l4657">  4657</a> 		|	ptr_to_member	// e.g. STAR 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4658" id="l4658">  4658</a> 		)	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4659" id="l4659">  4659</a> 		{#ptr_operator=#(#[CSM_PTR_OPERATOR,&quot;CSM_PTR_OPERATOR&quot;], #ptr_operator);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4660" id="l4660">  4660</a>    ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4661" id="l4661">  4661</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4662" id="l4662">  4662</a> // Match A::B::*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4663" id="l4663">  4663</a> ptr_to_member
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4664" id="l4664">  4664</a> 	{String s;}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4665" id="l4665">  4665</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4666" id="l4666">  4666</a> 		s = scope_override STAR  {is_pointer = true;} cv_qualifier_seq
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4667" id="l4667">  4667</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4668" id="l4668">  4668</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4669" id="l4669">  4669</a> // Match the A::B::C:: or nothing
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4670" id="l4670">  4670</a> scope_override returns [String s = &quot;&quot;]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4671" id="l4671">  4671</a>     { 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4672" id="l4672">  4672</a>         StringBuilder sitem = new StringBuilder(); 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4673" id="l4673">  4673</a>         String sp = &quot;&quot;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4674" id="l4674">  4674</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4675" id="l4675">  4675</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4676" id="l4676">  4676</a>     	(
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4677" id="l4677">  4677</a>             SCOPE { sitem.append(&quot;::&quot;);} 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4678" id="l4678">  4678</a>             (LITERAL_template)? // to support &quot;_Alloc::template rebind&lt;char&gt;::other&quot;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4679" id="l4679">  4679</a>         )?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4680" id="l4680">  4680</a>         (
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4681" id="l4681">  4681</a>             (
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4682" id="l4682">  4682</a>                 (
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4683" id="l4683">  4683</a>                         (literal_ident (LESSTHAN (lazy_template_argument_list)? GREATERTHAN)?) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4684" id="l4684">  4684</a>                     |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4685" id="l4685">  4685</a>                         lazy_type_decltype[0]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4686" id="l4686">  4686</a>                 )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4687" id="l4687">  4687</a>                 SCOPE                        
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4688" id="l4688">  4688</a>             ) =&gt; sp = scope_override_part[0]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4689" id="l4689">  4689</a>         )?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4690" id="l4690">  4690</a>         {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4691" id="l4691">  4691</a>             sitem.append(sp);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4692" id="l4692">  4692</a>             s = sitem.toString();
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4693" id="l4693">  4693</a>         }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4694" id="l4694">  4694</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4695" id="l4695">  4695</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4696" id="l4696">  4696</a> scope_override_part[int level] returns [String s = &quot;&quot;]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4697" id="l4697">  4697</a>     { 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4698" id="l4698">  4698</a>         StringBuilder sitem = new StringBuilder(); 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4699" id="l4699">  4699</a>         String sp = &quot;&quot;;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4700" id="l4700">  4700</a>         String id;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4701" id="l4701">  4701</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4702" id="l4702">  4702</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4703" id="l4703">  4703</a>         (
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4704" id="l4704">  4704</a>                 (
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4705" id="l4705">  4705</a>                     id = literal_ident (LESSTHAN template_argument_list GREATERTHAN)? SCOPE
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4706" id="l4706">  4706</a>                     {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4707" id="l4707">  4707</a>                         sitem.append(id);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4708" id="l4708">  4708</a>                         sitem.append(&quot;::&quot;);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4709" id="l4709">  4709</a>                     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4710" id="l4710">  4710</a>                 )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4711" id="l4711">  4711</a>             |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4712" id="l4712">  4712</a>                 (
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4713" id="l4713">  4713</a>                     type_decltype SCOPE
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4714" id="l4714">  4714</a>                     {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4715" id="l4715">  4715</a>                         sitem.append(&quot;decltype&quot;);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4716" id="l4716">  4716</a>                         sitem.append(&quot;::&quot;);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4717" id="l4717">  4717</a>                     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4718" id="l4718">  4718</a>                 )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4719" id="l4719">  4719</a>         )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4720" id="l4720">  4720</a>         (LITERAL_template)? // to support &quot;_Alloc::template rebind&lt;char&gt;::other&quot;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4721" id="l4721">  4721</a>         (
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4722" id="l4722">  4722</a>             (
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4723" id="l4723">  4723</a>                 (
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4724" id="l4724">  4724</a>                         (literal_ident (LESSTHAN (lazy_template_argument_list)? GREATERTHAN)?) 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4725" id="l4725">  4725</a>                     |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4726" id="l4726">  4726</a>                         lazy_type_decltype[0]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4727" id="l4727">  4727</a>                 )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4728" id="l4728">  4728</a>                 SCOPE                        
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4729" id="l4729">  4729</a>             ) =&gt; sp = scope_override_part[level + 1]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4730" id="l4730">  4730</a>         )?   
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4731" id="l4731">  4731</a>         {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4732" id="l4732">  4732</a>             sitem.append(sp);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4733" id="l4733">  4733</a>             s = sitem.toString();
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4734" id="l4734">  4734</a>         }        
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4735" id="l4735">  4735</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4736" id="l4736">  4736</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4737" id="l4737">  4737</a> // lazy_type_decltype skips expression and 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4738" id="l4738">  4738</a> // works faster then type_decltype.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4739" id="l4739">  4739</a> lazy_type_decltype[int templateLevel]
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4740" id="l4740">  4740</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4741" id="l4741">  4741</a>         literal_decltype 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4742" id="l4742">  4742</a>         LPAREN 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4743" id="l4743">  4743</a>         lazy_assignment_expression[false, false, templateLevel] 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4744" id="l4744">  4744</a>         RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4745" id="l4745">  4745</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4746" id="l4746">  4746</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4747" id="l4747">  4747</a> decltype_expression
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4748" id="l4748">  4748</a>         :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4749" id="l4749">  4749</a>         LPAREN expression_list RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4750" id="l4750">  4750</a>         {#decltype_expression = #(#[CSM_EXPRESSION, &quot;CSM_EXPRESSION&quot;], #decltype_expression);}        
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4751" id="l4751">  4751</a>         ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4752" id="l4752">  4752</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4753" id="l4753">  4753</a> type_decltype 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4754" id="l4754">  4754</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4755" id="l4755">  4755</a>         literal_decltype decltype_expression
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4756" id="l4756">  4756</a>         {#type_decltype=#(#[CSM_TYPE_DECLTYPE,&quot;CSM_TYPE_DECLTYPE&quot;], #type_decltype);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4757" id="l4757">  4757</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4758" id="l4758">  4758</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4759" id="l4759">  4759</a> constant
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4760" id="l4760">  4760</a> :       OCTALINT
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4761" id="l4761">  4761</a>     |   DECIMALINT
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4762" id="l4762">  4762</a>     |   HEXADECIMALINT
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4763" id="l4763">  4763</a>     |   BINARYINT
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4764" id="l4764">  4764</a>     |   CHAR_LITERAL
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4765" id="l4765">  4765</a>     |   (options {warnWhenFollowAmbig = false;}: STRING_LITERAL)+
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4766" id="l4766">  4766</a>     |   FLOATONE
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4767" id="l4767">  4767</a>     |   FLOATTWO
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4768" id="l4768">  4768</a>     |   LITERAL_true
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4769" id="l4769">  4769</a>     |   LITERAL_false
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4770" id="l4770">  4770</a>     |   LITERAL_nullptr
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4771" id="l4771">  4771</a>     |   LITERAL___null
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4772" id="l4772">  4772</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4773" id="l4773">  4773</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4774" id="l4774">  4774</a> optor 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4775" id="l4775">  4775</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4776" id="l4776">  4776</a> 		LITERAL_new
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4777" id="l4777">  4777</a> 		(options {warnWhenFollowAmbig = false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4778" id="l4778">  4778</a> 			LSQUARE RSQUARE | )		// check syntax
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4779" id="l4779">  4779</a> 	|   
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4780" id="l4780">  4780</a> 		LITERAL_delete
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4781" id="l4781">  4781</a> 		(options {warnWhenFollowAmbig = false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4782" id="l4782">  4782</a> 			LSQUARE RSQUARE | )		// check syntax
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4783" id="l4783">  4783</a> 	|	LPAREN RPAREN
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4784" id="l4784">  4784</a> 	|	LSQUARE RSQUARE
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4785" id="l4785">  4785</a> 	|	optor_simple_tokclass	//OPTOR_SIMPLE_TOKCLASS
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4786" id="l4786">  4786</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4787" id="l4787">  4787</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4788" id="l4788">  4788</a> //Zuo 5/11/2001
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4789" id="l4789">  4789</a> // This is the equivalent to &quot;#tokclass OPTOR_SIMPLE_TOKCLASS&quot; in cplusplus.g
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4790" id="l4790">  4790</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4791" id="l4791">  4791</a> optor_simple_tokclass
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4792" id="l4792">  4792</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4793" id="l4793">  4793</a>     (PLUS|MINUS|STAR|DIVIDE|MOD|BITWISEXOR|AMPERSAND|BITWISEOR|TILDE|NOT|
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4794" id="l4794">  4794</a> 	 SHIFTLEFT|SHIFTRIGHT|
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4795" id="l4795">  4795</a> 	 ASSIGNEQUAL|TIMESEQUAL|DIVIDEEQUAL|MODEQUAL|PLUSEQUAL|MINUSEQUAL|
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4796" id="l4796">  4796</a> 	 SHIFTLEFTEQUAL|SHIFTRIGHTEQUAL|BITWISEANDEQUAL|BITWISEXOREQUAL|BITWISEOREQUAL|
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4797" id="l4797">  4797</a>          EQUAL|NOTEQUAL|LESSTHAN|GREATERTHAN (options {greedy=true;}: GREATERTHAN)?|LESSTHANOREQUALTO|GREATERTHANOREQUALTO|OR|AND|
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4798" id="l4798">  4798</a> 	 PLUSPLUS|MINUSMINUS|COMMA|POINTERTO|POINTERTOMBR         
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4799" id="l4799">  4799</a> 	)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4800" id="l4800">  4800</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4801" id="l4801">  4801</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4802" id="l4802">  4802</a> /*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4803" id="l4803">  4803</a> // VV: some rules extracted from prev. optor_simple_tokclass, 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4804" id="l4804">  4804</a> // by excluding tokens with several meaning, end grouping other with the same behavior
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4805" id="l4805">  4805</a> // i.e STAR could be multiply in expression, but could be dereference pointer,
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4806" id="l4806">  4806</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4807" id="l4807">  4807</a> //Zuo 5/11/2001
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4808" id="l4808">  4808</a> // This is the equivalent to &quot;#tokclass OPTOR_SIMPLE_TOKCLASS&quot; in cplusplus.g
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4809" id="l4809">  4809</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4810" id="l4810">  4810</a> optor_simple_tokclass
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4811" id="l4811">  4811</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4812" id="l4812">  4812</a>             expression_unambig_optor
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4813" id="l4813">  4813</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4814" id="l4814">  4814</a>             assign_unambig_optor
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4815" id="l4815">  4815</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4816" id="l4816">  4816</a>             post_cast_unambig_unary_optor
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4817" id="l4817">  4817</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4818" id="l4818">  4818</a>             // ambiguous operators
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4819" id="l4819">  4819</a>             (AMPERSAND | STAR | PLUS | MINUS | PLUSPLUS | MINUSMINUS)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4820" id="l4820">  4820</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4821" id="l4821">  4821</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4822" id="l4822">  4822</a> // this rule garantees, that on left is not casting for expressions like &quot;(A) optor expr&quot;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4823" id="l4823">  4823</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4824" id="l4824">  4824</a> expression_unambig_optor
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4825" id="l4825">  4825</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4826" id="l4826">  4826</a>         (DIVIDE|MOD|BITWISEXOR|BITWISEOR|
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4827" id="l4827">  4827</a> 	 SHIFTLEFT|SHIFTRIGHT|
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4828" id="l4828">  4828</a> 	 EQUAL|NOTEQUAL|LESSTHAN|GREATERTHAN|LESSTHANOREQUALTO|GREATERTHANOREQUALTO|OR|AND|
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4829" id="l4829">  4829</a> 	 COMMA|POINTERTO|POINTERTOMBR
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4830" id="l4830">  4830</a> 	)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4831" id="l4831">  4831</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4832" id="l4832">  4832</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4833" id="l4833">  4833</a> // this rule garantees, that on left is not casting for expressions like &quot;(A) optor expr&quot; 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4834" id="l4834">  4834</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4835" id="l4835">  4835</a> assign_unambig_optor
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4836" id="l4836">  4836</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4837" id="l4837">  4837</a>         (
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4838" id="l4838">  4838</a> 	 ASSIGNEQUAL|TIMESEQUAL|DIVIDEEQUAL|MODEQUAL|PLUSEQUAL|MINUSEQUAL|
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4839" id="l4839">  4839</a> 	 SHIFTLEFTEQUAL|SHIFTRIGHTEQUAL|BITWISEANDEQUAL|BITWISEXOREQUAL|BITWISEOREQUAL 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4840" id="l4840">  4840</a> 	)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4841" id="l4841">  4841</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4842" id="l4842">  4842</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4843" id="l4843">  4843</a> // this rule garantees, that on left is casting for expressions like &quot;(A) optor expr&quot;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4844" id="l4844">  4844</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4845" id="l4845">  4845</a> post_cast_unambig_unary_optor : (TILDE | NOT);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4846" id="l4846">  4846</a> */
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4847" id="l4847">  4847</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4848" id="l4848">  4848</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4849" id="l4849">  4849</a> // it's better to have them alphabetically ordered...
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4850" id="l4850">  4850</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4851" id="l4851">  4851</a> protected 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4852" id="l4852">  4852</a> literal_ident returns [String s = &quot;&quot;]
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4853" id="l4853">  4853</a>     : 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4854" id="l4854">  4854</a>         id:IDENT 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4855" id="l4855">  4855</a>         {s = id.getText();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4856" id="l4856">  4856</a>     | 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4857" id="l4857">  4857</a>         kwd:LITERAL_final
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4858" id="l4858">  4858</a>         {s = kwd.getText();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4859" id="l4859">  4859</a>         {#literal_ident = #[IDENT, s];}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4860" id="l4860">  4860</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4861" id="l4861">  4861</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4862" id="l4862">  4862</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4863" id="l4863">  4863</a> literal_asm : LITERAL_asm|LITERAL__asm|LITERAL___asm|LITERAL___asm__;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4864" id="l4864">  4864</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4865" id="l4865">  4865</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4866" id="l4866">  4866</a> literal_cdecl : LITERAL__cdecl|LITERAL___cdecl;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4867" id="l4867">  4867</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4868" id="l4868">  4868</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4869" id="l4869">  4869</a> literal_const : LITERAL_const|LITERAL___const|LITERAL___const__;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4870" id="l4870">  4870</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4871" id="l4871">  4871</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4872" id="l4872">  4872</a> literal_declspec : LITERAL__declspec|LITERAL___declspec;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4873" id="l4873">  4873</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4874" id="l4874">  4874</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4875" id="l4875">  4875</a> literal_far : LITERAL__far|LITERAL___far;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4876" id="l4876">  4876</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4877" id="l4877">  4877</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4878" id="l4878">  4878</a> literal_inline : LITERAL_inline | LITERAL__inline | LITERAL___inline | LITERAL___inline__ | LITERAL___forceinline;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4879" id="l4879">  4879</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4880" id="l4880">  4880</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4881" id="l4881">  4881</a> literal_int64 : LITERAL__int64|LITERAL___int64;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4882" id="l4882">  4882</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4883" id="l4883">  4883</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4884" id="l4884">  4884</a> literal_signed: LITERAL_signed|LITERAL___signed|LITERAL___signed__;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4885" id="l4885">  4885</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4886" id="l4886">  4886</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4887" id="l4887">  4887</a> literal_unsigned: LITERAL_unsigned|LITERAL___unsigned__;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4888" id="l4888">  4888</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4889" id="l4889">  4889</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4890" id="l4890">  4890</a> literal_near : LITERAL__near|LITERAL___near;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4891" id="l4891">  4891</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4892" id="l4892">  4892</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4893" id="l4893">  4893</a> literal_pascal : LITERAL_pascal|LITERAL__pascal|LITERAL___pascal;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4894" id="l4894">  4894</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4895" id="l4895">  4895</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4896" id="l4896">  4896</a> literal_stdcall : LITERAL__stdcall|LITERAL___stdcall;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4897" id="l4897">  4897</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4898" id="l4898">  4898</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4899" id="l4899">  4899</a> literal_clrcall : LITERAL___clrcall;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4900" id="l4900">  4900</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4901" id="l4901">  4901</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4902" id="l4902">  4902</a> literal_volatile : LITERAL_volatile|LITERAL___volatile|LITERAL___volatile__;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4903" id="l4903">  4903</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4904" id="l4904">  4904</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4905" id="l4905">  4905</a> literal_typeof : LITERAL_typeof | LITERAL___typeof | LITERAL___typeof__ ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4906" id="l4906">  4906</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4907" id="l4907">  4907</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4908" id="l4908">  4908</a> literal_restrict : LITERAL_restrict | LITERAL___restrict | LITERAL___restrict__;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4909" id="l4909">  4909</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4910" id="l4910">  4910</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4911" id="l4911">  4911</a> literal_complex : LITERAL__Complex | LITERAL___complex__ | LITERAL___complex;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4912" id="l4912">  4912</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4913" id="l4913">  4913</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4914" id="l4914">  4914</a> literal_attribute : LITERAL___attribute | LITERAL___attribute__;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4915" id="l4915">  4915</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4916" id="l4916">  4916</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4917" id="l4917">  4917</a> literal_try : LITERAL_try | LITERAL___try;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4918" id="l4918">  4918</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4919" id="l4919">  4919</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4920" id="l4920">  4920</a> literal_finally : LITERAL___finally;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4921" id="l4921">  4921</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4922" id="l4922">  4922</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l4923" id="l4923">  4923</a> literal_decltype : LITERAL_decltype | LITERAL___decltype;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4924" id="l4924">  4924</a> 
</pre>
</div>
</div>

<div class="page_footer">
<div class="page_footer_text">main</div>
<div class="rss_logo">
<a href="/main/rss-log">RSS</a>
<a href="/main/atom-log">Atom</a>
</div>
<br />

</div>

			</td>
			</tr><!-- end main content -->
			</table><!-- end main content table -->
			</div><!-- end fixed-contentbox-ie -->
		 <!-- end fixed-contentarea --><div id="ftr">
		<ul class="float-right" id="social-media">
			<li><a href="http://www.facebook.com/NetBeans"><img src="https://netbeans.org/images_www/v7/design/icin_facebook.png" width="30" height="30" alt="facebook"></a></li>
			<li><a href="http://www.youtube.com/user/netbeansvideos"><img src="https://netbeans.org/images_www/v7/design/icin_youtube.png" width="30" height="30" alt="youtube"></a></li>
			<li><a href="https://plus.google.com/105597468329838196909/"><img src="https://netbeans.org/images_www/v7/design/icin_google.png" width="30" height="30" alt="google+"></a></li>
			<li><a href="https://twitter.com/netbeans"><img src="https://netbeans.org/images_www/v7/design/icin_twitter.png" width="30" height="30" alt="twitter"></a></li>
		</ul>
		<ul>
			<li><a href="https://netbeans.org/sitemaps/www_map.html">SiteMap</a></li>
			<li><a href="https://netbeans.org/about/index.html">About Us</a></li>
			<li><a href="https://netbeans.org/about/contact.html">Contact</a></li>
			<li><a href="https://netbeans.org/about/legal/index.html">Legal &amp; Licences</a></li>
		</ul>

	</div>
	<div id="tof" class="align-right">
	  By use of this website, you agree to the <a href="https://netbeans.org/about/legal/terms-of-use.html">NetBeans Policies and Terms of Use</a>.
	  &copy; 2013, Oracle Corporation and/or its affiliates. Sponsored by <img src="https://netbeans.org/images_www/v7/design/logo_oracle.png" width="56" height="8" alt="Oracle logo"/>
	</div>
 </div>

</body>
</html>

