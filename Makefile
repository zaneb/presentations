DOCS = 

tex_files = $(wildcard *.tex)
svg_files = $(wildcard *.svg)

output = $(DOCS:.tex=.pdf)
inclusions = $(filter-out $(DOCS), $(tex_files))


define graphics
$(1)_graphics = $$(svg_files:.svg=.$(strip $(1)))
$(1): $$($(strip $(1))_graphics);
.PHONY: $1
$$($(strip $(1))_graphics): %.$(strip $(1)):%.svg
	inkscape -z --export-$(strip $(1))=$$@ $$<
endef

all: $(output) $(png_graphics);


$(eval $(call graphics, png))
$(eval $(call graphics, pdf))


$(output): %.pdf:%.tex $(includes) $(pdf_graphics)
	pdflatex $<

$(output): %.pdf:%.out

$(DOCS:.tex=.out): %.out:%.tex
	pdflatex $<


clean:
	-rm $(png_graphics)
	-rm $(pdf_graphics)
	-rm $(output)
	-rm *.aux *.out *.log

.PHONY: all clean
