
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
art

CHAPTERS := $(foreach item,$(CHAPTERS),md/$(item).md)
WIPFC := $(HOME)/apps/open-watcom/bld/wipfc/atadir/wipfc
DOCVIEW := $(HOME)/apps/docview/docview
VERSION := $(shell date '+%y%m%d')
SCRIPT := md2ipf.lua

$(PROJECT): $(CHAPTERS)
	lua $(SCRIPT) "$(TITLE)" $^ > book.ipf
	make book

%: md/%.md
	lua $(SCRIPT) "$(TITLE)" $< > chapter.ipf
	make chapter

%: %.ipf
	## Création dossier temporaire
	mkdir -p tmp
	## Changement encodage
	iconv -f UTF-8 -t CP850 $< -o tmp/cp850.ipf
	## Compilation fichier IPF
	env WIPFC=$(WIPFC) wipfc -i -o $@.inf -q tmp/cp850.ipf
	## Ouverture fichier INF dans la visionneuse, avec recherche d'un mot
	$(DOCVIEW) $@.inf -k "science"

release: $(PROJECT)
	zip $(PROJECT)-$(VERSION).zip book.inf 

clean:
	rm -fv *.i?f
	rm -fv tmp/*.i?f
