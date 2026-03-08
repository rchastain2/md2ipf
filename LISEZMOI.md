# Création d'un fichier d'aide au format IPF à partir de sources en Markdown

Ce projet consiste en un script Lua et en un *Makefile*, lesquels permettent la création d'un fichier d'aide au format IPF, à partir de fichiers sources en Markdown.

Le [format IPF](http://www.hypermake.com/english/n024.html#hd24) (pour *Information Presentation Facility*) était le format des fichiers d'aide IBM.

Dans notre cas, le fichier d'aide est un cours de philosophie. Les fichiers Markdown en sont les chapitres.

## De Markdown en IPF

Le fichier IPF est créé par le script *md2ipf.lua*, qui convertit le contenu des fichiers Markdown.

## D'IPF en INF

Le fichier IPF est ensuite compilé au format binaire INF au moyen du compilateur [WIPFC](https://github.com/open-watcom/open-watcom-v2).

## DocView

Le fichier INF peut enfin être ouvert dans [DocView](https://github.com/graemeg/fpGUI/tree/develop/docview).

![DocView](docview.png)

## Guide de l'utilisateur

(Instructions pour Linux.)

### Installer wipfc

```bash
git clone https://github.com/open-watcom/open-watcom-v2.git
cd open-watcom-v2/bld/wipfc
./configure
make
sudo make install
```

### Installer DocView

À faire.

### Lancer la commande finale

Une fois édités (dans *Makefile*) les chemins vers *wipfc* et *DocView*, vous pouvez lancer la commande finale.

```
make
```
