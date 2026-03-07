# Create INF file from Markdown sources

Create a document in [IBM help format](http://www.hypermake.com/english/n024.html#hd24) from Markdown sources.

## Markdown to IPF

IPF files (Information Presentation Facility) are the source format of the IBM help format.

The Mardown files are converted to a single IPF file by the script *md2ipf.lua*.

## IPF to INF

The IPF file is compiled to the INF binary format using [WIPFC](https://github.com/open-watcom/open-watcom-v2).

## DocView

The INF files can be opened in [DocView](https://github.com/graemeg/fpGUI/tree/develop/docview).

![DocView](docview.png)

## User's guide

(Instructions for Linux.)

### Install wipfc

```
git clone https://github.com/open-watcom/open-watcom-v2.git && \
cd open-watcom-v2/bld/wipfc && \
./configure && \
sudo make install
```

### Install DocView

To do.

### Launch the final command

Once you have edited in *Makefile* the paths to *wipfc* and *DocView*, you can launch the final command.

```
make
```
