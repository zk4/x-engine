
default:
	#python3 ./gen_readme.py
	docsify serve .

install_docsify:
	npm install -g docsify_cli

pdf:
	pandoc *.md --to=pdf -t latex -o result.pdf --pdf-engine=/Library/TeX/texbin/pdflatex

pdf2:
	# https://www.martinkaptein.com/blog/markdown-to-pdf-without-latex/
	pandoc -t html5 readme.md -o file.pdf -s --pdf-engine=wkhtmltopdf

