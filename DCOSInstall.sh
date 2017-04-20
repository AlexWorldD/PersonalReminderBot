#!/usr/bin/env bash

# Modified version of this gist: https://github.com/ryanmaclean/awful-bash-scripts/blob/master/install_recent_terraform_packer.sh

SETCOLOR_SUCCESS="echo -en \\033[1;32m"
SETCOLOR_FAILURE="echo -en \\033[1;31m"
SETCOLOR_NORMAL="echo -en \\033[0;39m"
BOLD=$(tput bold)
NORMAL_FONT=$(tput sgr0)

# Install required packages
# Firstly, jq
echo "${BOLD}Intall jq package...${NORMAL_FONT}"
apt-get -y install jq

if [ $? -eq 0 ]; then
    $SETCOLOR_SUCCESS
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[OK]"
    $SETCOLOR_NORMAL
    echo
else
    $SETCOLOR_FAILURE
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[fail]"
    $SETCOLOR_NORMAL
    echo
fi

# Secondly, unzip
echo "${BOLD}Install unzip package...${NORMAL_FONT}"
apt-get -y install unzip
if [ $? -eq 0 ]; then
    $SETCOLOR_SUCCESS
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[OK]"
    $SETCOLOR_NORMAL
    echo
else
    $SETCOLOR_FAILURE
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[fail]"
    $SETCOLOR_NORMAL
    echo
fi

# 3ly, git of course!
#echo "${BOLD}Intall git package...${NORMAL_FONT}"
#apt-get -y install git
#
#if [ $? -eq 0 ]; then
#    $SETCOLOR_SUCCESS
#    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[OK]"
#    $SETCOLOR_NORMAL
#    echo
#else
#    $SETCOLOR_FAILURE
#    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[fail]"
#    $SETCOLOR_NORMAL
#    echo
#fi

# Get URLs for most recent versions
echo "${BOLD}Getting the urls to newest Terraform and Packer... ${NORMAL_FONT}"
terraform_url=$(curl --silent https://releases.hashicorp.com/index.json | jq '{terraform}' | egrep "linux.*64" | sort -rh | head -1 | awk -F[\"] '{print $4}')
packer_url=$(curl --silent https://releases.hashicorp.com/index.json | jq '{packer}' | egrep "linux.*64" | sort -rh | head -1 | awk -F[\"] '{print $4}')

if [ $? -eq 0 ]; then
    $SETCOLOR_SUCCESS
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[OK]"
    $SETCOLOR_NORMAL
    echo
else
    $SETCOLOR_FAILURE
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[fail]"
    $SETCOLOR_NORMAL
    echo
fi

# Create a move into directory.
echo "${BOLD}Creating dicrectory... ${NORMAL_FONT}"
cd
mkdir packer
mkdir terraform && cd $_

# Download Terraform. URI: https://www.terraform.io/downloads.html
echo "${BOLD}Download Terraform, please wait... ${NORMAL_FONT}"
curl -o terraform.zip $terraform_url

if [ $? -eq 0 ]; then
    $SETCOLOR_SUCCESS
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[OK]"
    $SETCOLOR_NORMAL
    echo
else
    $SETCOLOR_FAILURE
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[fail]"
    $SETCOLOR_NORMAL
    echo
fi
# Unzip and install
echo "${BOLD}Install Terraform... ${NORMAL_FONT}"
unzip terraform.zip

if [ $? -eq 0 ]; then
    $SETCOLOR_SUCCESS
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[OK]"
    $SETCOLOR_NORMAL
    echo
else
    $SETCOLOR_FAILURE
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[fail]"
    $SETCOLOR_NORMAL
    echo
fi

# Change directory to Packer
cd ~/packer

# Download Packer. URI: https://www.packer.io/downloads.html
echo "${BOLD}Download Packer, please wait... ${NORMAL_FONT}"
curl -o packer.zip $packer_url

if [ $? -eq 0 ]; then
    $SETCOLOR_SUCCESS
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[OK]"
    $SETCOLOR_NORMAL
    echo
else
    $SETCOLOR_FAILURE
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[fail]"
    $SETCOLOR_NORMAL
    echo
fi
# Unzip and install
echo "${BOLD}Install Packer... ${NORMAL_FONT}"
unzip packer.zip

if [ $? -eq 0 ]; then
    $SETCOLOR_SUCCESS
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[OK]"
    $SETCOLOR_NORMAL
    echo
else
    $SETCOLOR_FAILURE
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[fail]"
    $SETCOLOR_NORMAL
    echo
fi
echo "${BOLD}Export PATH... ${NORMAL_FONT}"
echo '
# Terraform & Packer Paths.
export PATH=~/terraform/:~/packer/:$PATH
' >>~/.bash_profile

if [ $? -eq 0 ]; then
    $SETCOLOR_SUCCESS
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[OK]"
    $SETCOLOR_NORMAL
    echo
else
    $SETCOLOR_FAILURE
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[fail]"
    $SETCOLOR_NORMAL
    echo
fi

source ~/.bash_profile

# -----------------------------------------------
# Start configuration for Terraform
# -----------------------------------------------
cd ~/packet-terraform
# Generate SSH key
echo "${BOLD}Generate SSH keypair... ${NORMAL_FONT}"
ssh-keygen -t rsa -P '' -f ./packet-key

if [ $? -eq 0 ]; then
    $SETCOLOR_SUCCESS
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[OK]"
    $SETCOLOR_NORMAL
    echo
else
    $SETCOLOR_FAILURE
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[fail]"
    $SETCOLOR_NORMAL
    echo
fi

cp sample.terraform.tfvars terraform.tfvars

if [ $? -eq 0 ]; then
    $SETCOLOR_SUCCESS
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[OK]"
    $SETCOLOR_NORMAL
    echo
else
    $SETCOLOR_FAILURE
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[fail]"
    $SETCOLOR_NORMAL
    echo
fi

# Generate SSH key
echo "${BOLD}Let's configure your cluster! ${NORMAL_FONT}"
read -p 'API key: ' api
read -p 'Project key: ' project
read -p 'Cluster name: ' cl_name
echo  >> terraform.tfvars
echo 'packet_api_key = "'$api'"' >> terraform.tfvars
echo  >> terraform.tfvars
echo 'packet_project_id = "'$project'"' >> terraform.tfvars
echo  >> terraform.tfvars
echo 'dcos_cluster_name = "'$cl_name'"' >> terraform.tfvars
echo  >> terraform.tfvars

if [ $? -eq 0 ]; then
    $SETCOLOR_SUCCESS
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[OK]"
    $SETCOLOR_NORMAL
    echo
else
    $SETCOLOR_FAILURE
    echo -n "$(tput hpa $(tput cols))$(tput cub 6)[fail]"
    $SETCOLOR_NORMAL
    echo
fi

# ------------------------------------
# Creating cluster with Terraform scrip
export TF_LOG=DEBUG
terraform apply
