TEX:=pdftex
LATEX:=pdflatex
LATEXFLAGS:=-shell-escape
MAKEIDX:=makeindex

PKG:=latexgit
DOC:=$(PKG).pdf
STY:=$(PKG).sty
INS:=$(PKG).ins

DEPS:=$(wildcard exmp/*)

all: $(STY) $(INS) $(DOC)

%.sty: %.dtx
	$(TEX) $<

%.ins: %.dtx
	$(TEX) $<

%.pdf: %.dtx $(DEPS)
	$(LATEX) $(LATEXFLAGS) $< && \
		$(MAKEIDX) -s gind.ist -o $(<:dtx=ind) $(<:dtx=idx) && \
		$(LATEX) $(LATEXFLAGS) $< && \
		$(MAKEIDX) -s gglo.ist -o $(<:dtx=gls) $(<:dtx=glo) && \
		$(LATEX) $(LATEXFLAGS) $<

clean:
	$(RM) -v $(addprefix $(PKG).,aux glo hd idx log out)

distclean: clean
	$(RM) -v $(addprefix $(PKG).,ins pdf sty)

.PHONY: clean distclean
