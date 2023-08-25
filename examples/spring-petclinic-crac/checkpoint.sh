#!/usr/bin/env bash
set -e

./mvnw clean verify

docker build -t spring-petclinic-crac:builder .

docker run -d --privileged --rm --name=spring-petclinic-crac --ulimit nofile=1024 -p 8080:8080 -v $(pwd)/target:/opt/mnt spring-petclinic-crac:builder

echo "Please wait during creating the checkpoint..."
sleep 10

docker commit --change='ENTRYPOINT ["/opt/app/entrypoint-restore.sh"]' $(docker ps -alqf "name=spring-petclinic-crac") spring-petclinic-crac:checkpoint

docker kill $(docker ps -aqlf "name=spring-petclinic-crac")
