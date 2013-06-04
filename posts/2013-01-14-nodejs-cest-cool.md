---
title: Node.js c'est cool
description: Premier pas avec Node.js
tags: Web, Node.js
---
Et si je prenais le temps de vous présenter ce qui occupe mes journées en ce moment ? Let's go, je vais vous présenter Node.js.

<img src="/files/nodejs_logo.png" title="Logo de Node.js" style="width: 220px; float: right; margin-left: 15px; margin-bottom: 15px;"/>

####Node.js c'est quoi ?

Node.js c'est une application qui tourne côté serveur afin d'exécuter du code JavaScript. Vous avez donc la possibilité (et c'est ce vers quoi Node.js est orienté) de faire des sites internets avec du code JavaScript côté client et côté serveur. C'est à dire que côté serveur vous n'utiliserez plus de PHP (ou autre), vous programmerez en **JavaScript** !

Le JavaScript va vous offrir de nombreux avantages qui seront peut être des inconvénients pour certain. Vous allez devoir créer le serveur web de toute pièce : configurer les options du serveur, gérer les requêtes envoyées par le client et envoyer au client les informations dont il a besoin. 

Cette lourde tâche, de devoir créer le serveur de toute pièce, nous offre un avantage majeur. Le JavaScript étant un langage événementiel, il nous permet de créer des sites internet très rapide car il n'y a pas de code bloquant. Un exemple pour bien comprendre l'idée : Quand vous allez chercher des données dans une base de données, vous utilisez du code bloquant. Le serveur ne peut rien faire d'autre pendant ce temps. Avec une **fonction de callback**, nous pouvons nous décharger de ce travail de recherche et la donner à une tâche qui tourne en fond. Pendant qu'elle réalise son travail, nous pouvons faire autre chose, tel que s'occuper d'un nouveau client qui vient de se connecter. 

Il y a de nombreuses descriptions sur internet qui sont plus complètes que la mienne et je vous invite à aller les lires. Il y a ce [Livre du Débutant](http://nodejs.developpez.com/tutoriels/javascript/node-js-livre-debutant/), avec sa version PDF, qui m'a permis d'en apprendre beaucoup sur Node.js. 

####Avant de commencer

Je ne vais pas vous présenter en détail comment programmer en utilisant node.js. Je vais plutôt vous rediriger vers les pages qui m'ont permis d'apprendre comment faire en y ajoutant les conseils que j'aurai aimé avoir quand j'étais à votre place. 

####On commence quand ?

Déjà vous allez devoir l'installer. Vous trouverez sur internet de nombreux sites qui l'explique. En général l'installation est très simple. De plus si vous travaillez sous Ubuntu ou sous ArchLinux, Node.js est dans les dépôts. 
Un simple *sudo apt-get install nodejs* sous Ubuntu ou un *yaourt -S nodejs* sous ArchLinux vous installera votre précieux. 

Maintenant que vous avez Node.js, commençons par une application simple. 

#####Hello World!

Le meilleur moyen de vraiment se rendre compte de l'intérêt de Node.js, c'est de faire une mini application "Hello World" avec un appel de fonction en callback. 

Je vous conseil donc de faire un fichier server.js et d'y écrire le code suivant : 

*setTimeout(function(){console.log("World");}, 1000);*<br>
*console.log("Hello ");*

Lancer votre serveur à l'aide de la ligne de commande *node server.js* et vous devriez voir apparaitre dans votre console "Hello" et une seconde après "World". 
Ce qui est important à comprendre c'est que durant la seconde d'attente, nous pouvons faire autre chose. On appel cela du "Non blocking code" et c'est un des principaux avantages de Node.js. 

Si vous ne comprennez pas cet exemple, je vous conseil vivement de lire quelques tutoriels sur les bases du JavaScript. 

####Les modules complémentaires

Avec Node.js, il est simple de travailler avec des modules. Je vais vous présenter tout ça en vous expliquant comment utiliser mon préféré, [Socket.IO](http://socket.io/). 

#####A quoi sert Socket.IO ?

Ce module permet de facilement implémenter un échange d'informations entre votre client et votre serveur sans avoir à rafraichir la page. On appelle cela le **[WebSocket](https://developer.mozilla.org/en-US/docs/WebSockets)**. Je suppose qu'actuellement vous utilisez des requêtes AJAX. C'est la même chose à la différence que vous pourrez travailler des deux côtés (client et serveur) avec des : 
- *socket.emit("data", monObjetJSON);*
- *socket.on("data",functionQuiFaitQuelqueChose(JSONObjet){});*

#####Installation et utilisation du module

Dans un premier temps il faut installer [npm](https://npmjs.org/). C'est un gestionnaire de modules pour Node.js. Il permet de gérer l'installation et la désinstallation des modules très facilement. 

Après son installation vous pourrez utiliser ces lignes de commande : 

- Pour installer Socket.IO : *npm install socket.io*. 
- Pour désinstaller Socket.IO : *npm uninstall socket.io*. 
- Pour voir les modules installés : *npm ls*

L'installation ne suffit pas pour pouvoir utiliser les méthodes de ce module. Au début de votre server.js, il faut ajouter une ligne : *var socketio = require("socket.io");*. 
Cette ligne réalise l'intégration du module au serveur tel un *#include "myLib.h"* en C.

Pour découvrir comment l'utiliser, aller sur le site de [Socket.IO](http://socket.io/). Je trouve son utilisation simple et indispensable pour faire un échange d'informations serveur/client. 

####Ok et après ? 

Node.js est encore jeune et il y a beaucoup à y découvrir. Ce que je vous propose (pas vraiment une proposition en faite), c'est que je vais continuer ma découverte de Node.js et réaliser un petit projet de jeu en ligne. 

Je vous invite à faire de même. 

Pas d'idée par où commencer ? Pourquoi ne pas faire un petit [Chat](http://www.grafikart.fr/tutoriels/nodejs/nodejs-socketio-tchat-366) en ligne (tutoriel bien fait je trouve). 
