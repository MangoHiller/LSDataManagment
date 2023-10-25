#!/bin/bash

#création de Cluster avec 5 nœuds (1 nœud maître + 4 nœuds travailleurs) : dans google cloud

gcloud dataproc clusters create cluster-a35a --enable-component-gateway \
--region europe-west4 --zone europe-west4-c \
--master-machine-type n1-standard-4 --master-boot-disk-size 500 \
--num-workers 4 --worker-machine-type n1-standard-4 --worker-boot-disk-size 500 \
--image-version 2.0-debian10 --project projetbigdata2024
