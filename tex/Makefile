.SUFFIXES: .gp .tex .eps .pdf .eps.gz

.eps.pdf:
		epstopdf --outfile $@ $<

.eps.gz.pdf:
		gzip -dc $< | epstopdf --filter > $@

.pdf.eps:
		pdftops -eps $< $@

all:CHM.pdf

fig1.eps:plot.gp
		gnuplot plot.gp

CHM.pdf:CHM.tex CHM.bib fig1.pdf
		pdflatex CHM; bibtex CHM; pdflatex CHM; pdflatex CHM;

clean:
		rm -fr *.toc *.aux *.bbl *.blg *.idx *.log *.out *~ CHM.pdf fig1.pdf fig1.eps
