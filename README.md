# liquinstall

**Ce projet est prévu pour mon usage personnel, il est donc fortement opinioné et le restera.**

Ce projet a pour but d’installer tous les outils et applications représentant un minimum requis pour mon environnement de travail. Il se compose d’un script d’installation et de quelques fichiers de configuration (**li**nux **qui**ck **install**).

Le script d’installation est prévu pour être exécuté sur un environnement Ubuntu récent. Il sera mis à jour lorsque mes besoins et habitudes évolueront.

## Qu’est-ce que ça fait ?

Mise à jour des dépendances de la distribution est effectuée, installation des paquets « courants » pour le build (`software-properties-common` et `build-essential`) et ajout du support de HTTPS pour `apt` (`apt-transport-https` et `ca-certificates`).

Le script installe et configure également les applications et utilitaires listés ci-après.

### Applications

- [terminator](https://doc.ubuntu-fr.org/terminator) - _Terminal_
- [Google Chrome](https://www.google.fr/chrome/index.html) - _Navigateur_
- [Visual Studio Code](https://code.visualstudio.com) - _IDE_
- [GitKraken](https://www.gitkraken.com/git-client) - _GUI pour `git`_
- [Sqlectron](https://sqlectron.github.io) - _Client SQL_
- [Lens](https://k8slens.dev/) - _Kubernetes IDE_

### Utilitaires

- [zsh](https://www.zsh.org) - _Shell_
- [oh-my-zsh](https://ohmyz.sh) - _Plugins et thèmes pour `zsh`_
- [git](https://doc.ubuntu-fr.org/git) - _Contrôle de version_
- [curl](https://curl.haxx.se) - _HTTP FTW_
- [gnupg](https://www.gnupg.org) - _Chiffrement_
- [exa](https://the.exa.website) - _Remplacement de `ls`_
- [docker](https://www.docker.com) - _Gestion de conteneurs_
- [gcloud](https://cloud.google.com/sdk) - _CLI pour opérer Google Cloud_
- [aws](https://aws.amazon.com/fr/cli) - _CLI pour opérer AWS_
- [kubectl](https://kubernetes.io/docs/reference/kubectl/overview) - _CLI pour opérer des clusters Kubernetes_
- [openjdk](https://adoptium.net) - _Java Development Kit_
- [nvm](https://github.com/nvm-sh/nvm) - _Gestionnaire de versions pour `node.js`_
- [node.js](https://nodejs.org) - _Environnement d’exécution JavaScript_
- [npm](https://www.npmjs.com) - _Gestionnaire de paquet pour `node.js`_

### Extensions Visual Studio Code

- [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) - _Support des fichiers Dockerfile_
- [DotENV](https://marketplace.visualstudio.com/items?itemName=mikestead.dotenv) - _Support des fichiers .env_
- [Markdown All in One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one) - _Support complet du markdown avec prévisualisation_
- [StandardJS - JavaScript Standard Style](https://marketplace.visualstudio.com/items?itemName=chenxsan.vscode-standardjs) - _Intégration de `standard`_
- [vscode-icons](https://marketplace.visualstudio.com/items?itemName=vscode-icons-team.vscode-icons) - _Pack d’icônes_

### Paquets NPM

- [npm-check-updates](https://www.npmjs.com/package/npm-check-updates) - _Gestionnaire de mise à jour des paquets `npm`_
- [standard](https://standardjs.com) - _Style de code JS_
- [yarn](https://yarnpkg.com/) - _Gestionnaire de paquet alternatif pour `node.js`_

### Configurations

#### ZSH

Un fichier `.zprofile` est créé et sourcé depuis le `.zshrc`. Ce fichier contient les éléments suivants :

- définition de la variable d’environnement `DEFAULT_USER`
- remplacement de `ls` par `exa` via un alias
- alias `k` pour `kubectl`
- fonction `mkcd` (créé un répertoire et `cd` dedans)
- chargement automatique de `nvm`
- configuration du prompt [`pure`](https://github.com/sindresorhus/pure)

#### Terminator

Un profil par défaut est défini :

- style du terminal : texte gris clair sur fond gris/bleu très sombre
- tampon de défilement : 50000 lignes
- commande personnalisée : `/bin/zsh`

Des _keybindings_ personnalisés sont également définis pour une utilisation plus facile avec un clavier TypeMatrix en disposition de touches BÉPO.

- `Alt + W` - _Fermer la fenêtre active du terminal_
- `Maj + Alt + D` - _Scinder le terminal horizontalement_
- `Alt + D` - _Scinder le terminal verticalement_

#### Visual Studio Code

Voici les paramètres définis :

- sauvegarde automatique à la perte du focus
- indentation de 2 espaces
- ne pas afficher les espaces entre les mots
- retour à la ligne automatique à 120 caractères
- formattage automatique à la copie et sauvegarde
- utilisation de `vscode-icons` en tant que pack d’icônes par défaut
- réouvrir toutes les fenêtres après un redémarrage
- shell du terminal linux intégré `zsh`
- désactivation du crash reporter
- désactivation de la télémétrie
- `standard` autofix lors de la sauvegarde
- `standard` utilise le module du répertoire de travail courant
- désactivation de la validation JavaScript intégrée (remplacée par l’extension eslint)

#### Git

Tous les lauriers vont à [Christophe Porteneuve](https://twitter.com/porteneuve) pour ce [fichier de configuration Git aux petits oignons](https://delicious-insights.com/fr/articles/configuration-git) !

## Comment ça fonctionne ?

Deux méthodes sont possibles pour exécuter le script :

- _via `wget`_:

```shell
wget --no-check-certificate "https://raw.githubusercontent.com/nicolas-goudry/liquinstall/master/install.sh" -O - | bash
```

- _via `curl`_:

```shell
curl -L "https://raw.githubusercontent.com/nicolas-goudry/liquinstall/master/install.sh" | bash
```
