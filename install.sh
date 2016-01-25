#!/bin/bash

echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu wily main" | tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu wily main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
apt-get update

apt-get install -y software-properties-common
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
apt-get install -y oracle-java8-installer

apt-get install -y nodejs
ln -s /usr/bin/nodejs /usr/bin/node
apt-get install -y npm
echo "registry=${npm_repo}" | tee /root/.npmrc
npm --strict-ssl=false install -g swagger-tools
mkdir /swagger-doclet
wget --no-check-certificate ${maven_repo}/com/carma/swagger-doclet/1.1.1/swagger-doclet-1.1.1.jar -O /swagger-doclet/swagger-doclet-1.1.1.jar

apt-get remove -y --purge build-essential gcc-5 perl perl-modules libicu55
echo 'Yes, do as I say!' | apt-get remove -y --force-yes --purge systemd
apt-get autoremove -y
rm -rf /var/lib/apt/lists/*
rm -rf /var/cache/oracle-jdk8-installer
rm -rf /usr/lib/jvm/java-8-oracle/src.zip
rm -rf /usr/lib/jvm/java-8-oracle/javafx-src.zip
rm -rf /usr/lib/jvm/java-8-oracle/lib/missioncontrol
rm -rf /usr/lib/jvm/java-8-oracle/lib/visualvm
