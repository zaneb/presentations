svg_files = $(wildcard *.svg)

define graphics
$(1)_graphics = $$(svg_files:.svg=.$(strip $(1)))
$(1): $$($(strip $(1))_graphics);
.PHONY: $1
$$($(strip $(1))_graphics): %.$(strip $(1)):%.svg
	inkscape -z --export-dpi=180 --export-$(strip $(1))=$$@ $$<
endef

$(eval $(call graphics, png))

clean:
	-rm $(png_graphics)

.PHONY: clean
