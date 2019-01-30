# LoopBack App Base Image
# Installs StrongLoop and Git
FROM node:10.15.0-jessie

RUN apt-get update && \
      apt-get -y install sudo


RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#USER docker


RUN mkdir data
RUN git --version
RUN sudo npm install -g loopback-cli
RUN sudo npm install loopback-connector-mysql --save


# Create App Directory and CD into it
RUN mkdir /data/app
WORKDIR /data/app

# Clone Master and Install dependencies
#RUN sudo git clone https://github.com/LordOfTheRains/adapt-backend.git
RUN git clone https://github.com/LordOfTheRains/adapt-backend.git


# Run App
WORKDIR /data/app/adapt-backend
RUN sudo chmod 777 docker-entrypoint.sh
ENTRYPOINT ["./docker-entrypoint.sh"]
