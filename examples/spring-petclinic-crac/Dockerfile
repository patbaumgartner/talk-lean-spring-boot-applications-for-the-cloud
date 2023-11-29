FROM ubuntu:22.04

ENV JAVA_HOME /opt/jdk
ENV PATH $JAVA_HOME/bin:$PATH

ADD "https://cdn.azul.com/zulu/bin/zulu17.46.27_1-ca-crac-jdk17.0.9-linux_x64.tar.gz" $JAVA_HOME/openjdk.tar.gz
RUN tar --extract --file $JAVA_HOME/openjdk.tar.gz --directory "$JAVA_HOME" --strip-components 1; rm $JAVA_HOME/openjdk.tar.gz;

RUN mkdir -p /opt/app
COPY target/spring-petclinic-crac-3.2.0-SNAPSHOT.jar /opt/app/spring-petclinic-crac-3.2.0-SNAPSHOT.jar

COPY src/scripts/entrypoint.sh /opt/app/entrypoint.sh

RUN mkdir -p /opt/crac-files

ENTRYPOINT /opt/app/entrypoint.sh
