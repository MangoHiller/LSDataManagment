#!/bin/bash

# Nom du cluster à supprimer
cluster="cluster-a35a"

echo "Suppression du cluster $cluster..."
gcloud dataproc clusters delete $cluster --region=europe-west10 --quiet

echo "Suppression du cluster $cluster terminée."
