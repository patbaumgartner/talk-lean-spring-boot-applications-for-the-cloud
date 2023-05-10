# CraC Setup

See: https://foojay.io/today/how-to-run-a-java-application-with-crac-in-a-docker-container/

## How to build a docker image

1. Build the project with Maven:

    ```bash
    mvn clean verify
    ```

2. Build the docker image:

    ```bash
    docker build -t spring-petclinic-crac .
    ```


## Start your application in a docker container

1. Run your docker container with:

    ```bash
    docker run -it --privileged --rm --name spring-petclinic-crac spring-petclinic-crac
    ```

2. In the docker container run:

    ```bash
    cd /opt/app && java -XX:CRaCCheckpointTo=/opt/crac-files -jar my-app.jar
    ```

## Create the checkpoint

1. Open another shell window. In this window run the following command to create the checkpoint:

    ```bash
    docker exec -it -u root spring-petclinic-crac /bin/bash -c "jcmd my-app.jar JDK.checkpoint && exit"
    ```

2. Commit the following image:

    ```bash
    docker commit spring-petclinic-crac spring-petclinic-crac:checkpoint
    ```


## Run the docker container from the checkpoint

1. Run:
    ```bash
    docker run -it --privileged --rm --name my_app_on_crac my_app_on_crac:checkpoint java -XX:CRaCRestoreFrom=/opt/crac-files
    ```

2. Your application should now start much faster from the saved checkpoint.
