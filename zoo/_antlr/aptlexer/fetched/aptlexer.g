<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">
<head>
<link rel="icon" href="/main/static/hgicon.png" type="image/png" />
<meta name="robots" content="index, nofollow"/>
<link rel="stylesheet" href="/main/static/style-gitweb.css" type="text/css" />
<script src="https://netbeans.org/images_www/js/companion-projects.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="https://netbeans.org/netbeans3.css">

<title>main: cnd.apt/src/org/netbeans/modules/cnd/apt/impl/support/aptlexer.g@3e1bf818cd27</title>
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
<a href="/main/file/3e1bf818cd27/cnd.apt/src/org/netbeans/modules/cnd/apt/impl/support/">files</a> |
<a href="/main/rev/3e1bf818cd27">changeset</a> |
file |
<a href="/main/log/3e1bf818cd27/cnd.apt/src/org/netbeans/modules/cnd/apt/impl/support/aptlexer.g">revisions</a> |
<a href="/main/annotate/3e1bf818cd27/cnd.apt/src/org/netbeans/modules/cnd/apt/impl/support/aptlexer.g">annotate</a> |
<a href="/main/diff/3e1bf818cd27/cnd.apt/src/org/netbeans/modules/cnd/apt/impl/support/aptlexer.g">diff</a> |
<a href="/main/raw-file/3e1bf818cd27/cnd.apt/src/org/netbeans/modules/cnd/apt/impl/support/aptlexer.g">raw</a><br/>
</div>

<div class="title">cnd.apt/src/org/netbeans/modules/cnd/apt/impl/support/aptlexer.g</div>

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
<td>parent 270388</td>
<td style="font-family:monospace">
<a class="list" href="/main/file/683e37e68d25/cnd.apt/src/org/netbeans/modules/cnd/apt/impl/support/aptlexer.g">
683e37e68d25
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
<pre><a class="linenr" href="#l1" id="l1">     1</a> //
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l2" id="l2">     2</a> // DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l3" id="l3">     3</a> //
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l4" id="l4">     4</a> // Copyright 1997-2010 Oracle and/or its affiliates. All rights reserved.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l5" id="l5">     5</a> //
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l6" id="l6">     6</a> // Oracle and Java are registered trademarks of Oracle and/or its affiliates.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l7" id="l7">     7</a> // Other names may be trademarks of their respective owners.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l8" id="l8">     8</a> //
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l9" id="l9">     9</a> // The contents of this file are subject to the terms of either the GNU
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l10" id="l10">    10</a> // General Public License Version 2 only (&quot;GPL&quot;) or the Common
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l11" id="l11">    11</a> // Development and Distribution License(&quot;CDDL&quot;) (collectively, the
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l12" id="l12">    12</a> // &quot;License&quot;). You may not use this file except in compliance with the
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l13" id="l13">    13</a> // License. You can obtain a copy of the License at
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l14" id="l14">    14</a> // http://www.netbeans.org/cddl-gplv2.html
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l15" id="l15">    15</a> // or nbbuild/licenses/CDDL-GPL-2-CP. See the License for the
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l16" id="l16">    16</a> // specific language governing permissions and limitations under the
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l17" id="l17">    17</a> // License.  When distributing the software, include this License Header
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l18" id="l18">    18</a> // Notice in each file and include the License file at
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l19" id="l19">    19</a> // nbbuild/licenses/CDDL-GPL-2-CP.  Oracle designates this
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l20" id="l20">    20</a> // particular file as subject to the &quot;Classpath&quot; exception as provided
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l21" id="l21">    21</a> // by Oracle in the GPL Version 2 section of the License file that
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l22" id="l22">    22</a> // accompanied this code. If applicable, add the following below the
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l23" id="l23">    23</a> // License Header, with the fields enclosed by brackets [] replaced by
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l24" id="l24">    24</a> // your own identifying information:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l25" id="l25">    25</a> // &quot;Portions Copyrighted [year] [name of copyright owner]&quot;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l26" id="l26">    26</a> //
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l27" id="l27">    27</a> // Contributor(s):
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l28" id="l28">    28</a> //
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l29" id="l29">    29</a> // The Original Software is NetBeans. The Initial Developer of the Original
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l30" id="l30">    30</a> // Software is Sun Microsystems, Inc. Portions Copyright 1997-2007 Sun
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l31" id="l31">    31</a> // Microsystems, Inc. All Rights Reserved.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l32" id="l32">    32</a> //
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l33" id="l33">    33</a> // If you wish your version of this file to be governed by only the CDDL
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l34" id="l34">    34</a> // or only the GPL Version 2, indicate your decision by adding
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l35" id="l35">    35</a> // &quot;[Contributor] elects to include this software in this distribution
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l36" id="l36">    36</a> // under the [CDDL or GPL Version 2] license.&quot; If you do not indicate a
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l37" id="l37">    37</a> // single choice of license, a recipient has the option to distribute
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l38" id="l38">    38</a> // your version of this file under either the CDDL, the GPL Version 2 or
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l39" id="l39">    39</a> // to extend the choice of license to its licensees as provided above.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l40" id="l40">    40</a> // However, if you add GPL Version 2 code and therefore, elected the GPL
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l41" id="l41">    41</a> // Version 2 license, then the option applies only if the new code is
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l42" id="l42">    42</a> // made subject to such option by the copyright holder.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l43" id="l43">    43</a> //
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l44" id="l44">    44</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l45" id="l45">    45</a> // Start of APTLexer.cpp block
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l46" id="l46">    46</a> header {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l47" id="l47">    47</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l48" id="l48">    48</a> package org.netbeans.modules.cnd.apt.impl.support.generated;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l49" id="l49">    49</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l50" id="l50">    50</a> import org.netbeans.modules.cnd.apt.utils.APTUtils;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l51" id="l51">    51</a> import org.netbeans.modules.cnd.apt.support.APTToken;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l52" id="l52">    52</a> import org.netbeans.modules.cnd.apt.support.lang.APTLanguageSupport;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l53" id="l53">    53</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l54" id="l54">    54</a> }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l55" id="l55">    55</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l56" id="l56">    56</a> options {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l57" id="l57">    57</a> 	language = &quot;Java&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l58" id="l58">    58</a> } 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l59" id="l59">    59</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l60" id="l60">    60</a> {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l61" id="l61">    61</a> @org.netbeans.api.annotations.common.SuppressWarnings(&quot;DLS&quot;)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l62" id="l62">    62</a> @SuppressWarnings({&quot;unchecked&quot;, &quot;cast&quot;, &quot;fallthrough&quot;})
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l63" id="l63">    63</a> final /*final class attribute gives us performance */
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l64" id="l64">    64</a> }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l65" id="l65">    65</a> class APTLexer extends Lexer;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l66" id="l66">    66</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l67" id="l67">    67</a> options {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l68" id="l68">    68</a>     k = 2;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l69" id="l69">    69</a>     exportVocab = APTGenerated;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l70" id="l70">    70</a>     testLiterals = false;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l71" id="l71">    71</a>     charVocabulary = '\u0001'..'\ufffe';  // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l72" id="l72">    72</a> }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l73" id="l73">    73</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l74" id="l74">    74</a> // DW 4/11/02 put in to support manual hoisting
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l75" id="l75">    75</a> tokens {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l76" id="l76">    76</a>     // tokens with constant text, we put them in small indices to reduce size
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l77" id="l77">    77</a>         ELLIPSIS;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l78" id="l78">    78</a>         DOT;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l79" id="l79">    79</a> 	ASSIGNEQUAL;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l80" id="l80">    80</a> 	COLON;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l81" id="l81">    81</a> 	COMMA;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l82" id="l82">    82</a> 	QUESTIONMARK;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l83" id="l83">    83</a> 	SEMICOLON;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l84" id="l84">    84</a> 	POINTERTO;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l85" id="l85">    85</a> 	LPAREN;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l86" id="l86">    86</a> 	RPAREN;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l87" id="l87">    87</a> 	LSQUARE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l88" id="l88">    88</a> 	RSQUARE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l89" id="l89">    89</a> 	LCURLY;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l90" id="l90">    90</a> 	RCURLY;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l91" id="l91">    91</a> 	EQUAL;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l92" id="l92">    92</a> 	NOTEQUAL;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l93" id="l93">    93</a> 	LESSTHANOREQUALTO;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l94" id="l94">    94</a> 	LESSTHAN;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l95" id="l95">    95</a> 	GREATERTHANOREQUALTO;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l96" id="l96">    96</a> 	GREATERTHAN;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l97" id="l97">    97</a> 	DIVIDE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l98" id="l98">    98</a> 	DIVIDEEQUAL;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l99" id="l99">    99</a> 	PLUS;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l100" id="l100">   100</a> 	PLUSEQUAL;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l101" id="l101">   101</a> 	PLUSPLUS;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l102" id="l102">   102</a> 	MINUS;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l103" id="l103">   103</a> 	MINUSEQUAL;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l104" id="l104">   104</a> 	MINUSMINUS;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l105" id="l105">   105</a> 	STAR;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l106" id="l106">   106</a> 	TIMESEQUAL;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l107" id="l107">   107</a> 	MOD;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l108" id="l108">   108</a> 	MODEQUAL;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l109" id="l109">   109</a> 	SHIFTRIGHT;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l110" id="l110">   110</a> 	SHIFTRIGHTEQUAL;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l111" id="l111">   111</a> 	SHIFTLEFT;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l112" id="l112">   112</a> 	SHIFTLEFTEQUAL;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l113" id="l113">   113</a> 	AND;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l114" id="l114">   114</a> 	NOT;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l115" id="l115">   115</a> 	OR;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l116" id="l116">   116</a> 	AMPERSAND;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l117" id="l117">   117</a> 	BITWISEANDEQUAL;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l118" id="l118">   118</a> 	TILDE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l119" id="l119">   119</a> 	BITWISEOR;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l120" id="l120">   120</a> 	BITWISEOREQUAL;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l121" id="l121">   121</a> 	BITWISEXOR;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l122" id="l122">   122</a> 	BITWISEXOREQUAL;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l123" id="l123">   123</a> 	POINTERTOMBR;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l124" id="l124">   124</a> 	DOTMBR;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l125" id="l125">   125</a> 	SCOPE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l126" id="l126">   126</a>         AT;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l127" id="l127">   127</a>         DOLLAR;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l128" id="l128">   128</a>         BACK_SLASH;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l129" id="l129">   129</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l130" id="l130">   130</a> 	DEFINED;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l131" id="l131">   131</a> 	DBL_SHARP;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l132" id="l132">   132</a> 	SHARP;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l133" id="l133">   133</a>         FUN_LIKE_MACRO_LPAREN;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l134" id="l134">   134</a>         GRAVE_ACCENT;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l135" id="l135">   135</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l136" id="l136">   136</a>         END_PREPROC_DIRECTIVE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l137" id="l137">   137</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l138" id="l138">   138</a>         // marker for last const text token
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l139" id="l139">   139</a>         LAST_CONST_TEXT_TOKEN;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l140" id="l140">   140</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l141" id="l141">   141</a>         // other tokens
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l142" id="l142">   142</a>         FLOATONE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l143" id="l143">   143</a>         FLOATTWO;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l144" id="l144">   144</a>         HEXADECIMALINT;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l145" id="l145">   145</a>         OCTALINT;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l146" id="l146">   146</a>         DECIMALINT;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l147" id="l147">   147</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l148" id="l148">   148</a> 	Whitespace;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l149" id="l149">   149</a> 	EndOfLine;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l150" id="l150">   150</a> 	Skip;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l151" id="l151">   151</a> 	PreProcComment;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l152" id="l152">   152</a> 	PPLiterals;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l153" id="l153">   153</a> 	Space;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l154" id="l154">   154</a> 	PreProcBlockComment;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l155" id="l155">   155</a> 	PreProcLineComment;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l156" id="l156">   156</a> 	Comment;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l157" id="l157">   157</a> 	CPPComment;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l158" id="l158">   158</a> 	CHAR_LITERAL;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l159" id="l159">   159</a> 	STRING_LITERAL;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l160" id="l160">   160</a> 	InterStringWhitespace;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l161" id="l161">   161</a> 	StringPart;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l162" id="l162">   162</a> 	Escape;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l163" id="l163">   163</a> 	Digit;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l164" id="l164">   164</a> 	Decimal;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l165" id="l165">   165</a> 	LongSuffix;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l166" id="l166">   166</a> 	UnsignedSuffix;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l167" id="l167">   167</a> 	FloatSuffix;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l168" id="l168">   168</a> 	Exponent;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l169" id="l169">   169</a> 	Vocabulary;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l170" id="l170">   170</a> 	NUMBER;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l171" id="l171">   171</a> 	IDENT;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l172" id="l172">   172</a>         BINARYINT;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l173" id="l173">   173</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l174" id="l174">   174</a>     // preprocessor specific tokens
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l175" id="l175">   175</a>     INCLUDE_STRING;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l176" id="l176">   176</a>     SYS_INCLUDE_STRING;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l177" id="l177">   177</a> //    END_PREPROC_DIRECTIVE; // was moved into const tokens part
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l178" id="l178">   178</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l179" id="l179">   179</a>     // preprocessor directives
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l180" id="l180">   180</a>     INCLUDE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l181" id="l181">   181</a>     INCLUDE_NEXT;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l182" id="l182">   182</a>     DEFINE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l183" id="l183">   183</a>     UNDEF;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l184" id="l184">   184</a>     IFDEF;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l185" id="l185">   185</a>     IFNDEF;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l186" id="l186">   186</a>     IF;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l187" id="l187">   187</a>     ELIF;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l188" id="l188">   188</a>     ELSE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l189" id="l189">   189</a>     ENDIF;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l190" id="l190">   190</a>     PRAGMA;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l191" id="l191">   191</a>     LINE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l192" id="l192">   192</a>     ERROR;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l193" id="l193">   193</a>     PREPROC_DIRECTIVE; // unrecongnized #-directive
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l194" id="l194">   194</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l195" id="l195">   195</a>     FIRST_LITERAL_TOKEN;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l196" id="l196">   196</a>     LITERAL_OPERATOR = &quot;operator&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l197" id="l197">   197</a>     LITERAL_alignof=&quot;alignof&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l198" id="l198">   198</a>     LITERAL___alignof__=&quot;__alignof__&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l199" id="l199">   199</a>     LITERAL_typeof=&quot;typeof&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l200" id="l200">   200</a>     LITERAL___typeof__=&quot;__typeof__&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l201" id="l201">   201</a>     LITERAL___typeof=&quot;__typeof&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l202" id="l202">   202</a>     LITERAL_template=&quot;template&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l203" id="l203">   203</a>     LITERAL_typedef=&quot;typedef&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l204" id="l204">   204</a>     LITERAL_enum=&quot;enum&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l205" id="l205">   205</a>     LITERAL_namespace=&quot;namespace&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l206" id="l206">   206</a>     LITERAL_extern=&quot;extern&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l207" id="l207">   207</a>     LITERAL_inline=&quot;inline&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l208" id="l208">   208</a>     LITERAL__inline=&quot;_inline&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l209" id="l209">   209</a>     LITERAL___inline__=&quot;__inline__&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l210" id="l210">   210</a>     LITERAL___inline=&quot;__inline&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l211" id="l211">   211</a>     LITERAL_virtual=&quot;virtual&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l212" id="l212">   212</a>     LITERAL_explicit=&quot;explicit&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l213" id="l213">   213</a>     LITERAL_friend=&quot;friend&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l214" id="l214">   214</a>     LITERAL__stdcall=&quot;_stdcall&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l215" id="l215">   215</a>     LITERAL___stdcall=&quot;__stdcall&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l216" id="l216">   216</a>     LITERAL_typename=&quot;typename&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l217" id="l217">   217</a>     LITERAL_auto=&quot;auto&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l218" id="l218">   218</a>     LITERAL_register=&quot;register&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l219" id="l219">   219</a>     LITERAL_static=&quot;static&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l220" id="l220">   220</a>     LITERAL_mutable=&quot;mutable&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l221" id="l221">   221</a>     LITERAL_const=&quot;const&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l222" id="l222">   222</a>     LITERAL___const__=&quot;__const__&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l223" id="l223">   223</a>     LITERAL___const=&quot;__const&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l224" id="l224">   224</a>     LITERAL_const_cast=&quot;const_cast&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l225" id="l225">   225</a>     LITERAL_volatile=&quot;volatile&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l226" id="l226">   226</a>     LITERAL___volatile__=&quot;__volatile__&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l227" id="l227">   227</a>     LITERAL___volatile=&quot;__volatile&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l228" id="l228">   228</a>     LITERAL_char=&quot;char&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l229" id="l229">   229</a>     LITERAL_wchar_t=&quot;wchar_t&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l230" id="l230">   230</a>     LITERAL_bool=&quot;bool&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l231" id="l231">   231</a>     LITERAL_short=&quot;short&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l232" id="l232">   232</a>     LITERAL_int=&quot;int&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l233" id="l233">   233</a>     LITERAL_long=&quot;long&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l234" id="l234">   234</a>     LITERAL_signed=&quot;signed&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l235" id="l235">   235</a>     LITERAL___signed__=&quot;__signed__&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l236" id="l236">   236</a>     LITERAL___signed=&quot;__signed&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l237" id="l237">   237</a>     LITERAL_unsigned=&quot;unsigned&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l238" id="l238">   238</a>     LITERAL___unsigned__=&quot;__unsigned__&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l239" id="l239">   239</a>     LITERAL_float=&quot;float&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l240" id="l240">   240</a>     LITERAL_double=&quot;double&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l241" id="l241">   241</a>     LITERAL_void=&quot;void&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l242" id="l242">   242</a>     LITERAL__declspec=&quot;_declspec&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l243" id="l243">   243</a>     LITERAL___declspec=&quot;__declspec&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l244" id="l244">   244</a>     LITERAL_class=&quot;class&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l245" id="l245">   245</a>     LITERAL_struct=&quot;struct&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l246" id="l246">   246</a>     LITERAL_union=&quot;union&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l247" id="l247">   247</a>     LITERAL_this=&quot;this&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l248" id="l248">   248</a>     LITERAL_true=&quot;true&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l249" id="l249">   249</a>     LITERAL_false=&quot;false&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l250" id="l250">   250</a>     LITERAL_public=&quot;public&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l251" id="l251">   251</a>     LITERAL_protected=&quot;protected&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l252" id="l252">   252</a>     LITERAL_private=&quot;private&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l253" id="l253">   253</a>     LITERAL_throw=&quot;throw&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l254" id="l254">   254</a>     LITERAL_case=&quot;case&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l255" id="l255">   255</a>     LITERAL_default=&quot;default&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l256" id="l256">   256</a>     LITERAL_if=&quot;if&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l257" id="l257">   257</a>     LITERAL_else=&quot;else&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l258" id="l258">   258</a>     LITERAL_switch=&quot;switch&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l259" id="l259">   259</a>     LITERAL_while=&quot;while&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l260" id="l260">   260</a>     LITERAL_do=&quot;do&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l261" id="l261">   261</a>     LITERAL_for=&quot;for&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l262" id="l262">   262</a>     LITERAL_goto=&quot;goto&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l263" id="l263">   263</a>     LITERAL_continue=&quot;continue&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l264" id="l264">   264</a>     LITERAL_break=&quot;break&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l265" id="l265">   265</a>     LITERAL_return=&quot;return&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l266" id="l266">   266</a>     LITERAL_try=&quot;try&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l267" id="l267">   267</a>     LITERAL_catch=&quot;catch&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l268" id="l268">   268</a>     LITERAL_using=&quot;using&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l269" id="l269">   269</a>     LITERAL_export=&quot;export&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l270" id="l270">   270</a>     LITERAL_asm=&quot;asm&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l271" id="l271">   271</a>     LITERAL__asm=&quot;_asm&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l272" id="l272">   272</a>     LITERAL___asm__=&quot;__asm__&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l273" id="l273">   273</a>     LITERAL___asm=&quot;__asm&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l274" id="l274">   274</a>     LITERAL__endasm=&quot;_endasm&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l275" id="l275">   275</a>     LITERAL_sizeof=&quot;sizeof&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l276" id="l276">   276</a>     LITERAL_dynamic_cast=&quot;dynamic_cast&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l277" id="l277">   277</a>     LITERAL_static_cast=&quot;static_cast&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l278" id="l278">   278</a>     LITERAL_reinterpret_cast=&quot;reinterpret_cast&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l279" id="l279">   279</a>     LITERAL_new=&quot;new&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l280" id="l280">   280</a>     LITERAL__cdecl=&quot;_cdecl&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l281" id="l281">   281</a>     LITERAL___cdecl=&quot;__cdecl&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l282" id="l282">   282</a>     LITERAL__near=&quot;_near&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l283" id="l283">   283</a>     LITERAL___near=&quot;__near&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l284" id="l284">   284</a>     LITERAL__far=&quot;_far&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l285" id="l285">   285</a>     LITERAL___far=&quot;__far&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l286" id="l286">   286</a>     LITERAL___interrupt=&quot;__interrupt&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l287" id="l287">   287</a>     LITERAL_pascal=&quot;pascal&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l288" id="l288">   288</a>     LITERAL__pascal=&quot;_pascal&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l289" id="l289">   289</a>     LITERAL___pascal=&quot;__pascal&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l290" id="l290">   290</a>     LITERAL_delete=&quot;delete&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l291" id="l291">   291</a>     LITERAL__int64=&quot;_int64&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l292" id="l292">   292</a>     LITERAL___int64=&quot;__int64&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l293" id="l293">   293</a>     LITERAL___w64=&quot;__w64&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l294" id="l294">   294</a>     LITERAL___extension__=&quot;__extension__&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l295" id="l295">   295</a>     LITERAL___attribute__=&quot;__attribute__&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l296" id="l296">   296</a>     LITERAL_restrict=&quot;restrict&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l297" id="l297">   297</a>     LITERAL___restrict=&quot;__restrict&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l298" id="l298">   298</a>     LITERAL___complex__=&quot;__complex__&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l299" id="l299">   299</a>     LITERAL___imag=&quot;__imag__&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l300" id="l300">   300</a>     LITERAL___real=&quot;__real__&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l301" id="l301">   301</a>     LITERAL___global=&quot;__global&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l302" id="l302">   302</a>     LITERAL__Bool=&quot;_Bool&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l303" id="l303">   303</a>     LITERAL__Complex=&quot;_Complex&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l304" id="l304">   304</a>     LITERAL___thread=&quot;__thread&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l305" id="l305">   305</a>     LITERAL___attribute=&quot;__attribute&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l306" id="l306">   306</a>     LITERAL__Imaginary=&quot;_Imaginary&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l307" id="l307">   307</a>     LITERAL_bit=&quot;bit&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l308" id="l308">   308</a>     LITERAL___symbolic=&quot;__symbolic&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l309" id="l309">   309</a>     LITERAL___hidden=&quot;__hidden&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l310" id="l310">   310</a>     LITERAL_final=&quot;final&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l311" id="l311">   311</a>     LITERAL_override=&quot;override&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l312" id="l312">   312</a>     LITERAL_constexpr=&quot;constexpr&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l313" id="l313">   313</a>     LITERAL_decltype=&quot;decltype&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l314" id="l314">   314</a>     LITERAL_nullptr=&quot;nullptr&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l315" id="l315">   315</a>     LITERAL_thread_local=&quot;thread_local&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l316" id="l316">   316</a>     LITERAL_static_assert=&quot;static_assert&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l317" id="l317">   317</a>     LITERAL_alignas=&quot;alignas&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l318" id="l318">   318</a>     LITERAL_char16_t=&quot;char16_t&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l319" id="l319">   319</a>     LITERAL_char32_t=&quot;char32_t&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l320" id="l320">   320</a>     LITERAL_noexcept=&quot;noexcept&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l321" id="l321">   321</a>     LITERAL___decltype=&quot;__decltype&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l322" id="l322">   322</a>     LITERAL___complex=&quot;__complex&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l323" id="l323">   323</a>     LITERAL___forceinline=&quot;__forceinline&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l324" id="l324">   324</a>     LITERAL___clrcall=&quot;__clrcall&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l325" id="l325">   325</a>     LITERAL___try=&quot;__try&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l326" id="l326">   326</a>     LITERAL___finally=&quot;__finally&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l327" id="l327">   327</a>     LITERAL___null=&quot;__null&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l328" id="l328">   328</a>     LITERAL___alignof=&quot;__alignof&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l329" id="l329">   329</a>     LITERAL___is_class=&quot;__is_class&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l330" id="l330">   330</a>     LITERAL___is_pod=&quot;__is_pod&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l331" id="l331">   331</a>     LITERAL___is_base_of=&quot;__is_base_of&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l332" id="l332">   332</a>     LITERAL___has_trivial_constructor=&quot;__has_trivial_constructor&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l333" id="l333">   333</a>     LITERAL___restrict__=&quot;__restrict__&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l334" id="l334">   334</a>     LITERAL__Noreturn=&quot;_Noreturn&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l335" id="l335">   335</a>     LITERAL___has_nothrow_assign=&quot;__has_nothrow_assign&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l336" id="l336">   336</a>     LITERAL___has_nothrow_copy=&quot;__has_nothrow_copy&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l337" id="l337">   337</a>     LITERAL___has_nothrow_constructor=&quot;__has_nothrow_constructor&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l338" id="l338">   338</a>     LITERAL___has_trivial_assign=&quot;__has_trivial_assign&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l339" id="l339">   339</a>     LITERAL___has_trivial_copy=&quot;__has_trivial_copy&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l340" id="l340">   340</a>     LITERAL___has_trivial_destructor=&quot;__has_trivial_destructor&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l341" id="l341">   341</a>     LITERAL___has_virtual_destructor=&quot;__has_virtual_destructor&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l342" id="l342">   342</a>     LITERAL___is_abstract=&quot;__is_abstract&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l343" id="l343">   343</a>     LITERAL___is_empty=&quot;__is_empty&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l344" id="l344">   344</a>     LITERAL___is_literal_type=&quot;__is_literal_type&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l345" id="l345">   345</a>     LITERAL___is_polymorphic=&quot;__is_polymorphic&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l346" id="l346">   346</a>     LITERAL___is_standard_layout=&quot;__is_standard_layout&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l347" id="l347">   347</a>     LITERAL___is_trivial=&quot;__is_trivial&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l348" id="l348">   348</a>     LITERAL___is_union=&quot;__is_union&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l349" id="l349">   349</a>     LITERAL___underlying_type=&quot;__underlying_type&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l350" id="l350">   350</a>     LITERAL___builtin_va_list=&quot;__builtin_va_list&quot;; // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l351" id="l351">   351</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l352" id="l352">   352</a>     LAST_LITERAL_TOKEN;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l353" id="l353">   353</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l354" id="l354">   354</a>     // Extension points
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l355" id="l355">   355</a>     LITERAL__BUILT_IN_TYPE__; // extra built-in type name
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l356" id="l356">   356</a>     LITERAL__TYPE_QUALIFIER__; // extra type qualifier 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l357" id="l357">   357</a>     LITERAL__STORAGE_CLASS_SPECIFIER__; // extra storage qualifier
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l358" id="l358">   358</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l359" id="l359">   359</a>     // Fortran tokens
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l360" id="l360">   360</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l361" id="l361">   361</a>     T_CLOSE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l362" id="l362">   362</a>     T_BLOCK;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l363" id="l363">   363</a>     T_GE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l364" id="l364">   364</a>     T_CONTAINS;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l365" id="l365">   365</a>     T_ABSTRACT;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l366" id="l366">   366</a>     T_CLASS;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l367" id="l367">   367</a>     T_NOPASS;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l368" id="l368">   368</a>     T_UNFORMATTED;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l369" id="l369">   369</a>     T_LESSTHAN;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l370" id="l370">   370</a>     T_ENDSUBROUTINE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l371" id="l371">   371</a>     T_GT;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l372" id="l372">   372</a>     T_IDENT;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l373" id="l373">   373</a>     T_INTERFACE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l374" id="l374">   374</a>     T_RETURN;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l375" id="l375">   375</a>     T_XYZ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l376" id="l376">   376</a>     T_EOF;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l377" id="l377">   377</a>     T_CALL;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l378" id="l378">   378</a>     T_EOS;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l379" id="l379">   379</a>     T_GO;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l380" id="l380">   380</a>     T_AND;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l381" id="l381">   381</a>     T_PERCENT;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l382" id="l382">   382</a>     T_PRINT;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l383" id="l383">   383</a>     T_ALLOCATE_STMT_1;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l384" id="l384">   384</a>     T_SUBROUTINE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l385" id="l385">   385</a>     T_CONTROL_EDIT_DESC;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l386" id="l386">   386</a>     T_ENUMERATOR;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l387" id="l387">   387</a>     Alphanumeric_Character;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l388" id="l388">   388</a>     T_DEFINED_OP;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l389" id="l389">   389</a>     T_KIND;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l390" id="l390">   390</a>     T_STOP;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l391" id="l391">   391</a>     T_GREATERTHAN_EQ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l392" id="l392">   392</a>     T_CHAR_STRING_EDIT_DESC;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l393" id="l393">   393</a>     T_ALLOCATABLE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l394" id="l394">   394</a>     T_ENDINTERFACE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l395" id="l395">   395</a>     T_END;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l396" id="l396">   396</a>     T_ASTERISK;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l397" id="l397">   397</a>     T_PRIVATE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l398" id="l398">   398</a>     T_DOUBLEPRECISION;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l399" id="l399">   399</a>     T_CASE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l400" id="l400">   400</a>     T_IMPLICIT;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l401" id="l401">   401</a>     T_IF;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l402" id="l402">   402</a>     T_THEN;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l403" id="l403">   403</a>     T_DIMENSION;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l404" id="l404">   404</a>     T_GOTO;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l405" id="l405">   405</a>     T_ENDMODULE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l406" id="l406">   406</a>     T_IN;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l407" id="l407">   407</a>     T_WRITE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l408" id="l408">   408</a>     T_FORMATTED;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l409" id="l409">   409</a>     WS;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l410" id="l410">   410</a>     T_DATA;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l411" id="l411">   411</a>     T_FALSE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l412" id="l412">   412</a>     T_WHERE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l413" id="l413">   413</a>     T_ENDIF;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l414" id="l414">   414</a>     T_SLASH;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l415" id="l415">   415</a>     SQ_Rep_Char;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l416" id="l416">   416</a>     T_GENERIC;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l417" id="l417">   417</a>     T_RECURSIVE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l418" id="l418">   418</a>     DQ_Rep_Char;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l419" id="l419">   419</a>     T_ELSEIF;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l420" id="l420">   420</a>     T_BLOCKDATA;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l421" id="l421">   421</a>     OCTAL_CONSTANT;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l422" id="l422">   422</a>     T_SELECTTYPE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l423" id="l423">   423</a>     T_MINUS;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l424" id="l424">   424</a>     T_SELECT;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l425" id="l425">   425</a>     T_FINAL;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l426" id="l426">   426</a>     T_UNDERSCORE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l427" id="l427">   427</a>     T_IMPORT;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l428" id="l428">   428</a>     T_USE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l429" id="l429">   429</a>     T_FILE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l430" id="l430">   430</a>     T_RPAREN;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l431" id="l431">   431</a>     T_INTENT;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l432" id="l432">   432</a>     T_ENDBLOCK;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l433" id="l433">   433</a>     T_ASSIGNMENT_STMT;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l434" id="l434">   434</a>     T_PAUSE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l435" id="l435">   435</a>     T_BACKSPACE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l436" id="l436">   436</a>     T_ENDFILE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l437" id="l437">   437</a>     T_EQUALS;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l438" id="l438">   438</a>     T_NON_INTRINSIC;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l439" id="l439">   439</a>     T_SELECTCASE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l440" id="l440">   440</a>     T_DIGIT_STRING;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l441" id="l441">   441</a>     T_COLON_COLON;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l442" id="l442">   442</a>     T_NON_OVERRIDABLE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l443" id="l443">   443</a>     Special_Character;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l444" id="l444">   444</a>     T_INCLUDE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l445" id="l445">   445</a>     T_OPEN;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l446" id="l446">   446</a>     T_POWER;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l447" id="l447">   447</a>     T_ASSOCIATE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l448" id="l448">   448</a>     T_CHAR_CONSTANT;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l449" id="l449">   449</a>     T_OPERATOR;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l450" id="l450">   450</a>     T_TO;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l451" id="l451">   451</a>     T_ENDASSOCIATE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l452" id="l452">   452</a>     T_EQ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l453" id="l453">   453</a>     T_GREATERTHAN;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l454" id="l454">   454</a>     T_DATA_EDIT_DESC;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l455" id="l455">   455</a>     T_INQUIRE_STMT_2;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l456" id="l456">   456</a>     T_EQV;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l457" id="l457">   457</a>     HEX_CONSTANT;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l458" id="l458">   458</a>     Digit_String;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l459" id="l459">   459</a>     T_ELEMENTAL;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l460" id="l460">   460</a>     T_CHARACTER;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l461" id="l461">   461</a>     PREPROCESS_LINE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l462" id="l462">   462</a>     T_NULLIFY;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l463" id="l463">   463</a>     T_REWIND;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l464" id="l464">   464</a>     T_ARITHMETIC_IF_STMT;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l465" id="l465">   465</a>     T_FORALL_CONSTRUCT_STMT;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l466" id="l466">   466</a>     T_BIND;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l467" id="l467">   467</a>     T_ENDFORALL;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l468" id="l468">   468</a>     T_DO;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l469" id="l469">   469</a>     T_WHERE_STMT;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l470" id="l470">   470</a>     T_POINTER;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l471" id="l471">   471</a>     T_PROGRAM;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l472" id="l472">   472</a>     T_ENDTYPE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l473" id="l473">   473</a>     T_WAIT;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l474" id="l474">   474</a>     T_ELSE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l475" id="l475">   475</a>     T_IF_STMT;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l476" id="l476">   476</a>     T_RBRACKET;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l477" id="l477">   477</a>     T_LPAREN;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l478" id="l478">   478</a>     T_EXTENDS;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l479" id="l479">   479</a>     T_OPTIONAL;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l480" id="l480">   480</a>     T_DOUBLE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l481" id="l481">   481</a>     T_MODULE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l482" id="l482">   482</a>     T_READ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l483" id="l483">   483</a>     T_ALLOCATE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l484" id="l484">   484</a>     T_INTEGER;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l485" id="l485">   485</a>     T_OR;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l486" id="l486">   486</a>     T_EQUIVALENCE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l487" id="l487">   487</a>     T_PERIOD;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l488" id="l488">   488</a>     T_ENTRY;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l489" id="l489">   489</a>     T_LABEL_DO_TERMINAL;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l490" id="l490">   490</a>     T_REAL;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l491" id="l491">   491</a>     T_CYCLE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l492" id="l492">   492</a>     T_PROCEDURE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l493" id="l493">   493</a>     T_EQ_EQ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l494" id="l494">   494</a>     T_SLASH_EQ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l495" id="l495">   495</a>     T_ENDSELECT;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l496" id="l496">   496</a>     T_PURE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l497" id="l497">   497</a>     T_TRUE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l498" id="l498">   498</a>     T_NE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l499" id="l499">   499</a>     T_INTRINSIC;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l500" id="l500">   500</a>     T_PASS;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l501" id="l501">   501</a>     T_REAL_CONSTANT;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l502" id="l502">   502</a>     LINE_COMMENT;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l503" id="l503">   503</a>     T_PERIOD_EXPONENT;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l504" id="l504">   504</a>     T_ENDWHERE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l505" id="l505">   505</a>     MISC_CHAR;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l506" id="l506">   506</a>     T_FORMAT;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l507" id="l507">   507</a>     T_DEFAULT;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l508" id="l508">   508</a>     T_SLASH_SLASH;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l509" id="l509">   509</a>     T_NONE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l510" id="l510">   510</a>     T_NAMELIST;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l511" id="l511">   511</a>     T_SEQUENCE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l512" id="l512">   512</a>     T_PRECISION;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l513" id="l513">   513</a>     T_ASYNCHRONOUS;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l514" id="l514">   514</a>     T_COMMA;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l515" id="l515">   515</a>     T_RESULT;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l516" id="l516">   516</a>     T_ENDBLOCKDATA;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l517" id="l517">   517</a>     T_LOGICAL;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l518" id="l518">   518</a>     T_VALUE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l519" id="l519">   519</a>     Letter;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l520" id="l520">   520</a>     T_FORALL;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l521" id="l521">   521</a>     T_SAVE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l522" id="l522">   522</a>     T_HOLLERITH;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l523" id="l523">   523</a>     T_FLUSH;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l524" id="l524">   524</a>     T_WHILE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l525" id="l525">   525</a>     T_INQUIRE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l526" id="l526">   526</a>     T_DEFERRED;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l527" id="l527">   527</a>     T_FORALL_STMT;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l528" id="l528">   528</a>     T_ASSIGN;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l529" id="l529">   529</a>     T_LBRACKET;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l530" id="l530">   530</a>     T_EXTERNAL;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l531" id="l531">   531</a>     T_VOLATILE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l532" id="l532">   532</a>     T_OUT;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l533" id="l533">   533</a>     CONTINUE_CHAR;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l534" id="l534">   534</a>     T_COLON;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l535" id="l535">   535</a>     T_COMPLEX;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l536" id="l536">   536</a>     T_PLUS;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l537" id="l537">   537</a>     T_STMT_FUNCTION;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l538" id="l538">   538</a>     T_ONLY;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l539" id="l539">   539</a>     T_PROTECTED;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l540" id="l540">   540</a>     T_COMMON;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l541" id="l541">   541</a>     T_INOUT;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l542" id="l542">   542</a>     T_NEQV;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l543" id="l543">   543</a>     T_PUBLIC;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l544" id="l544">   544</a>     T_ENDDO;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l545" id="l545">   545</a>     T_ENDPROGRAM;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l546" id="l546">   546</a>     T_ENDFUNCTION;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l547" id="l547">   547</a>     T_WHERE_CONSTRUCT_STMT;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l548" id="l548">   548</a>     T_ELSEWHERE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l549" id="l549">   549</a>     T_ENUM;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l550" id="l550">   550</a>     //Digit;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l551" id="l551">   551</a>     T_PARAMETER;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l552" id="l552">   552</a>     T_TARGET;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l553" id="l553">   553</a>     T_DOUBLECOMPLEX;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l554" id="l554">   554</a>     T_PTR_ASSIGNMENT_STMT;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l555" id="l555">   555</a>     T_TYPE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l556" id="l556">   556</a>     T_LESSTHAN_EQ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l557" id="l557">   557</a>     T_DEALLOCATE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l558" id="l558">   558</a>     T_LT;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l559" id="l559">   559</a>     T_FUNCTION;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l560" id="l560">   560</a>     T_EQ_GT;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l561" id="l561">   561</a>     T_ENDENUM;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l562" id="l562">   562</a>     BINARY_CONSTANT;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l563" id="l563">   563</a>     T_LE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l564" id="l564">   564</a>     T_LEN;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l565" id="l565">   565</a>     T_CONTINUE;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l566" id="l566">   566</a>     T_NOT;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l567" id="l567">   567</a>     Rep_Char;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l568" id="l568">   568</a>     T_ASSIGNMENT;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l569" id="l569">   569</a>     T_EXIT;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l570" id="l570">   570</a> }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l571" id="l571">   571</a> {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l572" id="l572">   572</a>     private boolean reportErrors;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l573" id="l573">   573</a>     private Language lang;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l574" id="l574">   574</a>     private Flavor flavor;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l575" id="l575">   575</a>     private APTLexerCallback callback;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l576" id="l576">   576</a>     public static enum Language {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l577" id="l577">   577</a>         C,
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l578" id="l578">   578</a>         CPP,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l579" id="l579">   579</a>         FORTRAN
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l580" id="l580">   580</a>     };
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l581" id="l581">   581</a>     public static enum Flavor {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l582" id="l582">   582</a>         UNKNOWN,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l583" id="l583">   583</a>         FORTRAN_FIXED,
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l584" id="l584">   584</a>         FORTRAN_FREE,
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l585" id="l585">   585</a>         CPP11
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l586" id="l586">   586</a>     };
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l587" id="l587">   587</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l588" id="l588">   588</a>     public interface APTLexerCallback {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l589" id="l589">   589</a>         void onMakeToken(int tokType, int startColumn, int startLine);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l590" id="l590">   590</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l591" id="l591">   591</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l592" id="l592">   592</a>     public void setCallback(APTLexerCallback callback) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l593" id="l593">   593</a>         this.callback = callback;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l594" id="l594">   594</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l595" id="l595">   595</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l596" id="l596">   596</a>     public void init(String filename, int flags, String language, String flavor) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l597" id="l597">   597</a>         preprocPossible = true;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l598" id="l598">   598</a>         preprocPending = false;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l599" id="l599">   599</a>         reportErrors = true;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l600" id="l600">   600</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l601" id="l601">   601</a>         setFilename(filename);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l602" id="l602">   602</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l603" id="l603">   603</a>         if(language.equalsIgnoreCase(APTLanguageSupport.FORTRAN)) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l604" id="l604">   604</a>             this.lang = Language.FORTRAN;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l605" id="l605">   605</a>         } else {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l606" id="l606">   606</a>             this.lang = Language.CPP;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l607" id="l607">   607</a>         }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l608" id="l608">   608</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l609" id="l609">   609</a>         if(flavor.equalsIgnoreCase(APTLanguageSupport.FLAVOR_FORTRAN_FIXED)) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l610" id="l610">   610</a>             this.flavor = Flavor.FORTRAN_FIXED;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l611" id="l611">   611</a>         } else if(flavor.equalsIgnoreCase(APTLanguageSupport.FLAVOR_FORTRAN_FREE)) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l612" id="l612">   612</a>             this.flavor = Flavor.FORTRAN_FREE;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l613" id="l613">   613</a>         } else if(flavor.equalsIgnoreCase(APTLanguageSupport.FLAVOR_CPP11)) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l614" id="l614">   614</a>             this.flavor = Flavor.CPP11;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l615" id="l615">   615</a>         } else {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l616" id="l616">   616</a>             this.flavor = Flavor.UNKNOWN;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l617" id="l617">   617</a>         }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l618" id="l618">   618</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l619" id="l619">   619</a> //        if ((flags &amp; CPPParser.CPP_SUPPRESS_ERRORS) &gt; 0) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l620" id="l620">   620</a> //            reportErrors = false;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l621" id="l621">   621</a> //        }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l622" id="l622">   622</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l623" id="l623">   623</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l624" id="l624">   624</a>     // overriden to avoid class loading
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l625" id="l625">   625</a>     @Override
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l626" id="l626">   626</a>     public void setTokenObjectClass(String cl) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l627" id="l627">   627</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l628" id="l628">   628</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l629" id="l629">   629</a>     // Used instead of setTokenObjectClass method to avoid reflection usage
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l630" id="l630">   630</a>     @Override
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l631" id="l631">   631</a>     protected APTToken createToken(int type) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l632" id="l632">   632</a>         return APTUtils.createAPTToken(type);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l633" id="l633">   633</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l634" id="l634">   634</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l635" id="l635">   635</a>     @Override
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l636" id="l636">   636</a>     protected void setTokenText(Token _token, char buf[], int start, int count) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l637" id="l637">   637</a>         APTUtils.setTokenText((APTToken)_token, buf, start, count);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l638" id="l638">   638</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l639" id="l639">   639</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l640" id="l640">   640</a>     @Override
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l641" id="l641">   641</a>     public void traceIn(String rname) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l642" id="l642">   642</a>         traceDepth ++;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l643" id="l643">   643</a>         traceIndent();
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l644" id="l644">   644</a>         char c = LA(1);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l645" id="l645">   645</a>         Object ch = (c == '\n') ? &quot;\\n&quot; : c == '\t' ? &quot;\\t&quot; : (&quot;&quot; + c); // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l646" id="l646">   646</a>         System.out.println(&quot;&gt; lexer &quot; + rname + &quot;; c==&quot; + ch); // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l647" id="l647">   647</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l648" id="l648">   648</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l649" id="l649">   649</a>     public void traceOut(String rname) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l650" id="l650">   650</a>         traceIndent();
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l651" id="l651">   651</a>         char c = LA(1);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l652" id="l652">   652</a>         Object ch = c == '\n' ? &quot;\\n&quot; : c == '\t' ? &quot;\\t&quot; : (&quot;&quot; + c); // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l653" id="l653">   653</a>         System.out.println(&quot;&lt; lexer &quot; + rname + &quot;; c==&quot; + ch); // NOI18N
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l654" id="l654">   654</a>         traceDepth--;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l655" id="l655">   655</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l656" id="l656">   656</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l657" id="l657">   657</a>     private int errorCount = 0;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l658" id="l658">   658</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l659" id="l659">   659</a>     public int getErrorCount() {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l660" id="l660">   660</a>         return errorCount;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l661" id="l661">   661</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l662" id="l662">   662</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l663" id="l663">   663</a>     public void reportError(RecognitionException e) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l664" id="l664">   664</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l665" id="l665">   665</a>         if (reportErrors) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l666" id="l666">   666</a>             super.reportError(e);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l667" id="l667">   667</a>         }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l668" id="l668">   668</a>         errorCount++;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l669" id="l669">   669</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l670" id="l670">   670</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l671" id="l671">   671</a>     public void reportError(String s) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l672" id="l672">   672</a>         if (reportErrors) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l673" id="l673">   673</a>             super.reportError(s);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l674" id="l674">   674</a>         }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l675" id="l675">   675</a>         errorCount++;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l676" id="l676">   676</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l677" id="l677">   677</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l678" id="l678">   678</a>     private boolean isCPlusPlus() {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l679" id="l679">   679</a>         return lang == Language.CPP;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l680" id="l680">   680</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l681" id="l681">   681</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l682" id="l682">   682</a>     private boolean isCPlusPlus11() {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l683" id="l683">   683</a>         return isCPlusPlus() &amp;&amp; flavor == Flavor.CPP11;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l684" id="l684">   684</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l685" id="l685">   685</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l686" id="l686">   686</a> /*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l687" id="l687">   687</a>     protected void printf(String pattern, int i) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l688" id="l688">   688</a>         Printf.printf(pattern, new Object[] { new Integer(i) });
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l689" id="l689">   689</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l690" id="l690">   690</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l691" id="l691">   691</a>     protected void printf(String pattern, int i, boolean b) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l692" id="l692">   692</a>         Printf.printf(pattern, new Object[] { new Integer(i), Boolean.valueOf(b) });
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l693" id="l693">   693</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l694" id="l694">   694</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l695" id="l695">   695</a>     protected void printf(String pattern) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l696" id="l696">   696</a>         Printf.printf(pattern, new Object[] {});
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l697" id="l697">   697</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l698" id="l698">   698</a> */
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l699" id="l699">   699</a> 	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l700" id="l700">   700</a>     private static final int PREPROC_POSSIBLE = 0;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l701" id="l701">   701</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l702" id="l702">   702</a>     private static final int PREPROC_PENDING = 1;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l703" id="l703">   703</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l704" id="l704">   704</a>     private static final int AFTER_DEFINE = 2;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l705" id="l705">   705</a>     /**
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l706" id="l706">   706</a>      * INCLUDE_STRING token is expected while in this state
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l707" id="l707">   707</a>      */ 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l708" id="l708">   708</a>     private static final int AFTER_INLUDE = 3;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l709" id="l709">   709</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l710" id="l710">   710</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l711" id="l711">   711</a>     /**
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l712" id="l712">   712</a>      *  A '#' character read while in this state would be treated as the
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l713" id="l713">   713</a>      *  start of a PrprocDirective. Other '#' chars would be treated as
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l714" id="l714">   714</a>      *  POUND chars.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l715" id="l715">   715</a>      */	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l716" id="l716">   716</a>     private boolean preprocPossible;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l717" id="l717">   717</a>     private boolean isPreprocPossible() {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l718" id="l718">   718</a>             return preprocPossible;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l719" id="l719">   719</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l720" id="l720">   720</a>     private void setPreprocPossible(boolean possible) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l721" id="l721">   721</a>             this.preprocPossible = possible;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l722" id="l722">   722</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l723" id="l723">   723</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l724" id="l724">   724</a>     /**
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l725" id="l725">   725</a>      *  Flag prevents token creating for APT light.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l726" id="l726">   726</a>      */	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l727" id="l727">   727</a>     private boolean onlyPreproc = false;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l728" id="l728">   728</a>     private boolean isOnlyPreproc() {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l729" id="l729">   729</a>         return onlyPreproc;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l730" id="l730">   730</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l731" id="l731">   731</a>     public void setOnlyPreproc(boolean onlyPreproc) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l732" id="l732">   732</a>         this.onlyPreproc = onlyPreproc;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l733" id="l733">   733</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l734" id="l734">   734</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l735" id="l735">   735</a>     /**
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l736" id="l736">   736</a>      *  EndOfLine read while in this state whould be treated as the end
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l737" id="l737">   737</a>      * of a PreprocDirective and token END_PREPROC_DIRECTIVE will be created
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l738" id="l738">   738</a>      */
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l739" id="l739">   739</a>     private boolean preprocPending;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l740" id="l740">   740</a>     private boolean isPreprocPending() {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l741" id="l741">   741</a>         return preprocPending;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l742" id="l742">   742</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l743" id="l743">   743</a>     private void setPreprocPending(boolean pending) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l744" id="l744">   744</a>         this.preprocPending = pending;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l745" id="l745">   745</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l746" id="l746">   746</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l747" id="l747">   747</a>     private boolean afterInclude = false;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l748" id="l748">   748</a>     private boolean isAfterInclude() {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l749" id="l749">   749</a>         return afterInclude;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l750" id="l750">   750</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l751" id="l751">   751</a>     private void setAfterInclude(boolean afterInclude) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l752" id="l752">   752</a>         this.afterInclude = afterInclude;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l753" id="l753">   753</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l754" id="l754">   754</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l755" id="l755">   755</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l756" id="l756">   756</a>     /**
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l757" id="l757">   757</a>      * ID read while in this state whould be treated as ID_DEFINED, 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l758" id="l758">   758</a>      * need for not expanding ID in expresions like:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l759" id="l759">   759</a>      * #if defined MACRO
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l760" id="l760">   760</a>      */
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l761" id="l761">   761</a>     private boolean afterPPDefined = false;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l762" id="l762">   762</a>     private boolean ppDefinedAllowed = true;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l763" id="l763">   763</a>     private boolean isAfterPPDefined() {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l764" id="l764">   764</a>         return afterPPDefined;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l765" id="l765">   765</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l766" id="l766">   766</a>     private void setAfterPPDefined(boolean afterPPDefined) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l767" id="l767">   767</a>         this.afterPPDefined = afterPPDefined;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l768" id="l768">   768</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l769" id="l769">   769</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l770" id="l770">   770</a>     private boolean isPPDefinedAllowed() {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l771" id="l771">   771</a>         return ppDefinedAllowed;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l772" id="l772">   772</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l773" id="l773">   773</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l774" id="l774">   774</a>     private void setPPDefinedAllowed(boolean ppDefinedAllowed) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l775" id="l775">   775</a>         this.ppDefinedAllowed = ppDefinedAllowed;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l776" id="l776">   776</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l777" id="l777">   777</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l778" id="l778">   778</a>     /**
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l779" id="l779">   779</a>      * ID read while in this state whould be treated as ID, but 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l780" id="l780">   780</a>      * LA(1) will be checked to switch into &quot;funLikeMacro&quot; state upon 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l781" id="l781">   781</a>      * (LA(1) == '(') without leading whitespace 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l782" id="l782">   782</a>      * (need for FUN_LIKE_MACRO_LPAREN token)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l783" id="l783">   783</a>      */
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l784" id="l784">   784</a>     private boolean afterDefine = false;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l785" id="l785">   785</a>     private boolean isAfterDefine() {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l786" id="l786">   786</a>         return afterDefine;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l787" id="l787">   787</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l788" id="l788">   788</a>     private void setAfterDefine(boolean afterDefine) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l789" id="l789">   789</a>         this.afterDefine = afterDefine;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l790" id="l790">   790</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l791" id="l791">   791</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l792" id="l792">   792</a>     /**
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l793" id="l793">   793</a>      * FUN_LIKE_MACRO_LPAREN token is expected while in this state
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l794" id="l794">   794</a>      */
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l795" id="l795">   795</a>     private boolean funLikeMacro = false;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l796" id="l796">   796</a>     private boolean isFunLikeMacro() {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l797" id="l797">   797</a>         return funLikeMacro;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l798" id="l798">   798</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l799" id="l799">   799</a>     private void setFunLikeMacro(boolean funLikeMacro) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l800" id="l800">   800</a>         this.funLikeMacro = funLikeMacro;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l801" id="l801">   801</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l802" id="l802">   802</a>     
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l803" id="l803">   803</a>     private void clearPrepProcFlags() {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l804" id="l804">   804</a>         setFunLikeMacro(false);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l805" id="l805">   805</a>         setAfterDefine(false);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l806" id="l806">   806</a>         setAfterPPDefined(false);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l807" id="l807">   807</a>         setAfterInclude(false);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l808" id="l808">   808</a>         setPreprocPending(false);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l809" id="l809">   809</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l810" id="l810">   810</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l811" id="l811">   811</a>     @Override
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l812" id="l812">   812</a>     protected APTToken makeToken(int t) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l813" id="l813">   813</a>         if (callback != null) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l814" id="l814">   814</a>             callback.onMakeToken(t, getTokenStartColumn(), getTokenStartLine());
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l815" id="l815">   815</a>         }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l816" id="l816">   816</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l817" id="l817">   817</a>         if (isOnlyPreproc() &amp;&amp; isPreprocPossible()) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l818" id="l818">   818</a>            // do not create token if lexer builds light stream
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l819" id="l819">   819</a>             if (!(t==Token.EOF_TYPE || t==END_PREPROC_DIRECTIVE)){
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l820" id="l820">   820</a>                 return null;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l821" id="l821">   821</a>             }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l822" id="l822">   822</a>         }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l823" id="l823">   823</a>         // Our literal check
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l824" id="l824">   824</a>         int literalType = testLiteralsTable(0);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l825" id="l825">   825</a>         APTToken k = APTUtils.createAPTToken(t, tokenStartOffset, offset, getTokenStartColumn(), getTokenStartLine(), inputState.getColumn(), inputState.getLine(), literalType);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l826" id="l826">   826</a>         // it should be impossible to have preprocessor directive 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l827" id="l827">   827</a>         // after valid token. preprocessor directive valid only
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l828" id="l828">   828</a>         // at start of line @see newline()
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l829" id="l829">   829</a>         if (t != COMMENT) { // block comment is valid anywhere
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l830" id="l830">   830</a>             setPreprocPossible(t == END_PREPROC_DIRECTIVE);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l831" id="l831">   831</a>         }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l832" id="l832">   832</a>         return k;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l833" id="l833">   833</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l834" id="l834">   834</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l835" id="l835">   835</a>     public void resetText() {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l836" id="l836">   836</a>         super.resetText();
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l837" id="l837">   837</a>         tokenStartOffset = offset;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l838" id="l838">   838</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l839" id="l839">   839</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l840" id="l840">   840</a>     public void consume() {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l841" id="l841">   841</a>         super.consume();
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l842" id="l842">   842</a>         if (guessing == 0) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l843" id="l843">   843</a>             offset++;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l844" id="l844">   844</a>         }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l845" id="l845">   845</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l846" id="l846">   846</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l847" id="l847">   847</a> /*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l848" id="l848">   848</a>     boolean wasTab;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l849" id="l849">   849</a>     public void consume() throws CharStreamException {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l850" id="l850">   850</a>         wasTab = false;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l851" id="l851">   851</a>         super.consume();
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l852" id="l852">   852</a>         if (!wasTab) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l853" id="l853">   853</a>             offset++;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l854" id="l854">   854</a>         }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l855" id="l855">   855</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l856" id="l856">   856</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l857" id="l857">   857</a>     public void tab() {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l858" id="l858">   858</a>         wasTab = true;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l859" id="l859">   859</a>         int c = getColumn();
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l860" id="l860">   860</a>         super.tab();
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l861" id="l861">   861</a>         offset += getColumn() - c;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l862" id="l862">   862</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l863" id="l863">   863</a> */
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l864" id="l864">   864</a>     public int mark() {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l865" id="l865">   865</a>         mkOffset = offset;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l866" id="l866">   866</a>         return super.mark(); 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l867" id="l867">   867</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l868" id="l868">   868</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l869" id="l869">   869</a>     public void rewind(int mark) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l870" id="l870">   870</a>         super.rewind(mark);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l871" id="l871">   871</a>         offset = mkOffset;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l872" id="l872">   872</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l873" id="l873">   873</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l874" id="l874">   874</a>     /*public int getOffset() {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l875" id="l875">   875</a>         return offset;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l876" id="l876">   876</a>     }*/
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l877" id="l877">   877</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l878" id="l878">   878</a>     int offset = 0;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l879" id="l879">   879</a>     int tokenStartOffset = 0;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l880" id="l880">   880</a>     int mkOffset = 0;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l881" id="l881">   881</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l882" id="l882">   882</a>     public void newline() 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l883" id="l883">   883</a>     {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l884" id="l884">   884</a>         super.newline();
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l885" id="l885">   885</a>         if (!isPreprocPending()) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l886" id="l886">   886</a>             setPreprocPossible(true);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l887" id="l887">   887</a>         }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l888" id="l888">   888</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l889" id="l889">   889</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l890" id="l890">   890</a>     private void deferredNewline() 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l891" id="l891">   891</a>     {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l892" id="l892">   892</a>         super.newline();
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l893" id="l893">   893</a>     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l894" id="l894">   894</a> }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l895" id="l895">   895</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l896" id="l896">   896</a> /* Comments: */
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l897" id="l897">   897</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l898" id="l898">   898</a> FORTRAN_COMMENT options { constText=true; } :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l899" id="l899">   899</a>     {lang == Language.FORTRAN &amp;&amp; (inputState.getColumn() == 1 &amp;&amp; (LA(2)=='\r' || LA(2)=='\n' || LA(2)==' ') || (flavor == Flavor.FORTRAN_FREE &amp;&amp; LA(1) == '!') )}?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l900" id="l900">   900</a>     ('!' | ('c'|'C') | '*')
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l901" id="l901">   901</a>     (~('\n' | '\r'))*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l902" id="l902">   902</a>     {$setType(FORTRAN_COMMENT);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l903" id="l903">   903</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l904" id="l904">   904</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l905" id="l905">   905</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l906" id="l906">   906</a> /* Operators: */
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l907" id="l907">   907</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l908" id="l908">   908</a> COMMA          options { constText=true; } : ',' ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l909" id="l909">   909</a> QUESTIONMARK   options { constText=true; } : '?' ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l910" id="l910">   910</a> SEMICOLON      options { constText=true; } : ';' ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l911" id="l911">   911</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l912" id="l912">   912</a> /*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l913" id="l913">   913</a> // DOT &amp; ELLIPSIS are commented out since they are generated as part of
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l914" id="l914">   914</a> // the Number rule below due to some bizarre lexical ambiguity shme.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l915" id="l915">   915</a> // DOT  :       '.' ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l916" id="l916">   916</a> // ELLIPSIS      : &quot;...&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l917" id="l917">   917</a> */
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l918" id="l918">   918</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l919" id="l919">   919</a> LPAREN  options { constText=true; }        : '(' 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l920" id="l920">   920</a>                     { 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l921" id="l921">   921</a>                         if (isFunLikeMacro()) {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l922" id="l922">   922</a>                             setFunLikeMacro(false);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l923" id="l923">   923</a>                             $setType(FUN_LIKE_MACRO_LPAREN);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l924" id="l924">   924</a>                         }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l925" id="l925">   925</a>                     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l926" id="l926">   926</a>                 ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l927" id="l927">   927</a> RPAREN options { constText=true; } : ')' ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l928" id="l928">   928</a> LSQUARE options { constText=true; }        : '[' ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l929" id="l929">   929</a> RSQUARE options { constText=true; }        : ']' ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l930" id="l930">   930</a> LCURLY	options { constText=true; }	: '{' ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l931" id="l931">   931</a> RCURLY	options { constText=true; }	: '}' ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l932" id="l932">   932</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l933" id="l933">   933</a> TILDE  options { constText=true; }    : '~' ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l934" id="l934">   934</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l935" id="l935">   935</a> FIRST_ASSIGN options { constText=true; } :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l936" id="l936">   936</a>     '=' ({$setType(ASSIGNEQUAL);}           //ASSIGNEQUAL     : '=' ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l937" id="l937">   937</a>     | '=' {$setType(EQUAL);});              //EQUAL           : &quot;==&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l938" id="l938">   938</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l939" id="l939">   939</a> FIRST_DIVIDE :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l940" id="l940">   940</a>     '/' ( {$setType(DIVIDE);}               //DIVIDE          : '/' ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l941" id="l941">   941</a>     | '=' {$setType(DIVIDEEQUAL);} )        //DIVIDEEQUAL     : &quot;/=&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l942" id="l942">   942</a>     | {(lang == Language.CPP || lang == Language.C)}? COMMENT {$setType(COMMENT);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l943" id="l943">   943</a>     | {lang == Language.CPP}? CPP_COMMENT {$setType(CPP_COMMENT);};
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l944" id="l944">   944</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l945" id="l945">   945</a> FIRST_STAR options { constText=true; } :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l946" id="l946">   946</a>     '*' ( {$setType(STAR);}                 //STAR            : '*' ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l947" id="l947">   947</a>     | '=' {$setType(TIMESEQUAL);});         //TIMESEQUAL      : &quot;*=&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l948" id="l948">   948</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l949" id="l949">   949</a> FIRST_MOD options { constText=true; } :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l950" id="l950">   950</a>     '%' ( {$setType(MOD);}                  //MOD             : '%' ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l951" id="l951">   951</a>     | '=' {$setType(MODEQUAL);}             //MODEQUAL        : &quot;%=&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l952" id="l952">   952</a>     | '&gt;' {$setType(RCURLY);}               //RCURLY          : &quot;%&gt;&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l953" id="l953">   953</a>     | ':' ( {isPreprocPending()}? {$setType(SHARP);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l954" id="l954">   954</a>         | {isPreprocPending()}? '%' ':' {$setType(DBL_SHARP);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l955" id="l955">   955</a>         | {!isPreprocPossible()}? {$setType(SHARP);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l956" id="l956">   956</a>         | {isPreprocPossible()}?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l957" id="l957">   957</a>             {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l958" id="l958">   958</a>                 $setType(PREPROC_DIRECTIVE);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l959" id="l959">   959</a>                 setPreprocPossible(false);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l960" id="l960">   960</a>                 setPreprocPending(true);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l961" id="l961">   961</a>                 setPPDefinedAllowed(true);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l962" id="l962">   962</a>             }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l963" id="l963">   963</a>             (options{greedy = true;}:Space|COMMENT)*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l964" id="l964">   964</a>             (  // lexer has no token labels
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l965" id="l965">   965</a>               (&quot;include&quot; PostPPKwdChar) =&gt; &quot;include&quot; { $setType(INCLUDE); setAfterInclude(true); setPPDefinedAllowed(false); } 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l966" id="l966">   966</a>             | (&quot;include_next&quot; PostPPKwdChar) =&gt; &quot;include_next&quot; { $setType(INCLUDE_NEXT); setAfterInclude(true); setPPDefinedAllowed(false); } 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l967" id="l967">   967</a>             | (&quot;define&quot; PostPPKwdChar) =&gt; &quot;define&quot; { $setType(DEFINE); setAfterDefine(true); setPPDefinedAllowed(false);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l968" id="l968">   968</a>             | (&quot;ifdef&quot; PostPPKwdChar) =&gt; &quot;ifdef&quot; { $setType(IFDEF); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l969" id="l969">   969</a>             | (&quot;ifndef&quot; PostPPKwdChar) =&gt; &quot;ifndef&quot; { $setType(IFNDEF); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l970" id="l970">   970</a>             | (&quot;if&quot; PostPPKwdChar) =&gt;  &quot;if&quot;   { $setType(IF); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l971" id="l971">   971</a>             | (&quot;undef&quot; PostPPKwdChar) =&gt; &quot;undef&quot;  { $setType(UNDEF); setPPDefinedAllowed(false); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l972" id="l972">   972</a>             | (&quot;elif&quot; PostPPKwdChar) =&gt; &quot;elif&quot;  { $setType(ELIF);  }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l973" id="l973">   973</a>             | (&quot;else&quot; PostPPKwdChar) =&gt;  &quot;else&quot; { $setType(ELSE); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l974" id="l974">   974</a>             | (&quot;endif&quot; PostPPKwdChar) =&gt; &quot;endif&quot; { $setType(ENDIF); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l975" id="l975">   975</a>             | (&quot;pragma&quot; PostPPKwdChar) =&gt; &quot;pragma&quot; { $setType(PRAGMA); setPPDefinedAllowed(false); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l976" id="l976">   976</a>             | (&quot;error&quot; PostPPKwdChar) =&gt; &quot;error&quot; { $setType(ERROR); } DirectiveBody
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l977" id="l977">   977</a>             | (&quot;line&quot; PostPPKwdChar) =&gt; &quot;line&quot; { $setType(LINE); } DirectiveBody
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l978" id="l978">   978</a>             | DirectiveBody)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l979" id="l979">   979</a>             // Do not need this here, can be skipped
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l980" id="l980">   980</a>             (options{greedy = true;}:Space)*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l981" id="l981">   981</a>         ));
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l982" id="l982">   982</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l983" id="l983">   983</a> FIRST_NOT options { constText=true; } :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l984" id="l984">   984</a>     '!' ( {$setType(NOT);}                  //NOT             : '!' ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l985" id="l985">   985</a>     | '=' {$setType(NOTEQUAL);});           //NOTEQUAL        : &quot;!=&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l986" id="l986">   986</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l987" id="l987">   987</a> FIRST_AMPERSAND options { constText=true; } :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l988" id="l988">   988</a>     '&amp;' ( {$setType(AMPERSAND);}            //AMPERSAND       : '&amp;' ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l989" id="l989">   989</a>     | '&amp;' {$setType(AND);}                  //AND             : &quot;&amp;&amp;&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l990" id="l990">   990</a>     | '=' {$setType(BITWISEANDEQUAL);});    //BITWISEANDEQUAL : &quot;&amp;=&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l991" id="l991">   991</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l992" id="l992">   992</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l993" id="l993">   993</a> /* Comments: */
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l994" id="l994">   994</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l995" id="l995">   995</a> protected COMMENT :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l996" id="l996">   996</a> 		&quot;/*&quot;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l997" id="l997">   997</a> 		( options {greedy=false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l998" id="l998">   998</a> 			EndOfLine {deferredNewline();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l999" id="l999">   999</a>                         | . )*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1000" id="l1000">  1000</a> 		&quot;*/&quot;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1001" id="l1001">  1001</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1002" id="l1002">  1002</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1003" id="l1003">  1003</a> protected CPP_COMMENT
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1004" id="l1004">  1004</a> 	:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1005" id="l1005">  1005</a> 		&quot;//&quot; ( '\\' EndOfLine {deferredNewline();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1006" id="l1006">  1006</a>                      |  ~('\n' | '\r')
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1007" id="l1007">  1007</a>                      )*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1008" id="l1008">  1008</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1009" id="l1009">  1009</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1010" id="l1010">  1010</a> FIRST_OR options { constText=true; } :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1011" id="l1011">  1011</a>     '|' ({$setType(BITWISEOR);}             //BITWISEOR       : '|' ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1012" id="l1012">  1012</a>     | '=' {$setType(BITWISEOREQUAL);}       //BITWISEOREQUAL  : &quot;|=&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1013" id="l1013">  1013</a>     | '|' {$setType(OR);});                 //OR              : &quot;||&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1014" id="l1014">  1014</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1015" id="l1015">  1015</a> FIRST_BITWISEXOR options { constText=true; } :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1016" id="l1016">  1016</a>     '^' ( {$setType(BITWISEXOR);}           //BITWISEXOR      : '^' ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1017" id="l1017">  1017</a>     | '=' {$setType(BITWISEXOREQUAL);} );   //BITWISEXOREQUAL : &quot;^=&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1018" id="l1018">  1018</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1019" id="l1019">  1019</a> FIRST_COLON options { constText=true; } :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1020" id="l1020">  1020</a>     ':' ( {$setType(COLON);}                //COLON   : ':' ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1021" id="l1021">  1021</a>     | ':' {$setType(SCOPE);}                //SCOPE   : &quot;::&quot;  ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1022" id="l1022">  1022</a>     | '&gt;' {$setType(RSQUARE);} );           //RSQUARE : &quot;:&gt;&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1023" id="l1023">  1023</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1024" id="l1024">  1024</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1025" id="l1025">  1025</a> FIRST_LESS :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1026" id="l1026">  1026</a>     ( 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1027" id="l1027">  1027</a>         // C++11 standard - 2.5 p3, bullet 2
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1028" id="l1028">  1028</a>         ({isCPlusPlus11()}? &quot;&lt;::&quot; ~(':'|'&gt;')) =&gt; '&lt;' {$setType(LESSTHAN);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1029" id="l1029">  1029</a>     | 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1030" id="l1030">  1030</a>         ('&lt;' (options{generateAmbigWarnings = false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1031" id="l1031">  1031</a>             {isAfterInclude()}? H_char_sequence ('&gt;')? {$setType(SYS_INCLUDE_STRING);setAfterInclude(false);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1032" id="l1032">  1032</a>             | '=' {$setType(LESSTHANOREQUALTO);}            //LESSTHANOREQUALTO     : &quot;&lt;=&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1033" id="l1033">  1033</a>             | '%' {$setType(LCURLY);}                       //LCURLY                : &quot;&lt;%&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1034" id="l1034">  1034</a>             | ':' {$setType(LSQUARE);}                      //LSQUARE               : &quot;&lt;:&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1035" id="l1035">  1035</a>             | {$setType(LESSTHAN);}                         //LESSTHAN              : &quot;&lt;&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1036" id="l1036">  1036</a>             | '&lt;' ({$setType(SHIFTLEFT);}                   //SHIFTLEFT             : &quot;&lt;&lt;&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1037" id="l1037">  1037</a>                    | '=' {$setType(SHIFTLEFTEQUAL);}))      //SHIFTLEFTEQUAL        : &quot;&lt;&lt;=&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1038" id="l1038">  1038</a>         )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1039" id="l1039">  1039</a>     );
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1040" id="l1040">  1040</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1041" id="l1041">  1041</a> /*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1042" id="l1042">  1042</a> DOLLAR options { constText=true; }  :  '$' ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1043" id="l1043">  1043</a> */
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1044" id="l1044">  1044</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1045" id="l1045">  1045</a> AT  options { constText=true; }     :  '@' ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1046" id="l1046">  1046</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1047" id="l1047">  1047</a> GRAVE_ACCENT options { constText=true; }:  '`';
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1048" id="l1048">  1048</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1049" id="l1049">  1049</a> FIRST_GREATER options { constText=true; } : 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1050" id="l1050">  1050</a>     '&gt;' ( {$setType(GREATERTHAN);}                  //GREATERTHAN           : &quot;&gt;&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1051" id="l1051">  1051</a>     | '=' {$setType(GREATERTHANOREQUALTO);}         //GREATERTHANOREQUALTO  : &quot;&gt;=&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1052" id="l1052">  1052</a>     | '&gt;' ( {$setType(SHIFTRIGHT);}                 //SHIFTRIGHT            : &quot;&gt;&gt;&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1053" id="l1053">  1053</a>             | '=' {$setType(SHIFTRIGHTEQUAL);}));   //SHIFTRIGHTEQUAL       : &quot;&gt;&gt;=&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1054" id="l1054">  1054</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1055" id="l1055">  1055</a> FIRST_MINUS options { constText=true; } :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1056" id="l1056">  1056</a>     '-' ( {$setType(MINUS);}                        //MINUS           : '-' ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1057" id="l1057">  1057</a>     | '=' {$setType(MINUSEQUAL);}                   //MINUSEQUAL      : &quot;-=&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1058" id="l1058">  1058</a>     | '-' {$setType(MINUSMINUS);}                   //MINUSMINUS      : &quot;--&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1059" id="l1059">  1059</a>     | '&gt;' ( {$setType(POINTERTO);}                  //POINTERTO       : &quot;-&gt;&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1060" id="l1060">  1060</a>             | '*' {$setType(POINTERTOMBR);}));      //POINTERTOMBR    : &quot;-&gt;*&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1061" id="l1061">  1061</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1062" id="l1062">  1062</a> FIRST_PLUS options { constText=true; } : 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1063" id="l1063">  1063</a>     '+' ( {$setType(PLUS);}             //PLUS            : '+' ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1064" id="l1064">  1064</a>     | '=' {$setType(PLUSEQUAL);}        //PLUSEQUAL       : &quot;+=&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1065" id="l1065">  1065</a>     | '+' {$setType(PLUSPLUS);});       //PLUSPLUS        : &quot;++&quot; ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1066" id="l1066">  1066</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1067" id="l1067">  1067</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1068" id="l1068">  1068</a> // Whitespace
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1069" id="l1069">  1069</a> Whitespace options {checkSkip=true;} :	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1070" id="l1070">  1070</a>                 { 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1071" id="l1071">  1071</a>                         $setType(Token.SKIP);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1072" id="l1072">  1072</a>                 }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1073" id="l1073">  1073</a>                 (	(' ' |'\t' | '\f') 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1074" id="l1074">  1074</a> 			// handle newlines
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1075" id="l1075">  1075</a> 		|	(	&quot;\r\n&quot;  {offset--;} // MS
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1076" id="l1076">  1076</a> 			|	'\r'    // Mac
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1077" id="l1077">  1077</a> 			|	'\n'    // Unix 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1078" id="l1078">  1078</a> 			)	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1079" id="l1079">  1079</a>                         { 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1080" id="l1080">  1080</a>                             if (isPreprocPending()) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1081" id="l1081">  1081</a>                                 $setType(END_PREPROC_DIRECTIVE);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1082" id="l1082">  1082</a>                                 clearPrepProcFlags();
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1083" id="l1083">  1083</a>                             }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1084" id="l1084">  1084</a>                             newline(); 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1085" id="l1085">  1085</a>                         }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1086" id="l1086">  1086</a> 			// handle continuation lines
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1087" id="l1087">  1087</a> 		|	'\\' 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1088" id="l1088">  1088</a>                         ( {$setType(BACK_SLASH);} |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1089" id="l1089">  1089</a>                             (	&quot;\r\n&quot; {offset--;} // MS
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1090" id="l1090">  1090</a>                             |	&quot;\r&quot;    // Mac
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1091" id="l1091">  1091</a>                             |	&quot;\n&quot;    // Unix 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1092" id="l1092">  1092</a>                             )	{$setType(Token.SKIP); deferredNewline();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1093" id="l1093">  1093</a>                         )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1094" id="l1094">  1094</a> 		)	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1095" id="l1095">  1095</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1096" id="l1096">  1096</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1097" id="l1097">  1097</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1098" id="l1098">  1098</a> EndOfLine
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1099" id="l1099">  1099</a> 	:	(	options{generateAmbigWarnings = false;}:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1100" id="l1100">  1100</a> 			&quot;\r\n&quot;  {offset--;}// MS
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1101" id="l1101">  1101</a> 		|	'\r'    // Mac
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1102" id="l1102">  1102</a> 		|	'\n'    // Unix
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1103" id="l1103">  1103</a> 		) 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1104" id="l1104">  1104</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1105" id="l1105">  1105</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1106" id="l1106">  1106</a> FIRST_QUOTATION :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1107" id="l1107">  1107</a>         '&quot;' (
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1108" id="l1108">  1108</a>             {isAfterInclude()}? 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1109" id="l1109">  1109</a>             Q_char_sequence '&quot;' 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1110" id="l1110">  1110</a>             {setAfterInclude(false);$setType(INCLUDE_STRING);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1111" id="l1111">  1111</a>             |STRING_LITERAL_BODY {$setType(STRING_LITERAL);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1112" id="l1112">  1112</a>             )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1113" id="l1113">  1113</a> ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1114" id="l1114">  1114</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1115" id="l1115">  1115</a> // preprocessor expressions
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1116" id="l1116">  1116</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1117" id="l1117">  1117</a> protected H_char_sequence : (~('&gt;'|'\r'|'\n'))* ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1118" id="l1118">  1118</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1119" id="l1119">  1119</a> protected Q_char_sequence : (~('\&quot;'|'\r'|'\n'))* ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1120" id="l1120">  1120</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1121" id="l1121">  1121</a> PREPROC_DIRECTIVE :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1122" id="l1122">  1122</a>          '#'
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1123" id="l1123">  1123</a>                 (   
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1124" id="l1124">  1124</a>                     {isPreprocPending()}? {$setType(SHARP);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1125" id="l1125">  1125</a>                  |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1126" id="l1126">  1126</a>                     {isPreprocPending()}? '#' {$setType(DBL_SHARP);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1127" id="l1127">  1127</a>                  | 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1128" id="l1128">  1128</a>                     {!isPreprocPossible()}? {$setType(SHARP);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1129" id="l1129">  1129</a>                  |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1130" id="l1130">  1130</a>                     {isPreprocPossible()}? 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1131" id="l1131">  1131</a>                     {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1132" id="l1132">  1132</a>                         $setType(PREPROC_DIRECTIVE);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1133" id="l1133">  1133</a>                         setPreprocPossible(false);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1134" id="l1134">  1134</a>                         setPreprocPending(true);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1135" id="l1135">  1135</a>                         setPPDefinedAllowed(true);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1136" id="l1136">  1136</a>                     }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1137" id="l1137">  1137</a>                     (options{greedy = true;}:Space|COMMENT)*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1138" id="l1138">  1138</a>                     (  // lexer has no token labels
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1139" id="l1139">  1139</a>                       (&quot;include&quot; PostPPKwdChar) =&gt; &quot;include&quot; { $setType(INCLUDE); setAfterInclude(true); setPPDefinedAllowed(false); } 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1140" id="l1140">  1140</a>                     | (&quot;include_next&quot; PostPPKwdChar) =&gt; &quot;include_next&quot; { $setType(INCLUDE_NEXT); setAfterInclude(true); setPPDefinedAllowed(false); } 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1141" id="l1141">  1141</a>                     | (&quot;define&quot; PostPPKwdChar) =&gt; &quot;define&quot; { $setType(DEFINE); setAfterDefine(true); setPPDefinedAllowed(false);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1142" id="l1142">  1142</a>                     | (&quot;ifdef&quot; PostPPKwdChar) =&gt; &quot;ifdef&quot; { $setType(IFDEF); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1143" id="l1143">  1143</a>                     | (&quot;ifndef&quot; PostPPKwdChar) =&gt; &quot;ifndef&quot; { $setType(IFNDEF); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1144" id="l1144">  1144</a>                     | (&quot;if&quot; PostPPKwdChar) =&gt;  &quot;if&quot;   { $setType(IF); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1145" id="l1145">  1145</a>                     | (&quot;undef&quot; PostPPKwdChar) =&gt; &quot;undef&quot;  { $setType(UNDEF); setPPDefinedAllowed(false); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1146" id="l1146">  1146</a>                     | (&quot;elif&quot; PostPPKwdChar) =&gt; &quot;elif&quot;  { $setType(ELIF);  }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1147" id="l1147">  1147</a>                     | (&quot;else&quot; PostPPKwdChar) =&gt;  &quot;else&quot; { $setType(ELSE); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1148" id="l1148">  1148</a>                     | (&quot;endif&quot; PostPPKwdChar) =&gt; &quot;endif&quot; { $setType(ENDIF); }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1149" id="l1149">  1149</a>                     | (&quot;pragma&quot; PostPPKwdChar) =&gt; &quot;pragma&quot; { $setType(PRAGMA); setPPDefinedAllowed(false); }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1150" id="l1150">  1150</a>                     | (&quot;error&quot; PostPPKwdChar) =&gt; &quot;error&quot; { $setType(ERROR); } DirectiveBody
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1151" id="l1151">  1151</a>                     | (&quot;line&quot; PostPPKwdChar) =&gt; &quot;line&quot; { $setType(LINE); } DirectiveBody
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1152" id="l1152">  1152</a>                     | DirectiveBody)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1153" id="l1153">  1153</a>                     // Do not need this here, can be skipped
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1154" id="l1154">  1154</a>                     (options{greedy = true;}:Space)*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1155" id="l1155">  1155</a>                 )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1156" id="l1156">  1156</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1157" id="l1157">  1157</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1158" id="l1158">  1158</a> /*protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1159" id="l1159">  1159</a> AfterPragma:DirectiveBody;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1160" id="l1160">  1160</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1161" id="l1161">  1161</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1162" id="l1162">  1162</a> AfterError:DirectiveBody;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1163" id="l1163">  1163</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1164" id="l1164">  1164</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1165" id="l1165">  1165</a> AfterLine:DirectiveBody;*/
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1166" id="l1166">  1166</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1167" id="l1167">  1167</a> // eat everything till the end of line
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1168" id="l1168">  1168</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1169" id="l1169">  1169</a> DirectiveBody
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1170" id="l1170">  1170</a>         :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1171" id="l1171">  1171</a> 		( 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1172" id="l1172">  1172</a>                         options{warnWhenFollowAmbig = false; }:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1173" id="l1173">  1173</a>                         '\\'
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1174" id="l1174">  1174</a>                         (	&quot;\r\n&quot;  {offset--;} // MS 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1175" id="l1175">  1175</a> 			|	&quot;\r&quot;     // MAC
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1176" id="l1176">  1176</a> 			|	&quot;\n&quot;     // Unix
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1177" id="l1177">  1177</a> 			)	{deferredNewline();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1178" id="l1178">  1178</a> 		|	~('\r' | '\n' )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1179" id="l1179">  1179</a> 		)*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1180" id="l1180">  1180</a>         ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1181" id="l1181">  1181</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1182" id="l1182">  1182</a> protected  Space : (options {combineChars=true;}:' ' | '\t' | '\f');
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1183" id="l1183">  1183</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1184" id="l1184">  1184</a> /* Literals: */
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1185" id="l1185">  1185</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1186" id="l1186">  1186</a> /*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1187" id="l1187">  1187</a>  * Note that we do NOT handle tri-graphs nor multi-byte sequences.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1188" id="l1188">  1188</a>  */
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1189" id="l1189">  1189</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1190" id="l1190">  1190</a> CHAR_LITERAL
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1191" id="l1191">  1191</a>         :   
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1192" id="l1192">  1192</a>             '\'' CHAR_LITERAL_BODY
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1193" id="l1193">  1193</a>         ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1194" id="l1194">  1194</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1195" id="l1195">  1195</a> protected CHAR_LITERAL_BODY
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1196" id="l1196">  1196</a>         :   
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1197" id="l1197">  1197</a> 		(       
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1198" id="l1198">  1198</a>                         '\\'                        
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1199" id="l1199">  1199</a>                         (   options{greedy=true;}:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1200" id="l1200">  1200</a>                             (	&quot;\r\n&quot; {offset--;} // MS 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1201" id="l1201">  1201</a>                             |	&quot;\r&quot;     // MAC
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1202" id="l1202">  1202</a>                             |	&quot;\n&quot;     // Unix
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1203" id="l1203">  1203</a>                             ) {deferredNewline();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1204" id="l1204">  1204</a>                         | 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1205" id="l1205">  1205</a>                             '\''
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1206" id="l1206">  1206</a>                         |   
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1207" id="l1207">  1207</a>                             '\\'    
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1208" id="l1208">  1208</a>                         )?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1209" id="l1209">  1209</a> 		|	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1210" id="l1210">  1210</a>                          ~('\'' | '\r' | '\n' | '\\')
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1211" id="l1211">  1211</a> 		)*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1212" id="l1212">  1212</a>             ('\'' (Suffix)? // correct ending of char literal
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1213" id="l1213">  1213</a>                 |  {LA(1)=='\r'||LA(1)=='\n'}? // error char literal doesn't have closing quote
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1214" id="l1214">  1214</a>             )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1215" id="l1215">  1215</a>         ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1216" id="l1216">  1216</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1217" id="l1217">  1217</a> protected STRING_LITERAL
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1218" id="l1218">  1218</a>         :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1219" id="l1219">  1219</a>             '&quot;' STRING_LITERAL_BODY            
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1220" id="l1220">  1220</a>         ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1221" id="l1221">  1221</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1222" id="l1222">  1222</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1223" id="l1223">  1223</a> protected STRING_LITERAL_BODY :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1224" id="l1224">  1224</a> 		(       
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1225" id="l1225">  1225</a>                         '\\'                        
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1226" id="l1226">  1226</a>                         (   options{greedy=true;}:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1227" id="l1227">  1227</a>                             (	&quot;\r\n&quot; {offset--;} // MS 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1228" id="l1228">  1228</a>                             |	&quot;\r&quot;     // MAC
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1229" id="l1229">  1229</a>                             |	&quot;\n&quot;     // Unix
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1230" id="l1230">  1230</a>                             ) {deferredNewline();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1231" id="l1231">  1231</a>                         | 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1232" id="l1232">  1232</a>                             '&quot;'
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1233" id="l1233">  1233</a>                         |   
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1234" id="l1234">  1234</a>                             '\\'    
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1235" id="l1235">  1235</a>                         )?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1236" id="l1236">  1236</a> 		|	
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1237" id="l1237">  1237</a>                          ~('&quot;' | '\r' | '\n' | '\\')
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1238" id="l1238">  1238</a> 		)*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1239" id="l1239">  1239</a>             ('&quot;' (Suffix)? // correct ending of string
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1240" id="l1240">  1240</a>                 |  {LA(1)=='\r'||LA(1)=='\n'}? // error string doesn't have closing quote
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1241" id="l1241">  1241</a>             )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1242" id="l1242">  1242</a>         ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1243" id="l1243">  1243</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1244" id="l1244">  1244</a> protected RAW_STRING_LITERAL
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1245" id="l1245">  1245</a>         :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1246" id="l1246">  1246</a>             '&quot;' RAW_STRING_LITERAL_BODY            
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1247" id="l1247">  1247</a>         ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1248" id="l1248">  1248</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1249" id="l1249">  1249</a> protected RAW_STRING_LITERAL_BODY 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1250" id="l1250">  1250</a> {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1251" id="l1251">  1251</a>     boolean end = false;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1252" id="l1252">  1252</a>     StringBuilder s1 = new StringBuilder();
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1253" id="l1253">  1253</a>     StringBuilder s2 = null; 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1254" id="l1254">  1254</a> }   
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1255" id="l1255">  1255</a>     :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1256" id="l1256">  1256</a>     ((~('&quot;' | '\r' | '\n' | '\\' | '\t' | '(' | ')') {s1.append(LA(0));} )*)
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1257" id="l1257">  1257</a>     '('
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1258" id="l1258">  1258</a>         (options{greedy=true;}:   
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1259" id="l1259">  1259</a>             (   &quot;\r&quot;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1260" id="l1260">  1260</a>                     (options{greedy=true;}: &quot;\n&quot; {offset--;} // MS 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1261" id="l1261">  1261</a>                     |   // MAC
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1262" id="l1262">  1262</a>                     )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1263" id="l1263">  1263</a>             |   &quot;\n&quot;     // Unix
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1264" id="l1264">  1264</a>             ) {deferredNewline();}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1265" id="l1265">  1265</a>         |	
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1266" id="l1266">  1266</a>                (')' (~('&quot;' | '\r' | '\n' | '\\' | '\t' | '(' | ')') )* ) =&gt;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1267" id="l1267">  1267</a>                 {s2 = new StringBuilder();}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1268" id="l1268">  1268</a>                 ')' (options{greedy=true;}: ~('&quot;' | '\r' | '\n' | '\\' | '\t' | '(' | ')') {s2.append(LA(0));})*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1269" id="l1269">  1269</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1270" id="l1270">  1270</a>                 ({ LA(1)=='&quot;' &amp;&amp; !s1.toString().equals(s2.toString())}? 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1271" id="l1271">  1271</a>                     '&quot;'
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1272" id="l1272">  1272</a>                 |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1273" id="l1273">  1273</a>                     {end = LA(1)=='&quot;';}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1274" id="l1274">  1274</a>                 )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1275" id="l1275">  1275</a>                 {s2 = null;}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1276" id="l1276">  1276</a>             | 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1277" id="l1277">  1277</a>                 ~('\r' | '\n' | '&quot;')                         
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1278" id="l1278">  1278</a>             |   
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1279" id="l1279">  1279</a>                 { !end }? '&quot;' 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1280" id="l1280">  1280</a>             
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1281" id="l1281">  1281</a>         )*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1282" id="l1282">  1282</a>     ('&quot;' (Suffix)? // correct ending of string
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1283" id="l1283">  1283</a>         |  {LA(1)=='\r'||LA(1)=='\n'}? // error string doesn't have closing quote
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1284" id="l1284">  1284</a>     )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1285" id="l1285">  1285</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1286" id="l1286">  1286</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1287" id="l1287">  1287</a> /*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1288" id="l1288">  1288</a>  * Handle the various escape sequences.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1289" id="l1289">  1289</a>  *
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1290" id="l1290">  1290</a>  * Note carefully that these numeric escape *sequences* are *not* of the
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1291" id="l1291">  1291</a>  * same form as the C language numeric *constants*.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1292" id="l1292">  1292</a>  *
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1293" id="l1293">  1293</a>  * There is no such thing as a binary numeric escape sequence.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1294" id="l1294">  1294</a>  *
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1295" id="l1295">  1295</a>  * Octal escape sequences are either 1, 2, or 3 octal digits exactly.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1296" id="l1296">  1296</a>  *
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1297" id="l1297">  1297</a>  * There is no such thing as a decimal escape sequence.
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1298" id="l1298">  1298</a>  *
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1299" id="l1299">  1299</a>  * Hexadecimal escape sequences are begun with a leading \x and continue
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1300" id="l1300">  1300</a>  * until a non-hexadecimal character is found.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1301" id="l1301">  1301</a>  *
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1302" id="l1302">  1302</a>  * No real handling of tri-graph sequences, yet.
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1303" id="l1303">  1303</a>  */
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1304" id="l1304">  1304</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1305" id="l1305">  1305</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1306" id="l1306">  1306</a> Escape:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1307" id="l1307">  1307</a> 	'\\'
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1308" id="l1308">  1308</a> 		('a' | 'b' | 'e' | 'f' | 'n' | 'r' | 't' | 'v' | '&quot;' | '\'' | '\\' | '?' |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1309" id="l1309">  1309</a>  /*deprecated escape symbols*/     '%' |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1310" id="l1310">  1310</a>                     ('0'..'3') (options{greedy=true;}: Digit)? (options{greedy=true;}: Digit)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1311" id="l1311">  1311</a> 		| ('4'..'7') (options{greedy=true;}: Digit)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1312" id="l1312">  1312</a> 		| 'x' (options{greedy=true;}: Digit | 'a'..'f' | 'A'..'F')+
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1313" id="l1313">  1313</a> 		)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1314" id="l1314">  1314</a> 	;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1315" id="l1315">  1315</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1316" id="l1316">  1316</a> /* Numeric Constants: */
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1317" id="l1317">  1317</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1318" id="l1318">  1318</a> protected Digit:	'0'..'9' ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1319" id="l1319">  1319</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1320" id="l1320">  1320</a> //protected Decimal:	('0'..'9')+ ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1321" id="l1321">  1321</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1322" id="l1322">  1322</a> protected Suffix:
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1323" id="l1323">  1323</a>     (
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1324" id="l1324">  1324</a>         (options {combineChars=true;} : 'a'..'z'|'A'..'Z'|'_') // '$' added for gcc support
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1325" id="l1325">  1325</a>         (options {combineChars=true;greedy=true;} : 'a'..'z'|'A'..'Z'|'_'|'0'..'9')* // '$' added for gcc support
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1326" id="l1326">  1326</a>     )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1327" id="l1327">  1327</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1328" id="l1328">  1328</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1329" id="l1329">  1329</a> protected Exponent:	('e' | 'E') ('+' | '-')? (Digit)* ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1330" id="l1330">  1330</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1331" id="l1331">  1331</a> //protected Vocabulary:	'\3'..'\377' ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1332" id="l1332">  1332</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1333" id="l1333">  1333</a> NUMBER
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1334" id="l1334">  1334</a>         :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1335" id="l1335">  1335</a>     (options {greedy=true;} :
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1336" id="l1336">  1336</a> 		( (Digit)+ ('.' | 'e' | 'E') )=&gt; (Digit)+
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1337" id="l1337">  1337</a> 		(options {greedy=true;} : '.' (Digit)* (options {greedy=true;} : Exponent)? {$setType(FLOATONE);} //Zuo 3/12/01
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1338" id="l1338">  1338</a> 		| Exponent                 {$setType(FLOATTWO);} //Zuo 3/12/01
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1339" id="l1339">  1339</a> 		)
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1340" id="l1340">  1340</a>                 (Suffix)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1341" id="l1341">  1341</a> 	|	'.'  (                  {$setType(DOT);}	//TODO: solve &quot;dot &amp; ellipsis&quot;! 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1342" id="l1342">  1342</a> 		| 	(Digit)+ (options {greedy=true;} : Exponent)?   
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1343" id="l1343">  1343</a>                                         {$setType(FLOATONE);} //Zuo 3/12/01
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1344" id="l1344">  1344</a>                         (Suffix)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1345" id="l1345">  1345</a> 		| '*' {$setType(DOTMBR);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1346" id="l1346">  1346</a>                 | {(LA(2)=='.')}? &quot;..&quot;  {$setType(ELLIPSIS);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1347" id="l1347">  1347</a>                 )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1348" id="l1348">  1348</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1349" id="l1349">  1349</a> 	|	'1'..'9' (Digit)*
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1350" id="l1350">  1350</a>                                         {$setType(DECIMALINT);}  
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1351" id="l1351">  1351</a>                 (Suffix)?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1352" id="l1352">  1352</a>         |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1353" id="l1353">  1353</a>                 (       '0'
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1354" id="l1354">  1354</a>                     (   ('x' | 'X') =&gt; ('x' | 'X') (options {greedy=true;} : 'a'..'f' | 'A'..'F' | Digit)*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1355" id="l1355">  1355</a>                                         {$setType(HEXADECIMALINT);}   
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1356" id="l1356">  1356</a>                     |	('b' | 'B') =&gt; ('b' | 'B') (options {greedy=true;} : '0'|'1')*
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1357" id="l1357">  1357</a>                                         {$setType(BINARYINT);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1358" id="l1358">  1358</a>                     |   ('0'..'7')*            
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1359" id="l1359">  1359</a>                                         {$setType(OCTALINT);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1360" id="l1360">  1360</a>                     )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1361" id="l1361">  1361</a>                 )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1362" id="l1362">  1362</a>                 (Suffix)?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1363" id="l1363">  1363</a>     )    
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1364" id="l1364">  1364</a>     ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1365" id="l1365">  1365</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1366" id="l1366">  1366</a> // Everything that can be treated lke ID
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1367" id="l1367">  1367</a> ID_LIKE:
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1368" id="l1368">  1368</a>         {isPreprocPending()}?
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1369" id="l1369">  1369</a>         ({isPPDefinedAllowed()}? &quot;defined&quot;)=&gt; &quot;defined&quot; 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1370" id="l1370">  1370</a>            ( 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1371" id="l1371">  1371</a>              (PostPPKwdChar | &quot;(&quot;) =&gt; {setAfterPPDefined(true); $setType(DEFINED);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1372" id="l1372">  1372</a>            | 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1373" id="l1373">  1373</a>                 {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1374" id="l1374">  1374</a>                     if (isAfterPPDefined()) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1375" id="l1375">  1375</a>                         setAfterPPDefined(false);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1376" id="l1376">  1376</a>                         $setType(ID_DEFINED);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1377" id="l1377">  1377</a>                     } else {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1378" id="l1378">  1378</a>                         $setType(IDENT); 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1379" id="l1379">  1379</a>                     }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1380" id="l1380">  1380</a>                 }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1381" id="l1381">  1381</a>            )
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1382" id="l1382">  1382</a>      |
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1383" id="l1383">  1383</a>         {!isAfterPPDefined()}?
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1384" id="l1384">  1384</a>         Identifier
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1385" id="l1385">  1385</a>         {
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1386" id="l1386">  1386</a>             if (isAfterDefine()) {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1387" id="l1387">  1387</a>                 setAfterDefine(false);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1388" id="l1388">  1388</a>                 if (LA(1) == '(') {
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1389" id="l1389">  1389</a>                     setFunLikeMacro(true);
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1390" id="l1390">  1390</a>                 }
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1391" id="l1391">  1391</a>             }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1392" id="l1392">  1392</a>             $setType(IDENT);
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1393" id="l1393">  1393</a>         }
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1394" id="l1394">  1394</a>      |  ('L' 'R' '&quot;') =&gt; 'L' 'R' RAW_STRING_LITERAL {$setType(STRING_LITERAL);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1395" id="l1395">  1395</a>      |  ('u' 'R' '&quot;') =&gt; 'u' 'R' RAW_STRING_LITERAL {$setType(STRING_LITERAL);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1396" id="l1396">  1396</a>      |  ('U' 'R' '&quot;') =&gt; 'U' 'R' RAW_STRING_LITERAL {$setType(STRING_LITERAL);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1397" id="l1397">  1397</a>      |  ('u' '8' 'R' '&quot;') =&gt; 'u' '8' 'R' RAW_STRING_LITERAL {$setType(STRING_LITERAL);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1398" id="l1398">  1398</a>      |  ('u' '8' '&quot;') =&gt; 'u' '8' STRING_LITERAL {$setType(STRING_LITERAL);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1399" id="l1399">  1399</a>      |
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1400" id="l1400">  1400</a>         // We have checked opposite above
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1401" id="l1401">  1401</a>         //{isAfterPPDefined()}? 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1402" id="l1402">  1402</a>         Identifier 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1403" id="l1403">  1403</a>         {setAfterPPDefined(false);$setType(ID_DEFINED);}
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1404" id="l1404">  1404</a>      |  'L' ( CHAR_LITERAL {$setType(CHAR_LITERAL);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1405" id="l1405">  1405</a>             | STRING_LITERAL {$setType(STRING_LITERAL);})
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1406" id="l1406">  1406</a>      |  'u' ( CHAR_LITERAL {$setType(CHAR_LITERAL);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1407" id="l1407">  1407</a>             | STRING_LITERAL {$setType(STRING_LITERAL);})
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1408" id="l1408">  1408</a>      |  'U' ( CHAR_LITERAL {$setType(CHAR_LITERAL);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1409" id="l1409">  1409</a>             | STRING_LITERAL {$setType(STRING_LITERAL);})
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1410" id="l1410">  1410</a>      |  'R' RAW_STRING_LITERAL {$setType(STRING_LITERAL);}
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1411" id="l1411">  1411</a> ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1412" id="l1412">  1412</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1413" id="l1413">  1413</a> // FAKE , just to get the correct type number for this token
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1414" id="l1414">  1414</a> protected ID_DEFINED : ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1415" id="l1415">  1415</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1416" id="l1416">  1416</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1417" id="l1417">  1417</a> Identifier      
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1418" id="l1418">  1418</a>         :
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1419" id="l1419">  1419</a>             // I think this check should have been done before
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1420" id="l1420">  1420</a>             //{ LA(1)!='L' || (LA(2)!='\'' &amp;&amp; LA(2) != '\&quot;') }? // L&quot;&quot; and L'' are StringLiterals/CharLiterals, not ID
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1421" id="l1421">  1421</a>             (
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1422" id="l1422">  1422</a>                 (options {combineChars=true;} : 'a'..'z'|'A'..'Z'|'_'|'$') // '$' added for gcc support
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1423" id="l1423">  1423</a> 		(options {combineChars=true;} : 'a'..'z'|'A'..'Z'|'_'|'0'..'9'|'$')* // '$' added for gcc support
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1424" id="l1424">  1424</a>             )
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1425" id="l1425">  1425</a>         ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1426" id="l1426">  1426</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1427" id="l1427">  1427</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1428" id="l1428">  1428</a> PostPPKwdChar: { !Character.isJavaIdentifierPart(LA(1)) }? | EndOfLine | { LA(1) == EOF_CHAR}? ;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1429" id="l1429">  1429</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1430" id="l1430">  1430</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1431" id="l1431">  1431</a> PostInclChar: PostPPKwdChar | '\&quot;' | '&lt;' ;
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1432" id="l1432">  1432</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1433" id="l1433">  1433</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1434" id="l1434">  1434</a> PostIfChar: { !Character.isJavaIdentifierPart(LA(1)) }?;
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1435" id="l1435">  1435</a> 
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1436" id="l1436">  1436</a> //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1437" id="l1437">  1437</a> //!! ALL NEW RULES MUST BE ADDED BEFORE THIS LINE !!
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1438" id="l1438">  1438</a> //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
</pre>
</div>
<div style="font-family:monospace" class="parity0">
<pre><a class="linenr" href="#l1439" id="l1439">  1439</a> protected
</pre>
</div>
<div style="font-family:monospace" class="parity1">
<pre><a class="linenr" href="#l1440" id="l1440">  1440</a> LAST_LEXER_FAKE_RULE : ;
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

