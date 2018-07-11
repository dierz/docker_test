#!/bin/bash
sudo yum install git -y
sudo yum install mariadb-server -y
sudo yum install mariadb-devel -y
sudo yum install gcc -y
sudo systemctl enable mariadb
sudo systemctl start mariadb
git clone https://github.com/dierz/nextid_repo.git /home/vagrant/nextid_repo
mysql -uroot < /home/vagrant/nextid_repo/dump.sql
sudo cp /home/vagrant/nextid_repo/nextid.service /lib/systemd/system/
sudo gcc /home/vagrant/nextid_repo/src/nextid_server.c \
-o /home/vagrant/nextid_repo/nextid_server `mysql_config --libs --include`
sudo chmod +x /home/vagrant/nextid_repo/nextid_server
sudo systemctl enable nextid
sudo systemctl start nextid