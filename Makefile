DOCS=matahari-for-developers.tex

output=$(DOCS:.tex=.pdf)
includes=$(filter-out $(output),$(wildcard *.tex))

all: $(output)

$(output): %.pdf:%.tex $(includes)
	pdflatex $<

$(output): %.pdf:%.out $(includes)

$(DOCS:.tex=.out): %.out:%.tex
	pdflatex $<

clean:
	-rm $(output)
	-rm *.aux *.out *.log

.PHONY: all clean
