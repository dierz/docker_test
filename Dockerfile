FROM centos:7

WORKDIR /app

ADD . /app

EXPOSE 8888

RUN yum install git -y
RUN yum install mariadb-devel -y
RUN yum install gcc -y
RUN git clone https://github.com/dierz/nextid_repo.git /app/nextid_repo
RUN gcc /app/nextid_repo/src/nextid_server.c -o /app/nextid_repo/nextid_server `mysql_config --libs --include`
RUN chmod +x /app/nextid_repo/nextid_server
CMD ["/sbin/init"]	
CMD ["app/nextid_repo/nextid_server", "&"]
CMD ["/bin/bash"]