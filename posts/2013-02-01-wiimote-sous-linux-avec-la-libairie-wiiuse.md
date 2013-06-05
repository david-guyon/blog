---
title: Wiimote sous Linux avec la lib WiiUse
description: Programmer sous Code::Blocks avec la librairie WiiUse pour utiliser une Wiimote sur un ordinateur
tags: Wiimote, C, librairie
---
<img src="/files/wiimoteWindows.jpg" title="Wiimote sous Windows" style="width: 300px; float: right; margin-left: 15px; margin-bottom: 15px;"/>

Je m'étais déjà amusé à écrire un petit programme qui récupére les données échangées entre mon PC et ma manette filaire de 360. C'était drôle mais je voulais plus de fun et j'avais toujours voulu essayer avec une Wiimote. 

C'est, à présent, chose faite puisque je viens de réussir à l'instant à faire un programme en C qui relie ma Wiimote à mon PC. 

Je vais vous expliquer en détail comment j'ai fait car la tâche n'a pas été simple. 

###Avant de commencer

Il va vous falloir une Wiimote (avec ou sans Nunchuk) ainsi qu'une clef Bluetooth.

Il faut savoir que je suis sous ArchLinux (distribution Linux). Si vous êtes sous Ubuntu (ou autre), il ne devrait pas y avoir de problème. Tout ce qu'il vous faut c'est s'assurer que **bluez** est installé. 

lien utile : [ArchLinux - wiki : Wiimote](https://wiki.archlinux.org/index.php/Wiimote)

Si tu es sous Windows, ça devrait fonctionner mais ça reste à vérifier. La librairie que nous allons utiliser est compatible WIN32 (c'est ce que j'en ai déduit en lisant le code source de la librairie). 

####Essayons voir si ça marche

Ouvre ton terminal préféré et lance : "*hcitool scan*". Appui sur les boutons "1" et "2" de la Wiimote afin d'effectuer une recherche. Si tout se passe bien, tu devrais avoir quelque chose comme ça :
<pre>
Scanning ...
00:1E:35:2F:34:FA	Nintendo RVL-CNT-01
</pre>

####Essayons quelque chose de plus drôle

Dans le même terminal, lance : "*sudo wminput*". Appui sur "1" et "2" et tu devrais voir ceci dans la console :
<pre>
Put Wiimote in discoverable mode now (press 1+2)...
Ready.
</pre>


Maintenant bouge ta Wiimote ! Héhé, non tu ne rêves pas. Tu peux effectivement contrôler la souris de ton PC avec ta Wiimote. Tu vas vite te rendre compte que c'est pas pratique mais c'est tout de même une bonne avancé. Il ne nous reste qu'à utiliser tout ceci dans un projet personnel avec un but plus intéressant. 

*Pour quitter wminput, un Ctrl+c dans la console va tuer le processus.*

Attaquons nous maintenant au plus intéressant, le code source ! 

###La librairie WiiUse

Pour commencer, nous allons avoir besoin d'une librairie. J'ai trouvé la librairie **WiiUse** qui me parrait bien par sa taille, sa compatibilité Linux/Windows et le fait qu'elle soit simple et complète à la fois. 

####Liens
* [Page de téléchargement de la librairie](http://sourceforge.net/projects/wiiuse/files/wiiuse/)
* [Github du projet](https://github.com/rpavlik/wiiuse)
* [Documentation de WiiUse](http://www.vrac.iastate.edu/vancegroup/docs/wiiuse/index.html)

####Code source et compilation

J'ai utilisé Code::Blocks pour écrire mon code source mais libre à vous d'utiliser l'IDE que vous voulez.

Créer un nouveau projet "Console application" et ajoutez y les fichiers *.h* et *.c* de la librairie que vous avez téléchargé. Pour mon cas, j'ai préféré créer un dossier libs/ qui contient l'ensemble de la librairie. 

Ensuite copiez le code présent sur ce [pastebin](http://pastebin.com/57X5Dhqy) dans votre *main.c*. Je précise avant de recevoir des remarques : le code source est en grande partie copié/collé. J'étais pressé de faire fonctionner mon affaire. Dans un avenir proche, je vais écrire mon propre code source en fonction de mon application. 

Votre main.c est prêt ? Super mais ne compilez pas ! Du moins, pas avec Code::Blocks. Vous allez avoir des erreurs pénibles à résoudre. En faite, durant la compilation il faut ajouter l'argument "**-lbluetooth**". J'ai cherché et essayé des choses sans succès. La solution que j'ai trouvé la plus simple a été de compiler mon projet à l'aide de GCC dans un terminal. C'était ma vrai première fois et comprendre comment le configurer n'a pas été très simple (mais, comme on dit, c'est en cherchant que l'on apprend). 

Si vous êtes prêt à compiler, allez dans un terminal et placez vous dans le dossier de votre projet. Ecrivez **gcc -o nomDeMonPgr main.c libs/\*.c libs/\*.h -lbluetooth -lm**. 
Cette ligne va compiler votre main.c ainsi que ses librairies et créer un exécutable "nomDeMonPgr". Là où j'ai perdu pas mal de temps, c'est qu'il faut ajouter tous les .c et .h du projet dans la ligne de commande de gcc. Il faut aussi ajouter les librairies Linux utilisées (bluetooth et math) à l'aide des deux derniers arguments passés à gcc. 

Lancer votre application : **./nomDeMonPgr**

Vous devriez voir ceci dans votre terminal : 
<pre>
wiiuse v0.12 loaded.
By: Michael Laforest thepara[at]gmail{dot}com
http://wiiuse.net  http://wiiuse.sf.net
Wiimote Basic Test
[INFO] Found 1 bluetooth device(s).
[INFO] Found wiimote (00:1E:35:2F:34:FA) [id 1].
[INFO] Connected to wiimote [id 1].
Connected to 1 wiimotes (of 1 found).
[INFO] wiiuse clean up...
</pre>
Et normalement votre Wiimote a du vibrer 200ms et rester allumée 10s avec le voyant numéro 1 brillant de mille feux. 

Si jusqu'à là vous avez les mêmes résultats que moi, c'est que vous avez les bases nécessaires pour commencer un projet avec une Wiimote. C'est d'ailleurs ce que je vais faire dans peu de temps. 
Si vous n'avez pas eu de chance et que ça ne fonctionne pas comme vous le voulez, postez votre problème en commentaire. J'ai peut être la réponse étant donné que j'ai passé un après midi entier dessus pour que ça fonctionne ;). 

En espérant que ces notes vous soient utiles, à bientôt. 
