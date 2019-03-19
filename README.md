[terminator]: https://doc.ubuntu-fr.org/terminator
[chrome]: https://www.google.fr/chrome/index.html
[gitkraken]: https://www.gitkraken.com/git-client
[insomnia]: https://insomnia.rest
[slack]: https://slack.com
[caprine]: https://sindresorhus.com/caprine
[vscode]: https://code.visualstudio.com
[zsh]: https://www.zsh.org
[omz]: https://ohmyz.sh
[git]: https://doc.ubuntu-fr.org/git
[curl]: https://curl.haxx.se
[gnupg]: https://www.gnupg.org
[node]: https://nodejs.org
[npm]: https://www.npmjs.com
[expo]: https://www.npmjs.com/package/expo-cli
[ncu]: https://www.npmjs.com/package/npm-check-updates
[prettier]: https://www.npmjs.com/package/prettier
[standard]: https://www.npmjs.com/package/standard
[exa]: https://the.exa.website
[kubectl]: https://kubernetes.io/docs/reference/kubectl/overview
[docker]: https://www.docker.com
[gcloud]: https://cloud.google.com/sdk
[powerlevel9k]: https://github.com/bhilburn/powerlevel9k
[powerlinefonts]: https://github.com/powerline/fonts
[npmfix]: https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally
[codedocker]: https://marketplace.visualstudio.com/items?itemName=PeterJausovec.vscode-docker
[codedotenv]: https://marketplace.visualstudio.com/items?itemName=mikestead.dotenv
[codegraphql]: https://marketplace.visualstudio.com/items?itemName=prisma.vscode-graphql
[codenpm]: https://marketplace.visualstudio.com/items?itemName=eg2.vscode-npm-script
[codeprettier]: https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode
[codestandard]: https://marketplace.visualstudio.com/items?itemName=chenxsan.vscode-standardjs
[codeicons]: https://marketplace.visualstudio.com/items?itemName=vscode-icons-team.vscode-icons

# liquinstall

**Ce projet est prévu pour mon usage personnel, il est donc fortement opinioné et devrait le rester.**

Ce projet a pour but d’installer tous les outils et applications représentant un minimum requis pour mon environnement de travail. Il se compose d’un script d’installation et de quelques fichiers de configuration (**li**nux **qui**ck **install**).

Le script d’installation est prévu pour être exécuté sur un environnement Ubuntu récent (18.04 au minimum). Il sera mis à jour lorsque mes besoins et habitudes évolueront.

## Qu’est-ce que ça fait ?

- désinstallation d’une précédente installation de Docker
- mise à jour des dépendances de la distribution
- ajout du support de HTTPS à apt (`apt-transport-https` et `ca-certificates`)
- installation des `software-properties-common` et `build-essential`

Le script installe et configure également les éléments listés ci-après.

### Applications

- [terminator][terminator] - _Terminal_
- [Google Chrome][chrome] - _Navigateur_
- [GitKraken][gitkraken] - _GUI pour `git`_
- [Insomnia][insomnia] - _Client HTTP REST_
- [Slack][slack] - _Client Slack_
- [Caprine][caprine] - _Client pour Facebook Messenger_
- [Visual Studio Code][vscode] - _IDE_

### Utilitaires

- [zsh][zsh] - _Remplacement de `bash`_
- [oh-my-zsh][omz] - _Plugins et thèmes pour `zsh`_
- [git][git] - _git everything_
- [curl][curl] - _HTTP FTW_
- [gnupg-agent][gnupg] - _Chiffrement_
- [node.js][node] - _Environnement d’exécution JavaScript_
- [npm][npm] - _Gestionnaire de paquet pour `node.js`_
- [expo][expo] - _CLI pour expo_
- [ncu][ncu] - _Gestionnaire de mise à jour des paquets `npm`_
- [prettier][prettier] - _Formatteur de code_
- [standard][standard] - _Configuration_
- [exa][exa] - _Remplacement de `ls`_
- [kubectl][kubectl] - _CLI pour opérer des clusters Kubernetes_
- [docker][docker] - _Gestion de conteneurs_
- [gcloud][gcloud] - _Google Cloud SDK_

### Divers

- [powerlevel9k][powerlevel9k] - _Thème `zsh`_
- [Meslo][powerlinefonts] - _`powerlevel9k` requiert une police compatible Powerline_
- [Correction des permissions `npm`][npmfix] - _Évite d’avoir à utiliser `sudo` pour installer des paquets globaux_

### Extensions Visual Studio Code

- [Docker][codedocker] - _Coloration syntaxique pour Dockerfile_
- [DotENV][codedotenv] - _Coloration syntaxique pour .dotenv_
- [GraphQL][codegraphql] - _Coloration syntaxique pour le langage GraphQL_
- [npm][codenpm] - _Support de `npm`_
- [Prettier - Code formatter][codeprettier] - _Intégration de `prettier`_
- [StandardJS - JavaScript Standard Style][codestandard] - _Intégration de `standard`_
- [vscode-icons][codeicons] - _Pack d’icônes_

## Comment ça fonctionne ?

**Avant d’exécuter le script, il est conseillé d’être déjà authentifié via `sudo` avec l’utilisateur principal de l’environnement final.**

Deux méthodes sont possibles pour exécuter le script :

- _via `wget`_:

```shell
wget --no-check-certificate "https://raw.githubusercontent.com/nicolas-goudry/liquinstall/master/install.sh" -O - | bash
```

- _via `curl`_:

```shell
curl -L "https://raw.githubusercontent.com/nicolas-goudry/liquinstall/master/install.sh" | bash
```
