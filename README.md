[Vagrant]:
Requirements:
1) Up-to-date Oracle VM VirtualBox(v.5.2.14 or higher)
2) Up-to-date Vagrant by HashiCorp(v.2.1.0 or higher)
Notice: vagrant v.2.1.2 on Ubuntu 16.0.4 LTS can cause trouble as described here
(https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=890662) Install lower version
of vagrant(2.1.0) or upgrade your Ubuntu.
Guide:
1) Clone this repo to the folder <your_folder>
2) cd to the folder <your_folder/vagrant-test>
3) Run 'vagrant up'
4) After installation run on your host machine in <your_folder/vagrant-test>:
'sudo chmod +x run.sh uninstall.sh && ./run.sh'
5) That's all! To get your unique id you should just run 'nextid gen'
6) To stop your vagrant vm run : 'vagrant halt'
7) To uninstall this application run : '<your_folder/vagrant-test>/uninstall.sh'
[Docker]:
Requirements:
1) Up-to-date Docker CE (v.18.03.1-ce and higher)
Guide:
1) Clone this repo to the folder <your_folder>
2) cd to the folder <your_folder/docker-test>
4) Run : 'sudo chmod +x run.sh uninstall.sh && ./run.sh'
5) That's all! To get your unique id you should just run 'nextid gen'
6) To stop your docker manually run : 'docker stack rm test && docker swarm leave --force'
7) To uninstall this application run : '<your_folder/docker-test>/uninstall.sh'