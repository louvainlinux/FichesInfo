# You can change the pdf viewer to your preferred
# one by commenting every line beginning by
# `PDFVIEWER' except the one with your pdf viewer
#PDFVIEWER=evince # GNOME
#PDFVIEWER=okular # KDE
#PDFVIEWER=xpdf # lightweight
PDFVIEWER=xdg-open # Default pdf viewer - GNU/Linux
#PDFVIEWER=open # Default pdf viewer - Mac OS
ROOT=../..

# You want latexmk to *always* run, because make does not have all the info.
.PHONY: $(MAIN_NAME).pdf

# If you want the pdf to be opened by your preferred pdf viewer
# after `$ make', comment the following line and uncomment the
# line after
default: all

all: $(MAIN_NAME).pdf
	rm $(ROOT)/*.aux $(ROOT)/*.fls $(ROOT)/*.log $(ROOT)/*.out \
	  $(ROOT)/*.fdb_latexmk
	$(PDFVIEWER) $(ROOT)/$(MAIN_NAME).pdf 2> /dev/null &

# MAIN LATEXMK RULE

# -pdf tells latexmk to generate PDF directly (instead of DVI).
# -pdflatex="" tells latexmk to call a specific backend with specific options.
# -use-make tells latexmk to call make for generating missing files.

# -interactive=nonstopmode keeps the pdflatex backend from stopping at a
# missing file reference and interactively asking you for an alternative.

$(MAIN_NAME).pdf: $(MAIN_NAME).tex
	latexmk -pdf -pdflatex="pdflatex -shell-escape -enable-write18" \
	  -output-directory=$(ROOT) -use-make $(MAIN_NAME).tex

clean:
	rm $(ROOT)/*.aux $(ROOT)/*.fls $(ROOT)/*.log $(ROOT)/*.out \
	  $(ROOT)/*.fdb_latexmk

show: $(MAIN_NAME).pdf
	$(PDFVIEWER) $(ROOT)/$(MAIN_NAME).pdf 2> /dev/null &
