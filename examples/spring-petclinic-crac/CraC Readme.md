# CraC Setup

## How to install

1. Download OpenJDK build from https://github.com/CRaC/openjdk-builds/releases:

    ```bash
    wget https://github.com/CRaC/openjdk-builds/releases/download/17-crac%2B5/openjdk-17-crac+5_linux-x64.tar.gz
    ```

1. Unpack the archive with sudo (without sudo it's not going to work):

    ```bash
    sudo tar zxf openjdk-17-crac+5_linux-x64.tar.gz
    ```

1. Set `JAVA_HOME` to point to the OpenJDK CRaC directory. Assuming that the JDK is located in /opt/:

   ```bash
    sudo mv openjdk-17-crac+5_linux-x64 /opt/
    export JAVA_HOME=/opt/openjdk-17-crac+5_linux-x64/
    ```

1. Include the bin directory in PATH. Important: make sure that it's added before the current path:

   ```bash
    export PATH=$JAVA_HOME/bin:$PATH
    ```

## How to run

1. Make sure you have your Spring Boot project built with Maven:

    ```bash
    mvn clean verify
    ```

2. Run JAR with flag `-XX:CRaCCheckpointTo=crac-files`:

    ```bash
    java -XX:CRaCCheckpointTo=crac-files -jar target/spring-petclinic-crac-3.1.0-SNAPSHOT.jar
    ```

3. Open a new terminal window, go to the spring-boot example and execute:

   ```bash
    siege -c 1 -r 10000 -b http://localhost:8080

    jcmd target/spring-petclinic-crac-3.1.0-SNAPSHOT.jar JDK.checkpoint
   ```

4. You should see the application killed and that `crac-files` directory has been created.

5. Now switch back to the terminal where the spring-boot example was running, and restart a project again, this time restoring from the checkpoint:

   ```bash
   java -XX:CRaCRestoreFrom=crac-files
   ```

The application should now start in milliseconds!
