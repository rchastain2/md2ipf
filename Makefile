PROJECT := philosophie
TITLE := Cours de philosophie (en construction)

SRC := md

CHAPTERS := \
01-socrate \
02-enseignement \
03-bonheur \
04-justice \
04-annexe-resume-republique \
05-societe \
06-physique \
07-verite \
08-indifference \
08-annexe-eucharistie \
09-liberte \
10-fleurs \
11-art

CHAPTERS := $(foreach item,$(CHAPTERS),$(SRC)/$(item).md)

IMAGES := ombres programme-ombres arbre/arbre
BMPS := $(foreach item,$(IMAGES),md/$(item).bmp)

WIPFC_DAT := $(HOME)/Documents/pascal/msegui/fpdoc/wipfc-src/data
WIPFC_BIN := $(HOME)/Documents/pascal/msegui/fpdoc/wipfc-src/wipfc
DOCVIEW := $(HOME)/apps/docview-260425/target/docview

VERSION := $(shell date '+%y%m%d')
SCRIPT := md2ipf.lua

$(PROJECT): $(CHAPTERS) $(BMPS) index.txt $(SCRIPT)
	lua $(SCRIPT) "$(TITLE)" $(CHAPTERS) > book.ipf
	$(MAKE) book

%: $(SRC)/%.md $(BMPS) index.txt $(SCRIPT)
	lua $(SCRIPT) "$(TITLE)" $< > chapter.ipf
	$(MAKE) chapter

%: %.ipf
	## Création dossier temporaire
	mkdir -p tmp
	## Changement encodage
	iconv -f UTF-8 -t CP850//TRANSLIT $< -o tmp/cp850.ipf
	## Compilation fichier IPF
	env WIPFC=$(WIPFC_DAT) $(WIPFC_BIN) -i -o $@.inf -q tmp/cp850.ipf
	## Ouverture fichier INF dans la visionneuse, avec recherche d'un mot
	$(DOCVIEW) $@.inf -k "science"

release: $(PROJECT)
	zip $(PROJECT)-$(VERSION).zip book.inf 

edit:
	textadept $(CHAPTERS)

bmp: $(BMPS)

md/%.bmp: $(SRC)/%.png
	mkdir -p $(dir $@)
	magick $< -background white -alpha remove -alpha off -resize 600x600\> -format bmp -define bmp:format=bmp3 $@

clean:
	rm -fv *.i?f
	rm -fv tmp/*.i?f

distclean: clean
	rm -fv $(BMPS)
