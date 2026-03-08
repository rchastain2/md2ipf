
## Nom du document final
PROJECT := philosophie

## Titre du document
PROJECT_TITLE := Cours de philosophie (en construction)

## Chapitres (dans l'ordre)

PROJECT_SOURCE := \
chapitres/socrate.md \
chapitres/gorgias.md \
chapitres/justice.md \
chapitres/contrat.md \
chapitres/langage.md \
chapitres/metaphysique.md \
chapitres/physique.md \
chapitres/botanique.md \
chapitres/liberte.md \
chapitres/art.md

## Compilateur IPF
WATCOM := $(HOME)/apps/open-watcom
WIPFC  := $(WATCOM)/bld/wipfc/atadir/wipfc

## Visionneuse
DOCVIEW := $(HOME)/Documents/pascal/outils/docview-2026/src/main/pascal/docview

## Script Lua pour la conversion de Markdown en IPF
LUA_SCRIPT := md2ipf.lua

default: $(PROJECT).inf

$(PROJECT).ipf: $(PROJECT_SOURCE)
	lua $(LUA_SCRIPT) "$(PROJECT_TITLE)" $^ > $@

$(PROJECT).inf: $(PROJECT).ipf Makefile
	@## Changement d'encodage (d'UTF-8 en CP850)
	@iconv -f UTF-8 -t CP850 $< -o $(PROJECT)-cp850.ipf
	@## Compilation du fichier IPF
	@env WIPFC=$(WIPFC) wipfc -i -o $@ -q $(PROJECT)-cp850.ipf
	@## Ouverture du fichier INF dans la visionneuse et recherche du mot « oracle »
	@$(DOCVIEW) $@ -k "oracle"

clean:
	@rm -fv *.i?f
