\ProvidesClass{resume}
\LoadClass[10pt, letterpaper]{article}

\RequirePackage[letterpaper, margin=0.5in]{geometry}
\RequirePackage{hyperref}
\RequirePackage{titlesec}
\RequirePackage{xparse}
\RequirePackage{fontawesome5}
\RequirePackage{multirow}
\RequirePackage{enumitem}
\RequirePackage[T1]{fontenc}
\RequirePackage{fontspec}

\setmainfont{Lato}
\pagestyle{empty}

\titleformat{\section}
{\uppercase}
{}
{0em}
{}

\hypersetup{
  colorlinks = true,
  linkcolor = blue,
  urlcolor  = blue,
  citecolor = blue,
  anchorcolor = blue
}

\setlist[itemize]{itemsep=0em}

\newcommand*{\email}[1]{\href{mailto:#1}{\texttt{#1}}}
\newcommand*{\github}[1]{\href{https://github.com/#1}{\texttt{#1}}}
\newcommand*{\linkedin}[1]{\href{https://linkedin.com/in/#1}{\texttt{#1}}}
\newcommand*{\location}[1]{#1}
\newcommand*{\website}[1]{\href{https://#1}{\texttt{#1}}}

\NewDocumentCommand{\header}{m m m m m m}{
  \noindent
  \begin{tabular*}{\textwidth}{@{}l@{\extracolsep{\fill}}c@{\extracolsep{1em}}l@{}}
    \multirow{5}*{\centering{\textbf{\Huge{\uppercase{#1}}}}}  &  \faMapMarker* & \location{#2} \\
                                                                &  \faDesktop{} & \website{#3} \\
                                                                &  \faAt{} & \email{#4} \\
                                                              &  \faGithub{} & \github{#5} \\
                                                              &  \faLinkedin{} & \linkedin{#6} \\
  \end{tabular*}
}

\NewDocumentCommand{\resumeSection}{m}{
  %\vspace{-1em}
  \section{\textbf{#1}}
  \vspace{-1em}
  \hrule
  \vspace*{.5em}
}

\NewDocumentCommand{\educationInfo}{m m m O{}}{
  \begin{tabular*}{\textwidth}{@{}l@{\extracolsep{\fill}}r@{}}
    \textbf{#1} & {#3} \\
    {#2} & {#4}
  \end{tabular*}
}

\NewDocumentCommand{\jobInfo}{m m m m}{
  \noindent
  %\vspace*{.5em}
  \begin{tabular*}{\textwidth}{@{}l@{\extracolsep{\fill}}r@{}}
    \textbf{#1} & {#3} \faMapMarker* \\
    \textit{#2} & \textit{#4}
  \end{tabular*}
}

\NewDocumentCommand{\jobInfoSameCompany}{m m}{
  \noindent
  % \vspace*{.5em}
  \begin{tabular*}{\textwidth}{@{}l@{\extracolsep{\fill}}r@{}}
    \textit{#1} & \textit{#2}
  \end{tabular*}
}

\NewDocumentCommand{\projectInfo}{m m}{
  \begin{tabular*}{\textwidth}{@{}l@{\extracolsep{\fill}}r@{}}
    \textbf{#1} & {#2}
  \end{tabular*}
}
