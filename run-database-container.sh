#!/bin/bash


#pull the docker mysql container image from docker hub
docker pull mysql/mysql-server:5.7


#create docker custom network for server and database to communicate
docker network create --subnet=172.19.0.0/16 adapt-darknet

#run the container, port 3306 is automatically exposed within the dockerfile
#the adapt-darknet must be created first, if not run the folllowing to create it
#docker network create --subnet=172.19.0.0/16 adapt-darknet
docker container rm -f adapt-mysql
docker run --network=adapt-darknet --ip 172.19.0.22 --name=adapt-mysql \
-v $PWD/../datadir:/var/lib/mysql \
-v $PWD/my.cnf:/etc/my.cnf \
-v $PWD/mysql.log:/var/log/mysql/mysql.log \
-v $PWD/mysql_error.log:/var/log/mysql/mysql_error.log \
-e MYSQL_USER=adaptAdmin \
-e MYSQL_PASSWORD=password2 \
-e MYSQL_DATABASE=adapt-db \
-e MYSQL_ROOT_PASSWORD=password1 \
-d mysql/mysql-server:5.7
#-v $PWD/my.cnf:/etc/my.cnf \
#-e MYSQL_ROOT_HOST=adapt-backend.adapt-darknet \
#this is the ip the mysql server will run on, it has been coded in the loopback databasource.json.
