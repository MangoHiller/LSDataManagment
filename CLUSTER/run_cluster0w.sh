#!/bin/bash

#création de Cluster avec 1 nœud (juste le nœud maître) : dans google cloud

gcloud dataproc clusters create cluster-a35a --enable-component-gateway \
--region europe-central2 --zone europe-central2-c \
--master-machine-type n1-standard-4 --master-boot-disk-size 500 \
--num-workers 0 \
--image-version 2.0-debian10 --project projetbigdata2024