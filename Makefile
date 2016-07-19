all:
	make comparison.tex dpp.tex factorization.tex genma.tex intro.tex mooc.tex recommenders.tex
	make cat && open cat.pdf

cat:
	xelatex cat
	# biber cat
	# xelatex cat

%.tex: %.md
	pandoc -N $< -o $@

clean:
	rm cat.aux
	rm comparison.tex dpp.tex factorization.tex genma.tex intro.tex mooc.tex recommenders.tex
