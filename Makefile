all:
	make adaptive-full.tex comparison.tex dpp.tex factorization.tex genma.tex intro.tex intro-dpp.tex intro-framework.tex intro-genma.tex mooc.tex recommenders.tex
	make cat && open cat.pdf

cat:
	xelatex cat
	# biber cat
	# xelatex cat

%.tex: %.md
	pandoc -N $< -o $@

clean:
	rm cat.aux
	rm adaptive-full.tex comparison.tex dpp.tex factorization.tex genma.tex intro.tex intro-dpp.tex intro-framework.tex intro-genma.tex mooc.tex recommenders.tex
