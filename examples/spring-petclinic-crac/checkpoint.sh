#!/usr/bin/env bash
set -e

case $(uname -m) in
    arm64)   url="https://cdn.azul.com/zulu/bin/zulu17.44.55-ca-crac-jdk17.0.8.1-linux_aarch64.tar.gz" ;;
    *)       url="https://cdn.azul.com/zulu/bin/zulu17.44.55-ca-crac-jdk17.0.8.1-linux_x64.tar.gz" ;;
esac

echo "Using CRaC enabled JDK $url"

./mvnw clean package

docker build -t spring-petclinic-crac:builder --build-arg CRAC_JDK_URL=$url .

docker run -d --privileged --rm --name=spring-petclinic-crac --ulimit nofile=1024 -p 8080:8080 -v $(pwd)/target:/opt/mnt -e FLAG=$1 spring-petclinic-crac:builder

echo "Please wait during creating the checkpoint..."
sleep 10

docker commit --change='ENTRYPOINT ["/opt/app/entrypoint.sh"]' $(docker ps -alqf "name=spring-petclinic-crac") spring-petclinic-crac:checkpoint

docker kill $(docker ps -aqlf "name=spring-petclinic-crac")
