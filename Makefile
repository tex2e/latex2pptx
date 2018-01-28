
SHELL := /bin/sh
UNAME := $(shell uname)
.SUFFIXES:
.SUFFIXES: .pdf .tex .dvi

TEX := platex -shell-escape

TEX_FILE := presen.tex
PDF_FILE := presen.pdf
PPTX_FILE := presen.pptx

COMPILE_CNT := 1

ifeq ($(UNAME), Linux)
OPEN := xdg-open 2>/dev/null
else
OPEN := open
endif

all: pdf

%.dvi: %.tex
	@for i in `seq 1 $(COMPILE_CNT)`; do \
		yes q | head | $(TEX) $<; \
	done
	@for i in `seq 1 3`; do \
		if grep -F 'Rerun to get cross-references right.' $(<:.tex=.log); then \
			yes q | head | $(TEX) $<; \
		else \
			exit 0; \
		fi; \
	done

%.pdf: %.dvi
	dvipdfmx -d5 $<
	-test -f title.pdf && pdfunite title.pdf $@ /tmp/$$.pdf && mv /tmp/$$.pdf $@

%.pptx: %.pdf presen-note.txt
	./bin/pdf2pptx

pdf: $(PDF_FILE)

pptx: $(PPTX_FILE)

punctuation punc pun: $(TEX_FILE)
	@$(foreach file, $?, \
		cat "$(file)" | sed -e 's/。/．/g' | sed -e 's/、/，/g' > /tmp/$$~ \
		&& mv /tmp/$$~ "$(file)"; \
	)

open: $(PDF_FILE)
	$(OPEN) $(PDF_FILE)

clean:
	$(RM) *.{aux,fls,log,nav,dvi,out,snm,toc}

distclean: clean
	$(RM) $(PDF_FILE)

re rebuild recompile:
	touch $(TEX_FILE)
	$(MAKE) pdf
