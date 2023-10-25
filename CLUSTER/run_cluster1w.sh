#!/bin/bash

#création de Cluster avec 2 nœuds (1 nœud maître + 1 nœud travailleur) : dans google cloud

gcloud dataproc clusters create cluster-a35a --enable-component-gateway \
--region europe-west1 --zone europe-west1-b \
--master-machine-type n1-standard-4 --master-boot-disk-size 500 \
--num-workers 1 --worker-machine-type n1-standard-4 --worker-boot-disk-size 500 \
--image-version 2.0-debian10 --project projetbigdata2024
