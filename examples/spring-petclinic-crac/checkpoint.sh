#!/usr/bin/env bash
set -e

./mvnw clean package
docker build -t patbaumgartner/spring-petclinic-crac:builder .
docker run -d --privileged --rm --name=spring-petclinic-crac --ulimit nofile=1024 -p 8080:8080 -v $(pwd)/target:/opt/mnt patbaumgartner/spring-petclinic-crac:builder
echo "Please wait during creating the checkpoint..."
sleep 10
docker commit --change='ENTRYPOINT ["/opt/app/entrypoint-restore.sh"]' $(docker ps -aqf "name=spring-petclinic-crac") patbaumgartner/spring-petclinic-crac:checkpoint
docker kill $(docker ps -aqf "name=spring-petclinic-crac")
