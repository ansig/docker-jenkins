#!/usr/bin/env bash

JENKINS_CONTAINER="$(docker ps -f "name=jenkins-master" -q)"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker cp "${DIR}/config-include.txt" ${JENKINS_CONTAINER}:/tmp/config-include.txt
docker exec ${JENKINS_CONTAINER} bash -c "tar -czvf /tmp/jenkins-config.tar.gz -C /var/jenkins_home -T /tmp/config-include.txt"
docker cp ${JENKINS_CONTAINER}:/tmp/jenkins-config.tar.gz jenkins-master/config/default-config.tar.gz
