#!/usr/bin/env bash

# Simple script for required packages such as Erlang/RabitMQ and et.

SETCOLOR_SUCCESS="echo -en \\033[1;32m"
SETCOLOR_FAILURE="echo -en \\033[1;31m"
SETCOLOR_NORMAL="echo -en \\033[0;39m"
BOLD=$(tput bold)
NORMAL_FONT=$(tput sgr0)

# Firstly, update all packages
echo "${BOLD}Update your system... to Windows 10. Thx)${NORMAL_FONT}"
sudo apt-get update -y
Ysudo apt-get upgrade -y

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

# Secondly, Installing Erlang
echo "${BOLD}Install Erlang...${NORMAL_FONT}"
wget http://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc
sudo apt-key add erlang_solutions.asc
sudo apt-get update -y
sudo apt-get install erlang -y
sudo apt-get install erlang-nox -y
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

# Secondly, Installing RabbitMQ
echo "${BOLD}Install RabbitMQ...${NORMAL_FONT}"
sudo echo "deb http://www.rabbitmq.com/debian/ testing main" >> /etc/apt/sources.list
wget https://www.rabbitmq.com/rabbitmq-signing-key-public.asc
sudo apt-key add rabbitmq-signing-key-public.asc
sudo apt-get update -y
sudo apt-get install rabbitmq-server -y --allow-unauthenticated

sudo rabbitmqctl add_user radmin a
sudo rabbitmqctl set_user_tags radmin administrator
sudo rabbitmqctl set_permissions -p / radmin ".*" ".*" ".*"

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