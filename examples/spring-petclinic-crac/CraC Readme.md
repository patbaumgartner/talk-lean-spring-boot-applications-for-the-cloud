# CraC Setup

## How to install

1. Download OpenJDK build from https://github.com/CRaC/openjdk-builds/releases:

    ```bash
    wget https://github.com/CRaC/openjdk-builds/releases/download/17-crac%2B3/openjdk-17-crac+3_linux-x64.tar.gz
    ```

1. Unpack the archive with sudo (without sudo it's not going to work):

    ```bash
    sudo tar zxf openjdk-17-crac+3_linux-x64.tar.gz
    ```

1. Set `JAVA_HOME` to point to the OpenJDK CRaC directory. Assuming that the JDK is located in /opt/:

   ```bash
    export JAVA_HOME=/opt/openjdk-17-crac+3_linux-x64/
    ```

1. Include bin directory in PATH. Important: make sure that it's added before current path:

   ```bash
    export PATH=$JAVA_HOME/bin:$PATH
    ```

## How to run

1. Make sur you have your Spring Boot project built with Maven:

    ```bash
    mvn clean verify
    ```

2. Run JAR with flag `-XX:CRaCCheckpointTo=crac-files`:

    ```bash
    java -XX:CRaCCheckpointTo=crac-files -jar target/spring-petclinic-crac-2.7.6.jar
    ```

3. Open new terminal window, go to the spring-boot example and execute:

   ```bash
    jcmd target/spring-petclinic-crac-2.7.6.jar JDK.checkpoint
   ```

4. You should see the application killeed and that `crac-files` directory has been created.

5. Now switch back to terminal where the spring-boot example was running, and restart a project again, this time restoring from the checkpoint:

   ```bash
   java -XX:CRaCRestoreFrom=crac-files
   ```

The application should now start in milliseconds!
