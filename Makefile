TEX:=pdftex
LATEX:=pdflatex
LATEXFLAGS:=-shell-escape

PKG:=latexgit
DOC:=$(PKG).pdf
STY:=$(PKG).sty
INS:=$(PKG).ins
README:=README.md

all: $(STY) $(INS) $(README) $(DOC)

%.sty: %.dtx
	$(TEX) $<

$(README): $(PKG).dtx
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
