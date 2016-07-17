all:
	make chapters
	make cat

cat:
	xelatex cat
	# biber cat
	# xelatex cat

chapters:
	pandoc -N adaptive-full.md -o adaptive-full.tex
	pandoc -N recommenders.md -o recommenders.tex
	pandoc -N dpp.md -o dpp.tex
	pandoc -N factorization.md -o factorization.tex
	pandoc -N comparison.md -o comparison.tex
	pandoc -N mooc.md -o mooc.tex
	pandoc -N genma.md -o genma.tex

clean:
	rm cat.aux
