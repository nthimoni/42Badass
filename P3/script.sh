#!/bin/bash
for container_id in $(docker ps -q); do
    hostname=$(docker exec $container_id hostname)
    docker rename $container_id $hostname
    docker cp $hostname.sh $hostname:/
    docker exec -it $hostname sh -c "chmod +x $hostname.sh && ./$hostname.sh"
done
