# Find main tex file:
MAININDICATOR=$(wildcard *.latexmain)
TEXFILE=$(subst .latexmain,,$(MAININDICATOR))
PDF=$(TEXFILE:.tex=.pdf)

all: $(PDF)

sanity:
	@test -f "$(MAININDICATOR)" || (echo "Couldn't find file called *.latexmain!" ; exit 10)
	@echo "Main LaTeX file = $(TEXFILE)."

$(PDF): sanity $(TEXFILE) *.tex *.bib
	TEXMFOUTPUT=`pwd` rubber -v --pdf $(TEXFILE)

clean: sanity
	rubber --clean $(TEXFILE)
	rm -vf $(PDF)

pdfshow: sanity $(PDF)
	# for OS X:
	if [ -x /usr/bin/open ] ; then open $(PDF); fi
	# for Linux:
	if [ -x /usr/bin/zathura ] ; then zathura $(PDF); fi &

.PHONY: clean pdfshow all
