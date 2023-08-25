#!/bin/bash

echo 128 > /proc/sys/kernel/ns_last_pid; java -XX:CRaCCheckpointTo=/opt/crac-files -jar /opt/app/spring-petclinic-crac-3.2.0-SNAPSHOT.jar&
sleep 5
jcmd /opt/app/spring-petclinic-crac-3.2.0-SNAPSHOT.jar JDK.checkpoint
sleep infinity
