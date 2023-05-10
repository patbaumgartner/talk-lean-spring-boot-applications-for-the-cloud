FROM ubuntu:22.04

ENV JAVA_HOME /opt/jdk
ENV PATH $JAVA_HOME/bin:$PATH

RUN apt-get update -y && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

ADD "https://github.com/CRaC/openjdk-builds/releases/download/17-crac%2B5/openjdk-17-crac+5_linux-x64.tar.gz" $JAVA_HOME/openjdk.tar.gz

RUN tar --extract --file $JAVA_HOME/openjdk.tar.gz --directory "$JAVA_HOME" --strip-components 1; rm $JAVA_HOME/openjdk.tar.gz;

RUN chmod a+rwx /opt/ && mkdir -p /opt/crac-files

COPY target/spring-petclinic-crac-*.jar /opt/app/my-app.jar
