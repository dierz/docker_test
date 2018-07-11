#!/bin/bash
check_installed()
{
    array=( $(yum list installed | grep -Eo "\b($1|$2|$3|$4).(x86_64|noarch)") )
    return ${#array[@]}
}
check_running()
{
    active=$(sudo systemctl status $1 | grep Active: | awk '{print $3}')
    if [  "$active" = "(running)" ]
    then
        return 0
    fi
}
sudo yum install git -y
sudo yum install mariadb-server -y
sudo yum install mariadb-devel -y
sudo yum install gcc -y
check_installed git mariadb-server mariadb-devel gcc
if (( $? < 4 ))
then
    echo Installation error. Exiting..
    return 1
fi
sudo systemctl enable mariadb
sudo systemctl start mariadb
git clone https://github.com/dierz/nextid_repo.git /home/vagrant/nextid_repo
check_running mariadb
if (( $? != 0 ))
then
    echo error
    return 1
fi
mysql -uroot < /home/vagrant/nextid_repo/dump.sql
if ((`mysql -uroot -e "select * from counter.nextid\G" | grep id \
    | awk '{print $2}'` != 1))
then
    echo mysql error
    return 1
fi

if [ -r /home/vagrant/nextid_repo/nextid.service ]
then
    sudo cp /home/vagrant/nextid_repo/nextid.service /lib/systemd/system/
else
    echo nextid.service not found!
    exit 1
fi
if [ ! -r /lib/systemd/system/nextid.service ]
then
    echo Error.
    return 1
fi

if [ ! -r /home/vagrant/nextid_repo/src/nextid_server_vagrant.c ]
then
    echo Error.
    return 1
fi
sudo gcc /home/vagrant/nextid_repo/src/nextid_server_vagrant.c \
-o /home/vagrant/nextid_repo/nextid_server `mysql_config --libs --include`
if [ ! -x /home/vagrant/nextid_repo/nextid_server ]
then
    echo Error.
    return 1
fi

sudo chmod +x /home/vagrant/nextid_repo/nextid_server
sudo systemctl enable nextid
sudo systemctl start nextid
check_running nextid
if (( $? != 0 ))
then
    echo error
    return 1
else
    echo Application has beeb installed
fi