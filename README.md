Voici un exemple de fichier `README.md` que vous pouvez utiliser pour documenter votre script sur GitHub. Ce README explique ce que fait le script, comment l'installer et l'utiliser, ainsi que des informations sur les contributions et la licence.

```markdown
# Script de Détection de Proxy APT

Ce script Bash est conçu pour configurer dynamiquement le proxy APT en vérifiant la disponibilité d'un serveur proxy principal et en se repliant sur des serveurs proxy de secours si nécessaire. Si aucun proxy n'est disponible, le script configure APT pour se connecter directement aux miroirs sans utiliser de proxy.

## Fonctionnalités

- **Configuration Dynamique** : Configure automatiquement le proxy APT en utilisant le script de détection qui teste la disponibilité des serveurs proxy.
- **Support des Proxies de Secours** : Teste une liste de proxies de secours avant de passer en mode direct.
- **Facile à Étendre** : Permet d'ajouter facilement d'autres proxies de secours.

## Prérequis

Pour utiliser ce script, vous devez avoir `netcat` installé sur votre système. Vous pouvez l'installer via votre gestionnaire de paquets, par exemple :

```bash
sudo apt-get install netcat
```

## Installation

1. **Télécharger le Script** :
   Vous pouvez cloner ce dépôt ou télécharger directement le script.

   ```bash
   git clone https://github.com/manastria/apt_proxy_manager.git
   ```

   – OU –

    ```bash
    git clone git@github.com:manastria/apt_proxy_manager.git
    ```

2. **Configuration** :
   Modifiez les variables `DEFAULT_IP`, `DEFAULT_PORT` et `BACKUP_PROXIES` dans le script `configure_apt_proxy.sh` pour refléter vos serveurs proxy.

3. **Exécution** :
   Rendez le script exécutable et exécutez-le avec les droits administrateur pour configurer le système APT.

   ```bash
   chmod +x configure_apt_proxy.sh
   sudo ./configure_apt_proxy.sh
   ```

## Utilisation

Pour configurer le proxy, lancez simplement le script avec les adresses IP et les ports de votre choix comme arguments. Si aucun argument n'est fourni, les valeurs par défaut seront utilisées.

```bash
sudo ./configure_apt_proxy.sh 192.168.1.100 3142
```

## Contribuer

Les contributions à ce projet sont les bienvenues. Vous pouvez contribuer en :

- **Soumettant des Pull Requests** : Si vous avez amélioré ou ajouté de nouvelles fonctionnalités.
- **Rapportant des Bugs** : En ouvrant des issues pour discuter des bugs rencontrés et proposer des solutions.

## Licence

Ce projet est distribué sous la Licence MIT. Pour plus de détails, voir le fichier `LICENSE`.





