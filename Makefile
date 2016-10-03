all:
	make adaptive-full.tex code.tex comparison.tex dpp.tex factorization.tex genma.tex intro.tex intro-dpp.tex intro-framework.tex intro-genma.tex intro-mooc.tex merci.tex mooc.tex perspectives.tex rbm.tex recommenders.tex summary.tex
	make cat && open cat.pdf

cat:
	xelatex cat
	makeindex -s nomencl.ist -t cat.lng -o cat.nls cat.nlo
	makeglossaries cat
	biber cat
	xelatex cat
	xelatex cat

%.tex: %.md
	pandoc --biblatex --bibliography biblio.bib -N $< -o $@

clean:
	rm cat.aux cat.bbl cat.bcf cat.blg cat.acn cat.acr cat.alg cat.glg cat.glo cat.gls cat.glsdefs cat.ist cat.lng cat.lof cat.log cat.lot cat.nlo cat.out cat.nls cat.run.xml cat.toc missfont.log adaptive-full.tex code.tex comparison.tex dpp.tex factorization.tex genma.tex intro.tex intro-dpp.tex intro-framework.tex intro-genma.tex intro-mooc.tex merci.tex mooc.tex perspectives.tex rbm.tex recommenders.tex summary.tex
