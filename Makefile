# Find main tex file:
MAININDICATOR=$(wildcard ?*.tex.latexmain)
TEXFILE=$(subst .latexmain,,$(MAININDICATOR))
PDF=$(TEXFILE:.tex=.pdf)
BIBS=$(wildcard *.bib)
TEXS=$(wildcard *.tex)
IMAGES=$(wildcard img/*)

all: $(PDF)

sanity:
	@test -f "$(MAININDICATOR)" || (echo "Couldn't find file called *.tex.latexmain!" ; exit 10)
	@test -x "`which rubber`"   || (echo "You don't have rubber installed." ; exit 20)
	@echo "Main LaTeX file = $(TEXFILE)."

$(PDF): sanity $(TEXS) $(BIBS) $(IMAGES)
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
