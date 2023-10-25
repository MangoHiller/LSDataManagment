#!/bin/bash

# Vérification du paramètre
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path-to-cluster-creation-script>"
    exit 1
fi

# Chemin du script de création du cluster
CLUSTER_CREATION_SCRIPT=$1

# Nom du cluster (peut être extrait du script de création du cluster ou défini manuellement)
CLUSTER_NAME="cluster-a35a"

# Chemins
DATA_PATH="gs://public_lddm_data/page_links_en.nt.bz2"
PYSPARK_SCRIPT_PATH="pagerank.py"  # Assurez-vous que ce script est disponible localement
OUT_DIR="gs://mybigbucket2024/out/pagerank_data_spark"

# Copie des données et du script PySpark vers le bucket GCS
gsutil cp $PYSPARK_SCRIPT_PATH gs://mybigbucket2024/
gsutil cp $DATA_PATH gs://mybigbucket2024/

# Suppression du répertoire de sortie si existant
gsutil rm -rf $OUT_DIR

# Création du cluster
bash $CLUSTER_CREATION_SCRIPT

# Exécution du script PySpark
gcloud dataproc jobs submit pyspark \
--region europe-central2 \
--cluster $CLUSTER_NAME \
gs://mybigbucket2024/$PYSPARK_SCRIPT_PATH -- gs://mybigbucket2024/page_links_en.nt.bz2 3 

# Accès aux résultats
# Le nom de fichier part-r-00000 peut varier, vérifiez le nom correct dans votre bucket GCS
gsutil cat $OUT_DIR/pagerank_data_1/part-r-00000 | head -n 5

# Suppression du cluster
gcloud dataproc clusters delete $CLUSTER_NAME --region europe-central2
