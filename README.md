# Thèse de Jill-Jênn Vie

**Modèles de tests adaptatifs pour le diagnostic de connaissances dans un cadre d'apprentissage à grande échelle**

http://jiji.cat

## Fonctionnalités

- Chapitres écrits en Markdown
- Table des acronymes et des notations avec liens cliquables
- Bibliographie en deux langues respectant les règles typographiques correspondantes
- Rétroliens dans la bibliographie
- Pseudocode en français
- Compilation des figures à la volée si nécessaire (merci [Stéphane Caron](https://scaron.info/blog/makefiles-for-latex.html))
- Caractères grecs gras droits (!) pour les vecteurs
- Compilation LuaLaTeX ou XeLaTeX
- Page de garde ayant une mise en page différente du reste du document
- Direction assistée

N'hésitez pas à consulter et réutiliser le [Makefile](https://github.com/jilljenn/phd/blob/master/Makefile). Il a fait ses preuves, en particulier figurez-vous qu'il faut faire deux fois `makeindex` pour avoir les bons numéros de pages.

J'ai aussi tenté de commenter abondamment les lignes obscures du fichier maître [`cat.tex`](https://github.com/jilljenn/phd/blob/master/cat.tex).

## Prérequis

Il vous faudra [pandoc](http://pandoc.org), ainsi qu'une police à caractères japonais (ex. IPAexMincho) pour écrire le nom de ma copine.

## Compilation

### Version hipster : compilation LuaLaTeX

Requiert LuaLaTeX afin de produire [un fichier au format PDF/A1-b](http://jiji.cat/cat.pdf) (6 Mo), donc archivable.

Faites `make` et c'est terminé.

### Version classique : compilation XeLaTeX

Si vous êtes seulement en XeLaTeX, vous pouvez quand même produire [un PDF non archivable](http://jiji.cat/cat-xelatex.pdf) (5,6 Mo).

Décommentez la ligne `xelatex` du Makefile puis lancez `make`.

## Bonus : minimal (non-)working examples

Si vous êtes curieux, j'ai repéré des bizarreries LaTeX, elles se trouvent dans le dossier [`mwe`](https://github.com/jilljenn/phd/tree/master/mwe).
