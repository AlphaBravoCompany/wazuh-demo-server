#!/bin/bash

set -e

G="\e[32m"
E="\e[0m"

if ! grep -q 'Ubuntu' /etc/issue
  then
    echo -----------------------------------------------
    echo "Not Ubuntu? Could not find Codename Ubuntu in lsb_release -a. Please switch to Ubuntu."
    echo -----------------------------------------------
    exit 1
fi

## Update OS
echo "Updating OS packages..."
sudo apt update > /dev/null 2>&1
sudo apt upgrade -y > /dev/null 2>&1

## Install Prereqs
echo "Installing Prereqs..."
sudo apt-get update > /dev/null 2>&1
sudo apt-get install -y \
apt-transport-https ca-certificates curl gnupg lsb-release \
software-properties-common haveged bash-completion jq > /dev/null 2>&1

## Install Docker
echo "Installing Docker..."
sysctl -w vm.max_map_count=262144 > /dev/null 2>&1
curl -sSL https://get.docker.com/ | sh > /dev/null 2>&1
systemctl start docker > /dev/null 2>&1
usermod -aG docker $USER  > /dev/null 2>&1

## Install Docker Compose
echo "Installing docker-compose..."
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose > /dev/null 2>&1
chmod +x /usr/local/bin/docker-compose > /dev/null 2>&1

## Install Wazuh Docker
echo "Installing Wazuh..."
git clone https://github.com/wazuh/wazuh-docker.git -b 4.3 --depth=1 > /dev/null 2>&1
cd wazuh-docker/single-node > /dev/null 2>&1
docker-compose -f generate-indexer-certs.yml run --rm generator > /dev/null 2>&1
docker-compose up -d > /dev/null 2>&1

## Print Server Information and Links
cd ../../
touch ./server-details.txt
echo -----------------------------------------------
echo -e ${G}Install is complete. Please use the below information to access your environment.${E} | tee ./server-details.txt
echo -e ${G}Wazuh UI:${E} https://this-host-ip | tee -a ./server-details.txt
echo -e ${G}Wazuh Login${E}: admin/SecretPassword | tee -a ./server-details.txt
echo Details above are saved to the file at ./server-details.txt
echo -----------------------------------------------
