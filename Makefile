all:
	# make chapters
	xelatex cat

chapters:
	pandoc -N adaptive-full.md -o adaptive-full.tex
	pandoc -N recommenders.md -o recommenders.tex
	pandoc -N dpp.md -o dpp.tex
	pandoc -N factorization.md -o factorization.tex
