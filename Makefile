
## Nom du document final
PROJECT := philo

## Titre du document
PROJECT_TITLE := Cours de philosophie (en construction)

## Chapitres (dans l'ordre)

PROJECT_SOURCE := \
md/socrate.md \
md/apprendre.md \
md/gorgias.md \
md/justice.md \
md/contrat.md \
md/langage.md \
md/metaphysique.md \
md/physique.md \
md/botanique.md \
md/liberte.md \
md/art.md

## Compilateur IPF
WATCOM := $(HOME)/apps/open-watcom
WIPFC  := $(WATCOM)/bld/wipfc/atadir/wipfc

## Visionneuse
DOCVIEW := $(HOME)/apps/docview/docview

## Script Lua pour la conversion de Markdown en IPF
LUA_SCRIPT := md2ipf.lua

default: $(PROJECT).inf

$(PROJECT).ipf: $(PROJECT_SOURCE)
	@lua $(LUA_SCRIPT) "$(PROJECT_TITLE)" $^ > $@

$(PROJECT).inf: $(PROJECT).ipf Makefile
	@## Création d'un dossier temporaire
	@mkdir -p tmp
	@## Changement d'encodage (d'UTF-8 en CP850)
	@iconv -f UTF-8 -t CP850 $< -o tmp/cp850.ipf
	@## Compilation du fichier IPF
	@env WIPFC=$(WIPFC) wipfc -i -o $@ -q tmp/cp850.ipf
	@## Ouverture du fichier INF dans la visionneuse et recherche d'un mot
	@$(DOCVIEW) $@ -k "science"

clean:
	@rm -fv *.i?f
	@rm -fv tmp/*.i?f
