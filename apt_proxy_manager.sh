#!/bin/bash

# Valeurs par défaut
DEFAULT_IP="192.168.1.100" # Remplacez cette adresse par celle de votre serveur apt-cacher-ng par défaut
DEFAULT_PORT=3142

# Liste des proxies de secours (IP:port)
BACKUP_PROXIES=(
    "172.16.0.1:3128"
    "172.16.0.1:3128"
)

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

    # Création ou mise à jour du script de détection du proxy
    cat <<EOF > /usr/local/bin/apt-proxy-detect.sh
#!/bin/bash
# Test du proxy principal
if nc -w1 -z $ip $port; then
    echo -n "http://$ip:$port"
    exit 0
fi

# Test des proxies de secours
for proxy in "${BACKUP_PROXIES[@]}"; do
    proxy_ip=\${proxy%:*}
    proxy_port=\${proxy#*:}
    if nc -w1 -z \$proxy_ip \$proxy_port; then
        echo -n "http://\$proxy_ip:\$proxy_port"
        exit 0
    fi
done

# Si aucun proxy n'est disponible
echo -n "DIRECT"
EOF

    # Assurez-vous que le script de détection de proxy est exécutable
    chmod +x /usr/local/bin/apt-proxy-detect.sh
}

# Utilisation des arguments ou des valeurs par défaut
ip="${1:-$DEFAULT_IP}"
port="${2:-$DEFAULT_PORT}"

configure_apt_proxy "$ip" "$port"
