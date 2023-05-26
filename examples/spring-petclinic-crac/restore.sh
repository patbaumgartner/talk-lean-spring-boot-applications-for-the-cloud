#!/usr/bin/env bash
set -e

docker run --rm -p 8080:8080 --name spring-petclinic-crac patbaumgartner/spring-petclinic-crac:checkpoint
