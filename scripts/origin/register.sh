#Attach to Subscription pool
REDHAT_USERNAME=$1
REDHAT_PASSWORD=$2
REDHAT_POOLID=$3

yum clean all
rm -rf /var/cache/yum

function log {
    if ! [ -f /usr/bin/cowsay ]; then
        sudo yum install -y cowsay
    fi    
    cowsay -f tux "$1"
    sleep 3
}

function install_prereqs {    
    if ! [ -f /usr/bin/ansible ]; then
        log "Instalando pre-requisitos para rodar a instalação do Openshift"
        sudo yum groupinstall "Development Tools" -y
        sudo yum install -y wget git net-tools bind-utils iptables-services bridge-utils bash-completion kexec-tools sos psacct    
        sudo yum install -y python-pip python-devel htop python-passlib python-cryptography pyOpenSSL httpd-tools     
        
        log "Instalando pre-requisitos para rodar o sistema de métricas"
        sudo yum install -y java-1.8.0-openjdk-headless
        
        log "Instalando Ansible"
        sudo pip install --upgrade pip
        sudo pip install --upgrade ansible apache-libcloud
    fi
    install_networkmanager_on_all
}

install_prereqs
