#!/bin/bash
sudo rm /usr/bin/nextid
sudo docker stack rm test && sudo docker swarm leave --force
echo "Application successfully uninstalled"