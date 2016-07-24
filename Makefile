TEX:=pdftex
LATEX:=pdflatex
LATEXFLAGS:=-shell-escape

PKG:=latexgit
DOC:=$(PKG).pdf
STY:=$(PKG).sty
INS:=$(PKG).ins

all: $(STY) $(INS) $(DOC)

%.sty: %.dtx
	$(TEX) $<

%.ins: %.dtx
	$(TEX) $<

%.pdf: %.dtx
	$(LATEX) $(LATEXFLAGS) $< && $(LATEX) $(LATEXFLAGS) $<

clean:
	$(RM) -v $(addprefix $(PKG).,aux glo hd idx log out)

distclean: clean
	$(RM) -v $(addprefix $(PKG).,ins pdf sty)

.PHONY: clean distclean
