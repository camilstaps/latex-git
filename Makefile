TEX:=pdftex
LATEX:=pdflatex
LATEXFLAGS:=-shell-escape
MAKEIDX:=makeindex

PKG:=latexgit
DTX:=$(PKG).dtx
DOC:=$(PKG).pdf
STY:=$(PKG).sty
INS:=$(PKG).ins
TARBALL:=$(PKG).tar.gz

DEPS:=$(wildcard exmp/*)

all: $(STY) $(INS) $(DOC) $(TARBALL)

$(TARBALL): $(DTX) $(INS) $(DOC) README.md LICENSE
	cp $< $<.tmp
	sed -i "s!{{{PACKAGE_VERSION}}}!$$(git log -1 --date=short --pretty=format:%ad | tr '-' '/')!g" $<
	tar czv --transform 's!^!latexgit/!' -f $@ $^
	mv $<.tmp $<

%.sty: %.dtx
	$(TEX) $<

%.ins: %.dtx
	$(TEX) $<

%.pdf: %.dtx $(DEPS)
	cp $< $<.tmp
	sed -i "s!{{{PACKAGE_VERSION}}}!$$(git log -1 --date=short --pretty=format:%ad | tr '-' '/')!g" $<
	$(LATEX) $(LATEXFLAGS) $< && \
		$(MAKEIDX) -s gind.ist -o $(<:dtx=ind) $(<:dtx=idx) && \
		$(LATEX) $(LATEXFLAGS) $< && \
		$(MAKEIDX) -s gglo.ist -o $(<:dtx=gls) $(<:dtx=glo) && \
		$(LATEX) $(LATEXFLAGS) $<
	mv $<.tmp $<

clean:
	$(RM) -v $(addprefix $(PKG).,aux glo gls hd idx ilg ind log out tmp toc)

distclean: clean
	$(RM) -v $(addprefix $(PKG).,ins pdf sty) $(TARBALL)

.PHONY: clean distclean
