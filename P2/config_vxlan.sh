#!/bin/bash

# Parcours de tous les conteneurs Docker en cours d'exécution
for container_id in $(docker ps -q); do
    # Récupère le hostname du conteneur
    hostname=$(docker exec $container_id hostname)

    # Renomme le conteneur pour qu'il ait le même nom que son hostname
    docker rename $container_id $hostname

    # Vérifie si le hostname commence par "host_"
    if [[ $hostname == host_* ]]; then
        # Copie et exécute un script spécifique pour les conteneurs "host_*"
        docker cp ${hostname}.sh $hostname:/
        docker exec -it $hostname sh -c "chmod +x ${hostname}.sh && ./${hostname}.sh"
    else
        # Vérifie si le premier argument est "s" ou "d"
        if [[ $1 == "s" ]]; then
            # Copie et exécute le script pour l'option "s"
            docker cp ${hostname}_s.sh $hostname:/
            docker exec -it $hostname sh -c "chmod +x ${hostname}_s.sh && ./${hostname}_s.sh"
        elif [[ $1 == "d" ]]; then
            # Copie et exécute le script pour l'option "d"
            docker cp ${hostname}_d.sh $hostname:/
            docker exec -it $hostname sh -c "chmod +x ${hostname}_d.sh && ./${hostname}_d.sh"
        fi
    fi
done
