#!/bin/bash
docker build -t test . && docker swarm init && docker stack deploy -c docker-compose.yml test
sleep 10
gcc ./src/nextid.c -o ./src/nextid
sudo mv ./src/nextid /usr/bin/nextid
sudo chmod +x /usr/bin/nextid
docker exec `docker container ls | grep test:latest | awk '{print $1}'` /app/nextid_repo/nextid_server &
sleep 5
echo "Application has successfully installed"