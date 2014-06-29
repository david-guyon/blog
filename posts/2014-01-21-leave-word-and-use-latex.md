---
title: Leave Word and use LaTeX 
tags: LaTeX 
description: Introduction to LaTeX
---
<img src="/files/write_latex.png" title="Un immense paquet de chips" style="width: 150px; float: right; margin-left: 15px; margin-bottom: 15px;" />

I remember that day when Mr. Word told me “_You’ve got 22 days left_”, that’s when I really started thinking that using LaTeX could be a nice idea. Here I am to present you my transition.

###Why LaTeX?

You want a report that suits various publications with math equations, tables or something specific because of your working area? LaTeX is a very good choice as you will see in the rest of this article.  

If you are looking for a tool to write a short document, if you have the habit to use many different fonts, colors, then maybe Mr. Word is more suitable for you. 

Firstly, LaTeX is free. You won’t pay hundreds of euros/dollars/pounds to create a neat document. Nobody will force you to use a specific text editor, you are free to use the one you like. Perhaps you will need to generate a graph or something depending on a particular application ; with LaTeX you will find a way to do it. LaTeX is extensible and plenty of free add-ons are available all around the web, each offering new interesting features. And don’t worry, if you don’t find what you are looking for, or if you just need some tips, a large community is ready to come to your help. 

###Installation

Let’s start from scratch. Say you are using a Linux operating system, you will need some tools so you can start your first LaTeX report. 

In fact, you only need two things to start: the LaTeX tool and a text editor. To install the LaTeX tool on Ubuntu, open a terminal and write `sudo apt-get install texlive` for a minimal installation. For a more complete installation, you would prefer to install the _texlive-latex-extra_ package. For ArchLinux users, write `yaourt texlive` in your favorite console and select the packages you would like to install. Then you need a text editor. Some of you will prefer to use something with builtin compilation tools and other hardcore users would prefer to use Vim and compile their document with a command line on a terminal. You're free to choose the way you like. In this tutorial I will suppose you're lazy and that you would like to use a full features one like _texmaker_. To install the guy, `sudo apt-get install texmaker` (`yaourt -S texmaker` on ArchLinux). 

<img src="/files/latex_doc.png" title="Un immense paquet de chips" style="display: block; margin-right: auto; margin-left: auto;" />

Before we continue, I give you this [blog-post.tex](/files/blog-post.tex) file as a sandbox and also the [blog-post.pdf](/files/blog-post.pdf) so you can see how it looks.

###The basics

Here we go. Start TexMaker and let’s write our first article. Open a new document (Ctrl+n) and copy/paste the block below. I’ll explain what it means right after. 

<pre class="prettyprint lang-tex">
\documentclass[11pt]{scrartcl}

% Configuration
\usepackage[utf8]{inputenc}
\usepackage{fixltx2e}
\usepackage{xspace}
\usepackage{microtype}
\usepackage[l2tabu,abort]{nag}
\usepackage[T1]{fontenc}
\usepackage{lmodern}

\begin{document}
Hello world!
\end{document}
</pre>

  Firstly, _scrartcl_ means we’re going to write an article with European rules (A4 paper, etc). To write a report, use _scrreprt_; for a book, use _scrbook_; and for a letter, use _scrlettr_. If you’d prefer to write a document with American rules, use _article_, _report_, _book_ or _letter_ instead of the ones I just presented. I usually use 11pt but feel free to try and use what looks better to you.

  Secondly, we have the configuration of our document. The _inputenc_ package allows us to encode our file in utf8. The _fixltx2e_ package is used to fix few bugs with LaTeX. I don’t know much about it so, just use it! The _xspace_ package will scan your document during the render to put spaces or not depending on the following character. I don’t know much about the _microtype_ package except that it’s used to make your document neater. We use _l2tabu_ and _abort_ in the _nag_ package to check for common mistakes and get some hints in what to use instead. The _fontenc_ package allows you to use more characters  ([these](http://www.micropress-inc.com/fonts/encoding/t1.htm) instead of only [these](http://www.micropress-inc.com/fonts/encoding/ot1.htm)). And the last one, the _lmodern_ package. It’s like a library of fonts with a good render. It also gives you some mathematical symbols. 

  Finally, we can start writing our document between the `\begin{document}` and the `\end{document}` tags because that’s all we need as configuration so far. 

###Essential tools

Let’s be cool and use some tools. In this section, I’ll present you a wee bit of all the essential tools you need to master for your first document. 

####Document title

<pre class="prettyprint lang-tex">
\author{Jake The Dog \and David Guyon}
\date{January 14th, 2013}
\title{LaTeX Time\\Come on, grab your friends!}
\maketitle
</pre>

Do I really need to explain that? LaTeX is so clean and so easy to handle. Let’s move on!

####Abstract

You need to write an abstract? Just enclose it with the begin and end _abstract_ tags like this: 

<pre class="prettyprint lang-tex">
\begin{abstract}
Our goal was to become programmers, so we started drinking coffee and staring at our screen but instead we became crazy and blind. How do they do that? In this article, we present you our research about how amazing are programmers and how they will save the world.
\end{abstract}
</pre>

####Take a moment, to write a comment

Writing comments is pretty easy in LaTeX. Put a percent symbol at the beginning of a line and it becomes a comment! Feel free to use them, they will save your time. 

<pre class="prettyprint lang-tex">
% Sadly we never use enough comments :/
</pre>

####Titles

In LaTeX, a title is used to declare a section and also represent a hierarchy. Here’s the list of available titles from highest to lowest hierarchy:

<pre class="prettyprint lang-tex">
\section{Main title}
\subsection{Less important title}
\subsubsection{Baby title}
</pre>

####Bold and italic

<pre class="prettyprint lang-tex">
\textbf{Quick} and \textit{clear}. 
</pre>

####Lists

Need a bulleted list or an enumerated list ? Use the _itemize_ or the _enumerate_ tag and add as much items as you need. 

<pre class="prettyprint lang-tex">
\begin{itemize}
\item First item
\item Second item
\end{itemize}

\begin{enumerate}
\item An enumerated item
\item Another one
\end{enumerate}
</pre>

####Columns

Add the _multicol_ package in your header, `\usepackage{multicol}`, and then use it like this in your document : 

<pre class="prettyprint lang-tex">
\begin{multicols}{2}
The theme song of the TV show Adventure Time sounds like this : "Adventure time, c'mon grab your friends. We'll go to very distant lands. With Jake the Dog, and Finn the Human, the fun will never end. It's adventure time." This is the kind of song which could stay in your head a whole day and could freeze your mind because of its addictivity.
\end{multicols}
</pre>

####Greek symbols

Sometimes you’ll need Greek symbols in your document. Some of them are already available but you could, as I did, need some which are not implemented. My solution to this problem was to use the _textgreek_ package. Add this line to your configuration, `\usepackage{textgreek}` and then use it like this: 

<pre class="prettyprint lang-tex">
\textsigma = \textrho\textOmega + \textPhi
</pre>

If you don’t like the font, you can choose between three different fonts (cbgreek, euler and artemisia) by defining it during the import : `\usepackage[euler]{textgreek}`. 

####For mathematics

To be able to use mathematical equations in your documents, you need to import this package : `\usepackage{mathtools}`. I won’t explain how to use this package because it would take days and also because I’m clearly not the one who could give you advices about it! 
Just for the fun of it, an example:

<pre class="prettyprint lang-tex">
\begin{equation}
E \neq m c^3
\end{equation}

\begin{equation}
E = m c^2
\end{equation}

\begin{equation}
c \approx 3.00\times 10^{8}\,\mathrm{m}/\mathrm{s}
\end{equation}

\[
A \xLeftarrow[under]{over} B
\]

\[
\begin{bsmallmatrix}a & -b \\ -c & d \end{bsmallmatrix}
\begin{bsmallmatrix*}[r] a & -b \\ -c & d \end{bsmallmatrix*}
\]
</pre>

####French documents

You’re probably french and I know I already bother you by making you read an english article so, at least, I’ll give you the only tool you need to write french documents: `\usepackage[frenchb]{babel}`. 
Try the following example with and without the import: 

<pre>
La 1\iere fois que j'ai écrit un document en \LaTeX, la température était de 22\degres C. En France, on écrit les noms de famille en majuscule comme ceci, \bsc{Guyon} David et nous n'utilisons pas "ceci" mais \og cela \fg. 
</pre>

###Specific application

####For programming languages report 

Remember that time when you were writing a report with Mr. Word and your teacher wanted you to put the source code in the report? Always tricky and awful to accomplish! That now belongs to the past thanks to the _listings_ package. Put the following code in your configuration: 

<pre class="prettyprint lang-tex">
\usepackage{listings}
\usepackage{xcolor}
\lstset{
    numbers=left,
    backgroundcolor=\color{gray!10},
    frame=single,
    tabsize=2,
    rulecolor=\color{black!30},
    breaklines=true,
    breakatwhitespace=true,
    framextopmargin=2pt,
    framexbottommargin=2pt,
    aboveskip=4pt,
    belowskip=3pt,
    captionpos=b,
    language=Java,
}
</pre>

Let’s try this out! 

<pre class="prettyprint lang-tex">
\begin{lstlisting}[caption=Interface \textit{Command}]
public abstract interface Command {
  public abstract void execute();
}
\end{lstlisting}
</pre>

####For a report about semantic

Give a smile to your teacher with a neat semantic equation thanks to the _semantic_ package : `\usepackage{semantic}`. Here’s a quick example: 

<pre class="prettyprint lang-tex">
\begin{align*}
\inference[Séquence ]
{ $< c, $\sigma$ > $->${*} $\sigma$'$ }
{ $< c; c', $\sigma$ > $-->$ < c', $\sigma$'>$}
\end{align*}
</pre>

###Write your CV in LaTeX
It's probably the thing I like the most with LaTeX. You can actually create your whole CV very easily, with a professional design without doing anything rather than filling blanks for you personal information, your studies and professional experiences. 

_This section should be written soon..._

###Sources 

  - [Latex community](http://www.latex-community.org)
  - [Mathtools package](http://www.ctan.org/pkg/mathtools)
  - [Textgreek package](http://www.ctan.org/pkg/textgreek)
  - [Listings package](http://www.ctan.org/pkg/listings)
  - [Babel package](http://www.ctan.org/pkg/babel-french)
  - [Semantic package](http://www.ctan.org/pkg/semantic)
  - [Multicol package](http://www.ctan.org/pkg/multicol)
  - [Best place to find information about a package](http://www.ctan.org)

PS: if you think that something is missing, wrong or incomplete, please, tell me. And if you would like me to talk about something specific, it would be a pleasure to do so. 
