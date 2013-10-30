Presentation Tools
==================

This repository contains tools for building presentation handouts in LaTeX using the [`tufte-latex`](http://www.ctan.org/pkg/tufte-latex) package.

Installation
------------

Run the `setup.sh` script. On recent versions of Fedora, TeX Live is packaged in the yum repositories, and will be installed from there. If TeX Live is not available from yum, it and the necessary packages will be downloaded and installed manually (note that this has been tested only on Fedora 15, and may well no longer work).

Setup
-----

I usually start by creating a fresh branch for each new presentation:

    git checkout -b ${presentation_name} master

Create the handout as a LaTeX document, and any diagrams as Inkscape SVG documents. When building the handout, the SVG graphics will be exported in PDF format for inclusion in the handout. They can also be exported in PNG format for easy inclusion in e.g. Impress presentations.

A good starting point for the preamble to the handout is:

    cat >${presentation_name}.tex <<EOF
    \documentclass{tufte-handout}

    \usepackage{fancyvrb}
    \fvset{fontsize=\normalsize}

    \usepackage{hyperref}
    \hypersetup{colorlinks=true}

    \usepackage{graphicx}

    % Hide page numbers in ToC
    \let\Contentsline\contentsline
    \renewcommand\contentsline[3]{\Contentsline{#1}{#2}{}}

    \usepackage{pdfpages}

    EOF

See the [`tufte-latex` sample handout](http://ctan.space-pro.be/tex-archive/macros/latex/contrib/tufte-latex/sample-handout.pdf) for documentation on how to format the handout.

Edit the `DOCS` variable in the Makefile to specify the name of the main TeX file from which to generate the handout PDF:

    sed -i Makefile -e "/DOCS =/ s/\$/${presentation_name}.tex/"
    git add Makefile ${presentation_name}.tex
    git commit -m "Began new presentation ${presentation_name}"

Building
--------

The following `make` targets are available:

* `all` (default) - build the handout PDF and PNG graphics
* `png` - build PNG graphics to add to slides
* `pdf` - build PDF graphics for inclusion in the handout
* `clean` - remove build products

The Makefile ensures that any references (such as a table of contents) are up to date, even if you are including multiple other TeX documents (this can require multiple invocations of `pdflatex`).
