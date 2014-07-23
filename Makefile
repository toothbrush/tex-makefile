# Find main tex file:
MAININDICATOR=$(wildcard ?*.tex.latexmain)
TEXFILE=$(subst .latexmain,,$(MAININDICATOR))
PDF=$(TEXFILE:.tex=.pdf)
BIBS=$(wildcard *.bib)
TEXS=$(wildcard *.tex)
IMAGES=$(wildcard img/*)

# find a suitable viewer.
OPEN=$(shell which xdg-open || which open)

all: $(PDF)

sanity:
	@test -f "$(MAININDICATOR)" || (echo "Couldn't find file called *.tex.latexmain!" ; exit 10)
	@test -x "`which rubber`"   || (echo "You don't have rubber installed." ; exit 20)
	@echo "Main LaTeX file = $(TEXFILE)."

$(PDF): sanity $(TEXS) $(BIBS) $(IMAGES)
	TEXMFOUTPUT=`pwd` rubber -v --pdf $(TEXFILE)

# list all remaining todo-like notes.
# note: ugly hack for recognising our initials...
*.tex:
	@grep --color=auto -Hn -e "\(TODO\|\\\[pce][wcb]{\)" $@ ; exit 0

clean: sanity
	rubber --clean $(TEXFILE)
	rm -vf $(PDF)

view: sanity $(PDF)
	if [ -x "$(OPEN)" ] ; then $(OPEN) $(PDF) ; fi &

.PHONY: clean view all $(TEXS)
