#!/bin/bash

# Valeurs par défaut
DEFAULT_IP="192.168.1.100" # Remplacez cette adresse par celle de votre serveur apt-cacher-ng par défaut
DEFAULT_PORT=3142

# Fonction pour configurer le fichier de proxy APT
configure_apt_proxy() {
    local ip=$1
    local port=$2

    # Vérification de la validité de l'IP et du port
    if ! [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo "Adresse IP invalide: $ip"
        exit 1
    fi

    if ! [[ $port =~ ^[0-9]+$ ]]; then
        echo "Port invalide: $port"
        exit 1
    fi

    # Configuration du proxy auto-detect
    echo "Acquire::http::Proxy-Auto-Detect \"/usr/local/bin/apt-proxy-detect.sh\";" > /etc/apt/apt.conf.d/00aptproxy

    # Script de détection du proxy
    cat <<EOF > /usr/local/bin/apt-proxy-detect.sh
#!/bin/bash
if nc -w1 -z $ip $port; then
    echo -n "http://$ip:$port"
else
    echo -n "DIRECT"
fi
EOF

    # Assurez-vous que le script de détection de proxy est exécutable
    chmod +x /usr/local/bin/apt-proxy-detect.sh
}

# Utilisation des arguments ou des valeurs par défaut
ip="${1:-$DEFAULT_IP}"
port="${2:-$DEFAULT_PORT}"

configure_apt_proxy "$ip" "$port"
