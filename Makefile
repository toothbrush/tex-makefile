# TEXFILE=$(wildcard *.tex)
# Main tex file:
TEXFILE=*.main.tex
PDF=$(TEXFILE:.tex=.pdf)

all: $(PDF)

$(PDF): $(TEXFILE) *.tex refs.bib
	TEXMFOUTPUT=`pwd` rubber -v --pdf $<

clean:
	rubber --clean $(TEXFILE)
	rm -vf $(PDF)

pdfshow: $(PDF)
	if [ -x /usr/bin/open ] ; then open $<; fi
	if [ -x /usr/bin/zathura ] ; then zathura $<; fi &

.PHONY: clean pdfshow all
