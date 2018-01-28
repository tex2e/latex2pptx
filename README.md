# latex2pptx

Convert a pdf made by LaTeX to a pptx (PowerPoint).

## Prerequisites

```
sudo tlmgr install newtx pgfpages beamer bxdpx-beamer pgfplots
pip install python-pptx
```

- LaTeX
    - newtx : LaTeX TX fonts
    - pgfpages : Page layout
    - beamer : LaTeX class for producing presentations
    - bxdpx-beamer : Dvipdfmx extras for use with beamer
    - pgfplots : Create normal/logarithmic plots in two and three dimensions
- Python3
    - python-pptx : Generate and manipulate Open XML PowerPoint files
- Extra Commands
    - convert : ImageMagick


## Usage

```
make pptx
```
