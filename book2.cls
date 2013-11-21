\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{book2}[2013/11/21 A slightly more modern looking version of 'book', by Martin Loetzsch]
\LoadClass[11.5pt]{book}

\DeclareOption{draft}{\PassOptionsToPackage{\CurrentOption}{graphicx}}
\ProcessOptions


\RequirePackage[paperwidth=170mm,paperheight=240mm]{geometry}

\RequirePackage{setspace}
\RequirePackage{color}
\RequirePackage[utf8]{inputenc}
\RequirePackage{fancyvrb}
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage[pdftex]{graphicx}
\RequirePackage{rotating}
\RequirePackage{scrextend}
\RequirePackage{fancyhdr}



\definecolor{linkcolor}{rgb}{0,0,0.6}



\RequirePackage[final,pdftex,pagebackref,bookmarks=true,linktocpage=false,
colorlinks=true,bookmarksopen=true,bookmarksnumbered=true,citecolor=linkcolor,
urlcolor=linkcolor,linkcolor=linkcolor,bookmarksopenlevel=1,pdfstartview=FitH,
pdfdisplaydoctitle=true,pdfpagelayout=TwoPageLeft]{hyperref}

\let\oldbackref\backref
\renewcommand\backref[1]{\hskip2mm\itshape{(\oldbackref{#1})}}




%-------------------------------------------------------------------------------------
% layout
%-------------------------------------------------------------------------------------

\setlength{\headheight}{30pt}
\setlength{\topmargin}{-40pt}
\setlength{\oddsidemargin}{0mm}
\setlength{\evensidemargin}{0mm}
\setlength{\headsep}{20pt}
\setlength{\textheight}{550pt}
\setlength{\footskip}{0pt}


\ProcessOptions\relax

\setlength{\parindent}{5mm}
\setcounter{bottomnumber}{5}

\setlength{\skip\footins}{1cm}

\frenchspacing
\tolerance=500
\predisplaypenalty=0
\clubpenalty=10000
\widowpenalty=10000


%-------------------------------------------------------------------------------------
% chapter & section headings
%-------------------------------------------------------------------------------------

\setcounter{secnumdepth}{5}

\fancypagestyle{plain}{%
\fancyhf{}
\fancyfoot[RO,LE]{\thepage}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0.4pt}
}

\fancypagestyle{custom}{%
\fancyhf{}
\fancyhead[RO,LE]{ \thepage }
\fancyhead[RE, LO] {\nouppercase{\rightmark}}
%\fancyfoot[RO,LE]{\thepage}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}
}


\newcommand{\inparagraph}[1]{\vspace{0.3cm}\noindent \textbf{#1.}{}}


%-------------------------------------------------------------------------------------
% page headings
%-------------------------------------------------------------------------------------
\fancypagestyle{custom}{%
\fancyhf{}
\fancyhead[RO,LE]{ \thepage }
\fancyhead[RE, LO] {\nouppercase{\rightmark}}
%\fancyfoot[RO,LE]{\thepage}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}
}

\def\x{@{\extracolsep{\fill}}}
\def\toprule{\\[-5.5pt]\Hline\\[-3.5pt]}
\def\colrule{\\[-7.5pt]\hline\\[-5pt]}
\def\botrule{\\[-7.7pt]\Hline}
\def\crule#1{\\[-9.5pt]#1\\[-2.5pt]}



\pagestyle{custom}


%-------------------------------------------------------------------------------------
% table of contents
%-------------------------------------------------------------------------------------

\setcounter{tocdepth}{5}


%-------------------------------------------------------------------------------------
% bibliography
%-------------------------------------------------------------------------------------

\RequirePackage[round,sort&compress]{natbib}
\bibliographystyle{bibliography}
\pagestyle{empty}

\renewcommand{\bibsection}{\chapter*{References}}
\let\oldBibliography\bibliography

\renewcommand\bibliography[1] {
  \begin{singlespace}
    \oldBibliography{#1}
  \end{singlespace}
}


%-------------------------------------------------------------------------------------
% smart figures
%-------------------------------------------------------------------------------------
\newcommand{\makeCaption}[2]{{\sffamily\slshape\scriptsize#1: #2}}

\newcommand{\figurebeginhook}{}

\let\oldfigure\figure
\let\endoldfigure\endfigure
\newlength{\captionwidth}


\renewenvironment{figure}[1][tbp]{
  \newbox\figurebox
  \let\captioncontent\@undefined
  \let\labelcontent\@undefined
  \begin{oldfigure}[#1]
    \figurebeginhook\sffamily\tiny\setbox\figurebox\hbox\bgroup\ignorespaces%
    \def\label##1{\gdef\labelcontent{##1}}%
    \def\caption##1{\gdef\captioncontent{##1}}%
  }
  {
    \egroup
    \def\boxwidth{\wd\figurebox}
    \setlength\captionwidth{119.2mm}
    \addtolength{\captionwidth}{-\boxwidth}
    \addtolength{\captionwidth}{-0.3cm}
    \let\@makecaption\makeCaption
    \ifdim\boxwidth<0.77\textwidth
    \parbox[t]{\captionwidth}{\vskip-\ht\figurebox
      \caption{\captioncontent}\label{\labelcontent}
    }\hskip5mm\vbox{\hsize\wd\figurebox \usebox{\figurebox}}
    \else
    \hskip1.5mm\centerline{\usebox{\figurebox}}
    \vskip1mm
    \caption{\captioncontent}\label{\labelcontent}
    \fi
  \end{oldfigure}
}


\newcommand\gnuplotfigure[1]{%
  \parbox{86.0mm}{\vspace{-3.0mm}\includegraphics[width=86.0mm]{#1}}}


\newcounter{subfigure}

\newcommand{\startfiguregroup}{
  \setcounter{subfigure}{0}
  \addtocounter{figure}{1}
  \renewcommand{\figurebeginhook}{
    \addtocounter{figure}{-1}
    \addtocounter{subfigure}{1}
  }
  \renewcommand{\thefigure}{\thechapter.\arabic{figure}\alph{subfigure}}
}

\newcommand{\stopfiguregroup}{
  \renewcommand{\figurebeginhook}{}
  \renewcommand{\thefigure}{\thechapter.\arabic{figure}}
}


%-------------------------------------------------------------------------------------
% a special environment for measures
%-------------------------------------------------------------------------------------
\definecolor{shadecolor}{gray}{.80}

\RequirePackage{float}

\newcommand\floatc@measure[2]{}
\newcommand\fs@measure{\let\@fs@capt\floatc@measure
  \def\@fs@pre{\setbox\@currbox\vbox{\hbadness10000
      \hbox to\hsize{\textcolor{shadecolor}{\vrule width 2.5mm}\kern-3mm\box\@currbox}}}%
  \def\@fs@post{}%
  \def\@fs@mid{}\let\@fs@iftopcapt\iftrue}
 
\floatstyle{measure}
\newfloat{measuref}{thb}{msr}[chapter]
\floatname{measuref}{Measure}

\newenvironment{measure}[3][thb]{
  \begin{measuref}[#1]
    \caption{#2}\label{#3}
    \vspace{1.5mm}
    \leftskip=5mm
    \renewcommand{\baselinestretch}{1.3}
    \itshape\footnotesize\sffamily{Measure \themeasuref : #2}\par\vspace{2mm}}
    {\vspace{1mm}%
    \end{measuref}}

\newcommand{\listofmeasures}{\listof{measuref}{List of Measures}}


%-------------------------------------------------------------------------------------
% verbatim
%-------------------------------------------------------------------------------------

\let\orig@verbatim\verbatim
\let\endorig@verbatim\endverbatim
\renewenvironment*{verbatim}
	{\begin{orig@verbatim}\begin{singlespace}}
	{\end{singlespace}\end{orig@verbatim}}


\newenvironment{verbatim+}
{\vspace{-0.5cm}\singlespace\Verbatim[codes={\catcode`\$=3},commandchars=\\\{\},fontfamily=courier,fontsize=\small,samepage=true]}
{\endVerbatim}



\endinput

