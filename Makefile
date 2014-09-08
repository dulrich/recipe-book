SHELL := /bin/bash

source_files    := $(wildcard intro.md recipes/*.md)
build_files     := $(source_files:%.md=html/%.html)
output_md       := build/book.md
output_html     := build/book.html

.PHONY: all clean md html

all: | clean md html

clean:
	rm -f $(output_md) $(output_html) html/*.html

$(output_md): $(source_files)
	awk 'FNR==1{print "\n"}1' $(source_files) > $(output_md)

md: $(output_md)

$(output_html): style.html $(output_md)
	cat style.html > $(output_html)
	marked --gfm --tables $(output_md) >> $(output_html)

html: style.html $(output_html)