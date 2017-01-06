# Minimal (non-)working examples

Here are a few idiosyncrasies I stumbled upon while writing my memoir.

## Beauty of LaTeX

    lualatex beauty-of-latex

Will produce a beautiful historic ligature.

## icomma vs. otherlanguage

    xelatex icomma-otherlanguage
    lualatex icomma-otherlanguage

Both will produce this terrible thing:

![0,123 0, 123](https://i.stack.imgur.com/hOcXr.png)

[Solution on TeX.SE](http://tex.stackexchange.com/a/347199/7144)

## RGB vs. CMYK

    lualatex rgb-cmyk

Different magenta colors according to whether tikz is loaded or not (!).

![RGB vs. CMYK](https://i.stack.imgur.com/darY9.png)

[Question on TeX.SE](http://tex.stackexchange.com/questions/347367/loading-tikz-changes-the-colors-of-my-pdf-a-document-from-rgb-to-cmyk)

## Commas replaced by semicolons in Babel French's `\DecimalMathComma` mode

    lualatex frenchb-comma

Will output `0;123` instead of `0,123`. In XeLaTeX the behavior is correct.

## Small caps ligature

    lualatex small-caps-ligature

Will output `ThÈSE` instead of `Thèse`. In XeLaTeX the behavior is correct.

## Upright bold greek letters

    lualatex upright-bold-greek

LuaLaTeX and `bm` do not like each other. An idea is to keep using `boldsymbol` and specify a special font for bold characters.
