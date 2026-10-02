
PROJECT := philosophie
TITLE := Cours de philosophie (en construction)

CHAPTERS := \
socrate \
apprendre \
gorgias \
justice \
contrat \
langage \
metaphysique \
physique \
botanique \
liberte \
art \
indifference

CHAPTERS := $(foreach item,$(CHAPTERS),md/$(item).md)
WIPFC_DAT := $(HOME)/Documents/pascal/msegui/fpdoc/wipfc-src/data
WIPFC_BIN := $(HOME)/Documents/pascal/msegui/fpdoc/wipfc-src/wipfc
DOCVIEW := $(HOME)/apps/docview-260425/target/docview

VERSION := $(shell date '+%y%m%d')
SCRIPT := md2ipf.lua

$(PROJECT): $(CHAPTERS)
	lua $(SCRIPT) "$(TITLE)" $^ > book.ipf
	$(MAKE) book

%: md/%.md
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

bmp:
	magick md/earth3_400x300.png -format bmp -define bmp:format=bmp3 md/earth3_400x300.bmp
	
clean:
	rm -fv *.i?f
	rm -fv tmp/*.i?f
