FROM ubuntu:wily

MAINTAINER Manuel Ryan <ryan@shamu.ch>

ENV maven_repo=http://central.maven.org/maven2
ENV npm_repo=https://registry.npmjs.org/

RUN  echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu wily main" | tee /etc/apt/sources.list.d/webupd8team-java.list && \
  echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu wily main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list && \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 && \
  apt-get update

# system packages.
RUN apt-get install -y software-properties-common && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  apt-get install -y nodejs && \
  ln -s /usr/bin/nodejs /usr/bin/node && \
  apt-get install -y npm

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# swagger doclet
RUN mkdir /swagger-doclet
RUN wget --no-check-certificate ${maven_repo}/com/carma/swagger-doclet/1.1.1/swagger-doclet-1.1.1.jar \
-O /swagger-doclet/swagger-doclet-1.1.1.jar

# swagger-tools
RUN echo "registry=${npm_repo}" | tee /root/.npmrc
RUN npm --strict-ssl=false install -g swagger-tools

VOLUME /sources
VOLUME /dependencies
VOLUME /output

ADD run.sh /run.sh
RUN chmod +x /run.sh

ENV JAVADOC_ARGS -skipUiFiles

# Remove useless stuff to reduce image size
RUN apt-get remove -y --purge build-essential gcc-5 perl perl-modules libicu55 && \
 echo 'Yes, do as I say!' | apt-get remove -y --force-yes --purge systemd && \
 apt-get autoremove -y && \
rm -rf /var/lib/apt/lists/* && \
rm -rf /var/cache/oracle-jdk8-installer && \
rm -rf /usr/lib/jvm/java-8-oracle/src.zip && \
rm -rf /usr/lib/jvm/java-8-oracle/javafx-src.zip && \
rm -rf /usr/lib/jvm/java-8-oracle/lib/missioncontrol && \
rm -rf /usr/lib/jvm/java-8-oracle/lib/visualvm

CMD /run.sh
