# Chapitre 6. La physique

Copernic, *Des révolutions des orbes célestes*.
Lalande, *Abrégé d'astronomie*.
Pierre Duhem, *Sauver les phénomènes* (ou *Sauver les apparences. Essai sur la notion de théorie physique de Platon à Galilée*) ; *La théorie physique : son objet, sa structure*.
Joseph de Maistre, *Examen de la philosophie de Bacon*.

## I. Introduction

Deux questions de physique : la rondeur de la terre (et sa grandeur) ; le mouvement de la terre.

Puis une question de philosophie : d'où vient le préjugé qui veut qu'il n'y ait de science que la physique ? Positivisme.

## II. De la rondeur de la terre

Comment sait-on que la terre est ronde ? On peut le savoir sur la base de plusieurs **observations**. Voyons ce qu'en disent deux astronomes, Copernic et Lalande.

**La hauteur méridienne du soleil.** L'observation de la hauteur du soleil à midi en différents pays fut, selon Lalande, la première chose qui dut apprendre aux hommes que la terre était ronde. Plus on va vers le nord, plus le soleil est bas dans le ciel à midi, et plus les ombres mesurées le même jour sont longues.

**L'ombre de la terre sur la lune.** L'ombre de la terre dans les éclipses de lune paraît toujours ronde. Les croissants de lune.

**Les vaisseaux vus de loin.** Les vaisseaux vus de loin en pleine mer disparaissent par degrés : les navires qui s'éloignent de la côte paraissent s'enfoncer dans la mer. Nous retrouvons la même preuve chez Copernic, *Des révolutions des orbes célestes* :

> Lorsque la terre n'est pas aperçue du navire, elle est vue du sommet du mât. Si l'on attache un feu au sommet du mât, celui-ci, lorsque le navire s'éloigne de la terre, paraît à ceux qui demeurent sur le rivage s'abaisser petit à petit, jusqu'à ce qu'il disparaisse enfin, comme s'il se couchait.

Toutes ces observations, tout le monde peut les faire, et elles ont pu être faites dès les temps les plus anciens. Aussi les astronomes ont-ils toujours su que la terre était ronde. Nul besoin d'aller dans l'espace pour savoir que la terre est ronde !

## III. De la grandeur de la terre

Le même moyen qui permet de savoir que la terre est ronde permet de connaître sa grandeur, autrement dit sa **circonférence** : la hauteur du soleil (et donc la longueur des ombres) à midi dans différents pays. C'est de ce moyen que s'est servi Ératosthène.

![Longueur des ombres à différentes latitudes](ombres.png)

Le soleil est si loin que ses rayons arrivent sur la Terre parallèles entre eux. Le même jour à midi, on mesure en deux lieux l'ombre d'un bâton vertical : plus on va vers le nord, plus l'ombre est longue. De la longueur du bâton et de celle de son ombre, on déduit l'angle que font les rayons du soleil avec le sol. Si cet angle diffère d'un degré entre Paris et Amiens, c'est que le sol s'est incliné d'un degré entre les deux villes : vus du centre de la Terre, Paris et Amiens sont séparés par un angle d'un degré. C'est un angle de ce genre qui est marqué sur le dessin.

Lalande, *Abrégé d'astronomie*. La latitude d'Amiens est plus grande que celle de Paris d'un degré : le soleil à midi est d'un degré plus bas dans le ciel à Amiens qu'à Paris. En allant de Paris à Amiens à vol d'oiseau, on parcourt donc la 360e partie de la circonférence de la terre. Le tour de la terre est égal à 360 fois la distance de Paris à Amiens. Autrement dit, en faisant 180 allers-retours à vol d'oiseau de Paris à Amiens, on parcourt la même distance que si on faisait le tour de la terre.

La distance de Paris à Amiens, dit Lalande, est de 25 lieues. La circonférence de la terre, mesurée en passant par les pôles, est donc de 25 × 360 = **9 000 lieues**. La lieue commune de France vaut 1/25 de degré de l'ellipse méridienne terrestre, soit exactement 4,4453 km. La circonférence de la terre (pour un méridien) est donc de 9 000 × 4,4453 = 40 007,7 km.

Non seulement les Anciens ont su que la terre était ronde, mais ils ont également connu sa circonférence. On a encore l'estimation qu'en avait donnée Ératosthène, savant grec qui vivait au IIIe siècle avant J.-C., et qui parvint par ce moyen à estimer assez précisément la circonférence de la terre.

### La méthode d'Ératosthène

Ératosthène avait décrit sa méthode dans un livre intitulé *De la mesure de la Terre*, qui ne nous est pas parvenu. Nous en connaissons une version simplifiée, que Cléomède présente dans son traité *Du mouvement circulaire des corps célestes*.

Vers 240 avant J.-C., Ératosthène considère deux villes d'Égypte, Alexandrie et Syène (aujourd'hui Assouan), situées à peu près sur le même méridien. À Syène, à midi le jour du solstice d'été, le soleil est exactement au zénith : un bâton planté verticalement (un gnomon) ne donne aucune ombre, et le soleil se reflète au fond des puits. Le même jour, à la même heure, Ératosthène mesure à Alexandrie l'ombre d'un autre gnomon. La longueur du bâton et celle de son ombre lui donnent l'angle des rayons du soleil : environ 7°, soit la cinquantième partie d'un cercle.

Si la terre est une sphère, la distance d'Alexandrie à Syène est donc la cinquantième partie de sa circonférence. Cette distance était connue : 5 000 stades, mesurés par des arpenteurs professionnels (les bématistes), qui parcouraient l'Égypte pour en mesurer les terres à des fins agricoles et fiscales. La circonférence de la terre vaut donc 50 × 5 000 = 250 000 stades (252 000 selon Pline).

La valeur exacte du stade reste discutée. Selon la valeur qu'on lui donne, l'erreur d'Ératosthène va de quelques pour cent à 15 %. C'est le même raisonnement que celui de Lalande pour Paris et Amiens : un écart d'un degré entre les hauteurs du soleil correspond à la 360e partie du tour de la terre ; un écart d'un cinquantième de cercle, à la cinquantième partie.

### Un programme pour dessiner les ombres

Les dessins de ce chapitre ont été faits au moyen de petits programmes écrits en Pascal. Le programme de démonstration ci-dessous utilise les bibliothèques *AGGPas* et *fpGUI*. Pour dessiner l'ombre d'un obstacle, le programme cherche le point où le rayon du soleil qui passe par le sommet de l'obstacle rencontre l'arc de cercle terrestre. L'utilisateur peut modifier la direction des rayons du soleil au moyen d'un curseur, et voir comment varie la longueur des ombres.

![Longueurs des ombres à midi : programme de démonstration](programme-ombres.png)

## IV. Du mythe de la terre plate

Contrairement à une rumeur fort répandue de nos jours, jamais personne (de sérieux) n'a cru ni enseigné que la terre était plate. Les hommes ont toujours su, dès les temps les plus anciens, que la terre était ronde. Il est donc faux d'affirmer qu'autrefois on croyait que la terre était plate.

Le mythe de la croyance médiévale en une terre plate est une invention de Voltaire (*Dictionnaire philosophique*, article « Figure ou forme de la terre »). C'est de ce même philosophe qu'est venue cette autre idée fausse, selon laquelle ce seraient les grands navigateurs qui auraient prouvé, par l'expérience, la sphéricité de la terre, en en faisant le tour : « Colomb, Vespucci et Magellan ne craignirent point l'excommunication (...) et la Terre reprit sa rondeur » (Voltaire, 1764).

Il faut être prudent quand on parle de ce qui existait avant. Autre exemple d'une chose qu'on affirme faussement au sujet du Moyen Âge : le prétendu « droit de cuissage », dont Voltaire notamment a parlé, et dont Beaumarchais a fait le sujet d'une pièce célèbre, *Le Mariage de Figaro*. C'est une calomnie dirigée contre le Moyen Âge et contre l'Église. La terre plate est une invention du même genre.

### Lecture complémentaire : « Au Moyen Âge, la Terre était ronde »

D'après un article de France Culture (<https://www.radiofrance.fr/franceculture/au-moyen-age-la-terre-etait-ronde-6821100>), avec les historiennes Violaine Giacomotto-Charra et Sylvie Nony.

- L'homme sait que la Terre est ronde depuis presque 2 500 ans. On le sait au moins depuis Platon et Aristote (*Traité du Ciel*). Ératosthène, au IIIe siècle avant J.-C., donne de la circonférence de la Terre un ordre de grandeur tout à fait raisonnable, environ 40 000 km.
- L'idée d'une Terre sphérique est transmise au monde latin dès le début du Moyen Âge, par des ouvrages de vulgarisation et des encyclopédies. On a pu perdre la technicité des calculs, mais pas l'idée de la forme de la Terre.
- L'image de la Terre ronde est admise par l'Église elle-même, et les savoirs grecs sont transmis par des hommes d'Église qui font autorité : saint Augustin, Bède le Vénérable, saint Thomas d'Aquin, Gautier de Metz. L'encyclopédie d'Isidore de Séville, qui affirme la rotondité de la Terre, est l'un des manuscrits les plus populaires du Moyen Âge.
- La « légende noire » du Moyen Âge vient de la Renaissance : les humanistes, se sentant en rupture avec le Moyen Âge, en ont fait un temps obscur.
- Pour attaquer l'Église de son temps, Voltaire est allé exhumer deux textes antiques isolés (de Lactance et de Cosmas) pour en faire des archétypes de la pensée chrétienne, en ignorant tous les autres, notamment ceux qui avaient un statut de manuel. Il a fait comme si la Terre plate était la doctrine officielle et enseignée. « C'est vraiment de la manipulation. »
- La question fondamentale est celle du « on ». Il ne vient à l'esprit de personne de dire qu'au XXIe siècle « on » croit que la Terre est plate ; pourtant, il y a des gens qui le croient. De même, au Moyen Âge, quelques personnes ont pu le croire, mais ce n'était pas la doctrine enseignée.
- Cette idée fausse a été tellement répandue par les historiens du XIXe siècle qu'elle est encore admise aujourd'hui.

## V. Du mouvement de la terre

C'est encore une question dont on parle quelquefois sans savoir ce qu'on dit : une question subtile qu'on présente souvent de façon simpliste, et même fausse. Lieu commun : « On *croyait* autrefois que le soleil tournait autour de la terre : c'était une erreur. On *sait* maintenant que c'est la terre qui tourne autour du soleil. » Variante : « On croyait autrefois que la terre était immobile. On *sait* maintenant qu'elle se meut. » La vérité aurait succédé à l'erreur, la lumière à l'obscurité.

On dit aussi que Galilée a été condamné (au XVIIe siècle) pour avoir enseigné que la terre tournait autour du soleil, et non pas le soleil autour de la terre.

### A. Mouvement absolu et mouvement relatif

On ne peut jamais observer que des **mouvements relatifs**, et non pas des **mouvements absolus**. On ne peut décrire le mouvement d'un corps que par rapport à un autre corps, ou à un point, qu'on **suppose** immobile (un référentiel).

Ainsi, on peut soit décrire le mouvement du soleil par rapport à la terre en **supposant** celle-ci immobile (comme le faisaient les anciens astronomes), soit décrire le mouvement de la terre par rapport au soleil en **supposant** celui-ci immobile.

Il n'y a pas erreur d'un côté et vérité de l'autre. Il y a deux façons de se représenter le **mouvement relatif** de la terre et du soleil, qui est la seule chose qu'on puisse **observer**. Aux yeux du physicien, la question de savoir *si c'est le soleil qui tourne ou si c'est la terre* n'a pas de sens. L'opposition du géocentrisme à l'héliocentrisme n'est pas l'opposition entre deux opinions, l'une fausse et l'autre vraie ; c'est l'opposition entre deux **hypothèses**. Ni la théorie héliocentrique n'est absolument vraie, ni la théorie géocentrique n'est absolument fausse.

### B. Sauver les phénomènes

Intéressons-nous aux idées de Pierre Duhem. Dans *Sauver les phénomènes*, l'auteur survole l'histoire de l'astronomie de la Grèce antique jusqu'à Galilée, et examine l'idée que les astronomes se sont faite de la théorie physique. Les théories physiques sont-elles des vérités ? Ont-elles la prétention d'être vraies ?

Il y a au cours de l'histoire de l'astronomie deux conceptions qui s'opposent : les uns croient que l'astronomie permet d'atteindre des vérités absolues ; les autres croient que le but de l'astronomie est seulement de « sauver les apparences » ou (autre traduction) de « sauver les phénomènes ». L'expression est empruntée par Duhem à Simplicius, un philosophe platonicien.

Les phénomènes, ou les apparences : les choses qu'on voit, les choses qu'on peut observer ; dans la question qui nous occupe, la position du soleil dans le ciel. Le but de l'astronomie (et de la physique en général) est de sauver les phénomènes, c'est-à-dire d'**imaginer** une combinaison de mouvements géométriques, un modèle mathématique, dont le résultat soit conforme aux données de l'observation.

Or **il est possible de sauver les phénomènes au moyen de plusieurs hypothèses** : par exemple, l'hypothèse de la terre immobile (théorie géocentrique) et l'hypothèse du soleil immobile (théorie héliocentrique). Hypothèse : supposition. Dans les deux cas, les apparences peuvent être sauvées. Par conséquent, ces hypothèses ne peuvent jamais devenir des vérités démontrées. Ni l'immobilité de la terre ni l'immobilité du soleil ne sont des vérités.

La plupart des astronomes de l'Antiquité et du Moyen Âge adoptaient l'hypothèse géocentrique. Depuis Copernic, l'hypothèse héliocentrique a été préférée, pour des raisons de simplicité, puisqu'elle permet d'éliminer les épicycles.

D'ailleurs les Anciens connaissaient le modèle héliocentrique. Duhem cite à ce sujet ce passage :

> C'est pour cela qu'Héraclide du Pont déclarait qu'il est possible de sauver l'irrégularité apparente du mouvement du Soleil en admettant que le Soleil demeure immobile et que la Terre se meut d'une certaine manière. Il n'appartient donc aucunement à l'astronome de connaître quel corps est en repos par nature, de quelle qualité sont les corps mobiles ; il pose à titre d'hypothèse que tels corps sont immobiles, que tels autres sont en mouvement, et il examine quelles sont les suppositions avec lesquelles s'accordent les apparences célestes.

### C. Descartes et l'horloge

Que signifie « sauver les phénomènes » ? Nous en trouvons une explication dans les *Principes de la philosophie* de Descartes, quatrième partie, articles 203 à 205.

Le physicien est devant la nature comme un horloger devant une montre qu'il n'a pas faite. Il voit le mouvement des aiguilles, mais il ne voit pas le mécanisme qui produit ces mouvements apparents. Il ne peut que l'imaginer. Le mouvement des aiguilles, ce sont les phénomènes, les choses observables (par exemple le mouvement relatif du soleil par rapport à la terre). L'effort du physicien est d'imaginer le mécanisme qui produit ces mouvements : c'est la théorie physique. La théorie est recevable si les mouvements observables sont identiques à ceux que produirait ce mécanisme. Mais on ne peut pas affirmer que la réalité soit telle qu'on l'imagine : deux montres peuvent être identiques extérieurement et être différentes à l'intérieur.

La théorie peut être fausse, mais même dans ce cas elle conservera son utilité. Le but de la physique, selon Descartes, n'est pas tant la connaissance de la vérité que de nous rendre « comme maîtres et possesseurs de la nature ».

### D. L'affaire Galilée

Certains astronomes ont cru au contraire que l'astronomie permettait de connaître des vérités absolues. C'est le cas notamment de Galilée. Ce qu'on reproche à Galilée, c'est précisément la prétention d'affirmer comme des vérités absolues ce qui n'était que des hypothèses.

Lectures suggérées : Duhem, *La théorie physique*, chapitre III ; du même auteur, *Sauver les phénomènes*, chapitre I.

### E. Résumé

La rondeur de la terre est une vérité certaine. En revanche, l'immobilité du soleil n'est pas une vérité : c'est une **hypothèse** sur laquelle on bâtit une **théorie**. Le but d'une théorie physique est de « sauver les apparences ». Or on peut sauver les apparences au moyen de plusieurs hypothèses.

## VI. Du préjugé qui veut qu'il n'y ait de science que la physique

### A. Le préjugé

On emploie souvent le mot de *science* comme s'il était synonyme de *physique* : comme s'il n'y avait pas de science en dehors des sciences de la nature, comme s'il n'y avait pas de **vérité certaine** en dehors des sciences naturelles. « On sait que la terre tourne autour du soleil ; mais on ne peut pas savoir (par exemple) si Dieu existe. On peut y croire ou ne pas y croire, sans plus. »

### B. Francis Bacon

Cette opinion (qu'il n'y a de certitude que dans les sciences physiques) se trouve notamment chez le philosophe Francis Bacon, le chancelier Bacon, auteur du *Novum organum* (à ne pas confondre avec l'immense peintre Francis Bacon). Voltaire voyait dans Bacon « le père de la philosophie expérimentale » (nous dirions aujourd'hui des sciences expérimentales, de ce qu'on appelle dans le langage contemporain « la science »). Certains voient dans ce jugement une plaisanterie : la contribution de Bacon à la physique est en réalité inexistante, comme le montre Joseph de Maistre dans son *Examen de la philosophie de Bacon*. Bacon serait mort, dit-on, après avoir pris froid en essayant de congeler un poulet dans la neige.

Mais c'est bien de Bacon que vient cette idée qu'il n'y aurait de **certitude** que dans la physique. Pour Bacon, il n'y a qu'une science, la physique expérimentale. Les autres sciences ne méritent pas vraiment ce nom : elles sont affaire d'opinion, de croyance. La **métaphysique**, par exemple, qui s'occupe des preuves de l'existence de Dieu, n'est pas une science : il n'y a pas de véritables preuves de l'existence de Dieu ou de l'âme humaine. L'existence de Dieu n'est pas, comme le croyait Aristote (le Premier Moteur), une vérité certaine, mais une opinion. On ne peut pas savoir si Dieu existe ; on peut y croire ou ne pas y croire.

### C. Kant et le positivisme

Cette thèse est aussi celle d'un autre livre célèbre, à savoir la *Critique de la raison pure* de Kant. La métaphysique, dit Kant, n'est pas une science. Il n'y a pas de preuves de l'existence de Dieu. La métaphysique n'est pas une science parce qu'elle ne s'appuie pas sur **l'expérience**.

C'est aussi l'idée principale de la philosophie que le XIXe siècle appellera **positivisme**. Auguste Comte. Sciences positives : sciences fondées sur l'observation, par opposition à la métaphysique. Il n'y aurait de certitude, et donc de science à proprement parler, que fondée sur l'expérience. (Auguste Comte se fit d'ailleurs le grand-prêtre d'une religion de l'Humanité.)

### D. Paradoxe d'une métaphysique qui condamne la métaphysique

Que faut-il penser de cette idée qu'il n'y a pas de science en dehors de la physique expérimentale, et que la métaphysique notamment n'est pas une science ?

Cette idée a quelque chose de paradoxal. Quelle est cette science qui permet d'affirmer qu'il n'y a pas de certitude en dehors de la physique ? Ce n'est pas la physique. « La science ne pense pas », dit Heidegger.

La science qui se prononce sur le critère de la vérité, sur ce qui est science et sur ce qui ne l'est pas, c'est ce qu'on a toujours appelé la métaphysique. Les penseurs comme Bacon ou Kant ont bien une métaphysique, laquelle consiste principalement à affirmer... que la métaphysique n'existe pas ! Paradoxe d'une métaphysique qui condamne la métaphysique.

Cette affirmation, dit Maistre, est non seulement fausse mais dangereuse. « Les sciences naturelles ne doivent point être exclusivement cultivées, ni jamais mises à la première place. »

### E. La réponse de Descartes

Voyons ce qu'en pense, par exemple, Descartes, dont la contribution aux sciences physiques est autrement plus sérieuse que celle de Bacon, puisqu'il est le père, entre autres choses, de l'optique. La quatrième partie du *Discours de la méthode* s'intitule « Preuves de l'existence de Dieu et de l'âme humaine, ou fondements de la **métaphysique** ».

S'il y a bien une chose que je **sais**, c'est que j'existe. Qui peut douter un seul instant de sa propre existence ? Je ne peux pas imaginer un seul instant que je n'existe pas. Si je rêve, c'est que j'existe. Il n'y a pas de **vérité plus certaine** : c'est même une vérité *entièrement indubitable* (indubitable : dont on ne peut pas douter). « Je pense, donc je suis. »

Maintenant, qu'est-ce que ce *moi* ? Est-ce un corps ? Est-ce que *mon corps* et *moi*, c'est la même chose ? Non : mon corps, c'est le corps qui est le mien, c'est le corps qui est à moi ; ce n'est pas moi. Je suis (dit Descartes) *quelque chose qui pense* : autrement dit un esprit ou une âme.

Il n'y a donc rien de plus certain que l'existence de l'âme humaine, et pourtant ce n'est pas une vérité physique. L'existence de l'âme est même plus certaine que l'existence du corps. Elle est donc fausse, cette philosophie (le matérialisme) qui prétend qu'il n'y a rien de plus certain que l'existence des choses matérielles. Et il n'est pas vrai que la physique soit la seule science. (Voir le chapitre suivant, sur la métaphysique de Descartes.)

### F. Lecture : le but de la philosophie de Bacon

Joseph de Maistre, *Examen de la philosophie de Bacon*, chapitre XII : « But général de la philosophie de Bacon ».

La question est celle du but des sciences physiques. Maistre traduit avec malice un texte où Bacon énumère ce qu'il attend des sciences naturelles : des choses qui paraissent impossibles mais qui pourraient devenir possibles avec le progrès des sciences physiques. L'un des objets de recherche que Bacon propose aux physiciens, c'est la prolongation de la vie (voir les circonstances de la mort de Bacon). Accélération de certains phénomènes. Transmutation d'une matière dans une autre. Création de nouvelles espèces d'êtres vivants.

Le but des sciences physiques, d'après ce texte, ne paraît pas être la connaissance de la vérité, mais l'acquisition d'un pouvoir quasi divin (et peut-être illusoire). D'autre part, certains des objectifs dont parle Bacon ont été atteints : par exemple des armes de destruction massive.

Descartes, dans le *Discours de la méthode*, déclare de même que les sciences physiques ont pour but de nous rendre « comme maîtres et possesseurs de la nature ». La vérité ou la fausseté d'une théorie devient presque secondaire : la théorie vaut plus par son utilité que par sa vérité.

## Texte : Lalande, *Abrégé d'astronomie*, livre premier

> 37. L'observation de la hauteur du pôle et de la hauteur de l'équateur, ou, si l'on veut, de la hauteur méridienne du soleil en différents pays, fut la première chose qui dut apprendre aux hommes que la terre était ronde. Ce fut d'abord par l'ombre du soleil que l'on détermina les différences de hauteurs du pôle ; plus on avançait vers le nord, plus ces ombres mesurées le même jour se trouvaient longues ; ce qui prouvait que la hauteur du soleil au-dessus de l'horizon était devenue plus petite, et que l'observateur situé vers le nord n'était pas sur le même plan que l'observateur situé vers le midi. On dut en conclure que la terre était arrondie.
>
> 38. L'ombre de la terre dans les éclipses de lune paraît toujours ronde ; les vaisseaux vus de loin en pleine mer, disparaissent par degrés ; et on les voit descendre et se perdre peu à peu, par la courbure de la surface des eaux. Telles furent les marques auxquelles les anciens philosophes reconnurent la courbure et la rondeur de la terre.
>
> 39. Après avoir ainsi reconnu la rondeur de la terre, on se servit du même moyen pour connaître sa grandeur : et le changement des latitudes et des hauteurs, soit du pôle, soit des astres, servit à connaître l'étendue de notre globe en en mesurant une petite partie [...].
>
> 40. Autre exemple : on trouve en allant vers le nord que la latitude d'Amiens est plus grande que celle de Paris d'un degré, ou que le soleil à midi est d'un degré plus bas à Amiens qu'à Paris ; c'est une preuve que la terre a un degré de courbure depuis Paris jusqu'à Amiens ; or cette distance mesurée en allant toujours du midi au nord, s'est trouvée de 25 lieues, chacune de 2283 toises ; donc un degré de la terre, ou la 360e partie de toute sa circonférence, a 25 lieues d'étendue ; d'où il suit que la circonférence entière ou le tour de la terre vaut 9000 lieues ; car 25 fois 360 font 9000.
