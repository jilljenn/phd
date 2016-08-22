all:
	make adaptive-full.tex comparison.tex dpp.tex factorization.tex genma.tex intro.tex intro-dpp.tex intro-framework.tex intro-genma.tex intro-mooc.tex merci.tex mooc.tex perspectives.tex rbm.tex recommenders.tex summary.tex
	make cat && open cat.pdf

cat:
	xelatex cat
	makeindex -s nomencl.ist -t cat.lng -o cat.nls cat.nlo
	biber cat
	xelatex cat

%.tex: %.md
	pandoc --biblatex --bibliography biblio.bib -N $< -o $@

clean:
	rm cat.aux cat.lng cat.nlo cat.nls
	rm adaptive-full.tex comparison.tex dpp.tex factorization.tex genma.tex intro.tex intro-dpp.tex intro-framework.tex intro-genma.tex intro-mooc.tex merci.tex mooc.tex perspectives.tex rbm.tex recommenders.tex summary.tex
