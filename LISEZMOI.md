# Création d'un fichier INF à partir de sources en Markdown

Ce projet consiste en un script Lua et en un *Makefile*, lesquels permettent la création d'un document au [format de l'aide IBM](http://www.hypermake.com/english/n024.html#hd24), à partir de fichiers sources en Markdown.

Dans notre cas, le fichier INF contiendra un cours de philosophie.

## De Markdown en IPF

Les fichiers IPF (pour *Information Presentation Facility*) sont les fichiers sources de l'aide au format IBM.

Dans notre cas, le fichier IPF est créé par le script *md2ipf.lua*, qui convertit le contenu des fichiers Markdown.

## D'IPF en INF

Le fichier IPF est ensuite compilé au format binaire INF au moyen du compilateur [WIPFC](https://github.com/open-watcom/open-watcom-v2).

## DocView

Le fichier INF peut enfin être ouvert dans [DocView](https://github.com/graemeg/fpGUI/tree/develop/docview).

![DocView](docview.png)

## Guide de l'utilisateur

(Instructions pour Linux.)

### Installer wipfc

```
git clone https://github.com/open-watcom/open-watcom-v2.git && \
cd open-watcom-v2/bld/wipfc && \
./configure && \
sudo make install
```

### Installer DocView

À faire.

### Lancer la commande finale

Une fois édités (dans *Makefile*) les chemins vers *wipfc* et *DocView*, vous pouvez lancer la commande finale.

```
make
```
