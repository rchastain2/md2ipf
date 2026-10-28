
# Longueur des ombres à midi

Longueur des ombres à midi. Illustration de la méthode suivie par les géomètres pour déterminer la circonférence de la Terre. Exemple de dessin avec *AGGPas* dans une fenêtre *fpGUI*.

Pour dessiner une ombre, le programme cherche l'intersection avec l'arc de cercle terrestre du rayon du soleil passant par le point le plus haut de l'obstacle.

La direction des rayons du soleil peut être modifiée par l'utilisateur.

## Compilation

Le programme se compile avec *make* :

```
make
```

Ou :

```
make -f Makefile.win
```

si vous utilisez Windows.

Vous devez préalablement 1° télécharger *fpGUI* :

```
git clone https://github.com/graemeg/fpGUI.git
```

et 2° corriger dans *Makefile* (ou *Makefile.win*) le chemin vers le dossier créé par la commande ci-dessus.
