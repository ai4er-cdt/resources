# !/bin/bash
# author=sdat2
# file based on answer:
# https://tex.stackexchange.com/questions/140845/how-can-i-ignore-latex-error-while-compiling
# To use from terminal:
#   chmod 755 compile-latex.sh
#   ./compile-latex.sh

filename=report # main # presentation (the tex file to compile, without the .tex ending)

# Just in case the output or aux folders don't exist. Should fail safely.
mkdir output
mkdir aux

mv aux/${filename}.lo* aux/${filename}.aux aux/${filename}.ilg .
mv aux/${filename}.ind aux/${filename}.toc .
mv aux/${filename}.bbl aux/${filename}.blg .
mv aux/${filename}.out aux/${filename}.asc .
mv aux/${filename}.snm aux/${filename}.fls aux/${filename}.run.xml .
mv aux/${filename}.nav aux/${filename}.dvi aux/${filename}.fdb_latexmk .
mv aux/${filename}.vrb  aux/${filename}-blx.bib .

pdflatex --interaction nonstopmode --shell-escape ${filename}.tex
makeindex -c -s myindex.ist ${filename}.idx
bibtex ${filename}
makeindex -c -s myindex.ist ${filename}.idx 
pdflatex  --interaction nonstopmode  --shell-escape ${filename}.tex 

mv ${filename}.lo* *.aux ${filename}.ilg ${filename}.ind ${filename}.toc aux/
mv ${filename}.bbl ${filename}.blg ${filename}.out *.asc aux/
mv *.snm *.fls *.run.xml *.nav *.dvi *.fdb_latexmk *.vrb aux/
mv *-blx.bib aux/
mv *.pdf output/
