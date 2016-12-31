CONTENT_MD=$(wildcard *.md)
CONTENT_TEX=$(CONTENT_MD:.md=.tex)
FIGURES_TEX=$(wildcard figures/*.tex)
FIGURES_DOT=$(wildcard figures/*.dot)
FIGURES_PDF=$(FIGURES_TEX:.tex=.pdf) $(FIGURES_DOT:.dot=.pdf)
# LATEX=xelatex -shell-escape -output-driver="xdvipdfmx -z 0"
LATEX=lualatex

.PHONY: all clean

all: $(FIGURES_PDF) $(CONTENT_TEX)
	$(LATEX) cat
	makeindex -s nomencl.ist -t cat.lng -o cat.nls cat.nlo
	makeglossaries cat
	biber cat
	$(LATEX) cat
	$(LATEX) cat
	$(LATEX) cat
	open cat.pdf

%.tex: %.md
	pandoc --biblatex --bibliography biblio.bib -N $< -o $@

figures/%.pdf: figures/%.tex
	$(LATEX) -output-directory=figures $<

figures/%.pdf: figures/%.dot
	dot -Tpdf $< -o $@

clean:
	rm -f $(CONTENT_TEX) $(FIGURES_PDF) figures/*.aux figures/*.log
	rm -f cat.aux cat.bbl cat.bcf cat.blg cat.acn cat.acr cat.alg cat.glg cat.glo cat.gls cat.glsdefs cat.ist cat.lng cat.lof cat.log cat.lot cat.nlo cat.out cat.nls cat.run.xml cat.toc creationdate.lua missfont.log
