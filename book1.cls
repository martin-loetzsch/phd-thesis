\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{book1}[2013/11/21 A slightly more modern looking version of 'book', by Martin Loetzsch]
\LoadClass[11.5pt]{book}

\DeclareOption{draft}{\PassOptionsToPackage{\CurrentOption}{graphicx}}
\ProcessOptions

\RequirePackage{palatino}
\renewcommand{\ttdefault}{cmtt}

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

\definecolor{headline}{rgb}{0.2,0.2,0.2}


\renewcommand{\@part}[2][?]{
  \markboth{}{} 
  \refstepcounter{part}
  \thispagestyle{empty}
  \addcontentsline{toc}{part}{Part \thepart\hspace{1.3em}#1}%
  \begin{flushleft}
    \bfseries\sffamily\huge{\color{headline}\partname~\thepart\vskip9mm
    \fontsize{14mm}{12mm}\selectfont{#2}\label{p:\thepart}}
  \end{flushleft}
  \clearpage
  \thispagestyle{empty}}


\newcommand{\startChapterHeading}{%
  \noindent\rule[-4cm]{\textwidth}{0.4mm}\vspace{5mm}
}

\newcommand{\finishChapterHeading}[1]{

  \vspace{5mm}%
  \noindent\rule[2cm]{\textwidth}{0.4mm}%
  \chaptermark{#1}%
  \sectionmark{}%
  \pagestyle{headings}%
  \thispagestyle{empty}%
  \@xsect{2mm}}

\renewcommand{\@chapter}[2][?] {
  \cleardoublepage
  \refstepcounter{chapter}
  \startChapterHeading
  \begin{flushleft}
    \sffamily\Large{\color{headline} Chapter \thechapter\vskip7mm%
    {\sffamily\bfseries\huge #1}}
  \end{flushleft}
  \finishChapterHeading{#1}
  \addcontentsline{toc}{chapter}{\protect\numberline{\thechapter} #1}%
}

\renewcommand{\@schapter}[1]{%        % for chapter*{...}
  \cleardoublepage
  \refstepcounter{chapter}
  \startChapterHeading
  \noindent{\sffamily\bfseries\Huge{\color{headline} #1}}%
  \finishChapterHeading{#1}
  \addcontentsline{toc}{chapter}{\protect\numberline{} #1}%
}

% section headings
\renewcommand\section[1]{
  \sectionmark{#1}
  \pagebreak[3]
  \addvspace{10mm}
  \refstepcounter{section}
  \addcontentsline{toc}{section}{\protect\numberline{\thesection} #1}%
  \noindent\parbox{\textwidth}{\rule{\textwidth}{0.2mm}\vspace{1.5mm}%
    {\singlespace\normalfont\sffamily\large\bfseries{\color{headline} \thesection\hspace{4mm}#1}}
    \vspace{-1.5mm}
    
    \rule{\textwidth}{0.2mm}}%
  \sectionmark{#1}%
  \@xsect{10mm}
  \@afterindentfalse}

% subsection headings
\renewcommand\subsection[1]{
  \pagebreak[3]
  \addvspace{10mm}
  \refstepcounter{subsection}
  \addcontentsline{toc}{subsection}{\protect\numberline{\thesubsection} #1}%
  \noindent\parbox{\textwidth}{%
    
    {\singlespace\normalfont\sffamily\bfseries{\color{headline} \thesubsection\hspace{4mm}#1}}}%
  \@xsect{5mm}
  \@afterindentfalse}

% subsubsection headings
\renewcommand\subsubsection[1]{
  \pagebreak[3]
  \addvspace{15mm}
  \@startsection {subsubsection}{4}{\z@}{0mm}{7mm}{\singlespace\normalfont\sffamily}{#1}
  \@afterindentfalse}


\newcommand{\inparagraph}[1]{\vspace{0.3cm}\noindent \textbf{#1.}{}}


%-------------------------------------------------------------------------------------
% page headings
%-------------------------------------------------------------------------------------
\renewcommand{\chaptermark}[1]{%
  \markboth{\normalfont\sffamily #1}{}}
\renewcommand{\sectionmark}[1]{%
  \markright{\normalfont\sffamily #1}}

\def\ps@headings{%
  \let\@mkboth\@gobbletwo
  \let\@evenfoot\@empty
  \let\@oddfoot\@empty
  \def\@oddhead{\sf\footnotesize\hfil\rightmark~~\thepage}
  \def\@evenhead{\sf\footnotesize\thepage~~\leftmark\hfil}}


%-------------------------------------------------------------------------------------
% table of contents
%-------------------------------------------------------------------------------------

\renewcommand\tableofcontents{%
  \startChapterHeading
  \noindent{\sffamily\bfseries\Huge Contents}%
  \finishChapterHeading{Contents}
  \@starttoc{toc}%
}
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

