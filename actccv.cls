% Copyright (C) 2012,2014  Nicola Fontana <ntd at entidi.it>
% Copyright (C) 2014 Alison <alisonc@alisonc.net>
%
% This program can be redistributed and/or modified under
% the terms of the LaTeX Project Public License, either
% version 1.3 of this license or (at your option) any later
% version. The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all LaTeX distributions
% version 2005/12/01 or later.
%
% Based on the original idea by Alessandro Plasmati found at
% http://www.latextemplates.com/template/two-column-one-page-cv
%
% The most relevant changes from his work are:
%
% * this is a class, not a template document;
% * tccv is based on scrartcl (from Koma-script), not on article;
% * the fonts are selected from the PSNFSS collection, so no
%   custom font installation should be required;
% * heavily based the implementation on custom environments and
%   macros, so the document is much easier to read (and customize);
% * it is plain LaTeX/Koma-script, so the CV can be compiled
%   with the usual tools, latex and pdflatex included.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{actccv}
              [2014/12/02 v1.3
 Two Column Curriculum Vitae]

\LoadClassWithOptions{scrartcl}

\setcounter{secnumdepth}{-1}
\RequirePackage[hmargin=1.25cm,vmargin=1.25cm,twocolumn,columnsep=1.25cm]{geometry}
\RequirePackage{etoolbox,hyperref,needspace,pifont,tabularx,xcolor}


\pagestyle{empty}
\setlength\parindent{0pt}
\color[HTML]{303030} % Default foreground color
\definecolor{link}{HTML}{506060} % Hyperlinks
\hypersetup{colorlinks,breaklinks,urlcolor=link,linkcolor=link}
\setkomafont{disposition}{\color[HTML]{801010}}
\setkomafont{section}{\Large\bfseries}

% Defining name and contact info
\newcommand{\name}[1]{\gdef\@name{#1}}
\newcommand{\address}[1]{\gdef\@address{#1}}
\newcommand{\phone}[1]{\gdef\@phone{#1}}
\newcommand{\email}[1]{\gdef\@email{#1}}
\newcommand{\website}[1]{\gdef\@website{#1}}

% make résumé header by maketitle

\renewcommand\maketitle{%
    \twocolumn[%
    \begin{center}
	\vskip-\lastskip%
	{\usekomafont{part}\@name} \medskip \\ 
	\scriptsize \@address \hspace{8pt} $\bullet$ \hspace{8pt} \@phone \hspace{8pt} $\bullet$ \hspace{8pt} \@email \hspace{8pt} $\bullet$ \hspace{8pt} \href{http://\@website}{\@website}
	\bigskip
    \end{center}]}


% Allow conditionals based on the job name. This can usually be set
% from a command-line argument: check fausto.en.tex for an example.
%
% |[
% \ifjob{jobname}{content if matches}{content if does not match}
% ]|
\newcommand\ifjob[3]{%
    \edef\JOBNAME{\jobname}%
    \edef\PIVOT{\detokenize{#1}}%
    \ifdefstrequal{\JOBNAME}{\PIVOT}{#2}{#3}%
}

% Renders a personal data box:
%
% |[
% \personal[optional: web site without scheme (no http:// prefix)]
%          {address}{phone number}{email}
% ]|
\newcommand\personal[4][]{%
    \newcommand\SYMBOL[1]{\raisebox{-2pt}{\Large\ding{##1}}}%
    \needspace{0.5\textheight}%
    \newdimen\boxwidth%
    \boxwidth=\dimexpr\linewidth-2\fboxsep\relax%
    \colorbox[HTML]{F5DD9D}{%
    \begin{tabularx}{\boxwidth}{X}
    {#2}\smallskip\\
    {#3}\smallskip\\
    \href{mailto:#4}{#4}
    \ifstrempty{#1}{}{\smallskip\\ \href{http://#1}{#1}}
    \end{tabularx}}}

% Every \item can be followed by one or more paragraphs
% of description:
%
% |[
% \item{date range}{company}{role}
%
% Description of what achieved during this application.
% ]|
\newenvironment{eventlist}{%
    \newcommand*\inskip{}
    \renewcommand\item[3]{%
	\inskip%
	{\raggedleft\textsc{##1}\\[1pt]}
	\ifstrempty{##2}{}{##2\\[2pt]}
	{\Large\textit{##3}}
	\medskip
	\renewcommand\inskip{\bigskip}}}
    {\bigskip}

% Use only \item inside this environment: no other macros
% are allowed:
%
% |[
% \item[optional: what has been achieved]{years}{subject}{notes}
% ]|
\newenvironment{yearlist}{%
    \renewcommand\item[4][]{%
	\textsc{##2} & \textbf{##3} \\
	\ifstrempty{##1}{}{& \textsc{##1} \\}
	& \textit{##4}\medskip\\}
    \tabularx{\linewidth}{rX}}
    {\endtabularx}


% Use only \item inside this environment: no other macros
% are allowed:
%
% |[
% \item{fact}{description}
% ]|
\newenvironment{factlist}{%
    \newdimen\unbaseline
    \unbaseline=\dimexpr-\baselinestretch\baselineskip\relax
    \renewcommand\item[2]{%
	\textsc{##1} & {\raggedright ##2\medskip\\}\\[\unbaseline]}
    \tabularx{\linewidth}{rX}}
    {\endtabularx}
%%
%% End of file `tccv.cls'.
