#!/bin/bash

# Nom du cluster
CLUSTER_NAME="cluster-a35a"

# Chemins
DATA_PATH="gs://public_lddm_data/page_links_en.nt.bz2"
PIG_SCRIPT_PATH="dataproc.py"  # Assurez-vous que ce script est disponible localement
OUT_DIR="gs://mybigbucket2024/out"

# Création du cluster
bash ~/LSDataManagment/CLUSTER/run_cluster0w.sh

# Copie du script Pig vers le bucket GCS
gsutil cp $PIG_SCRIPT_PATH gs://mybigbucket2024/

## copy data to bucket
#gsutil cp $DATA_PATH gs://mybigbucket2024/

# Suppression du répertoire de sortie si existant
gsutil rm -rf $OUT_DIR

# Exécution du script Pig
gcloud dataproc jobs submit pig \
--region europe-west1-c \
--cluster $CLUSTER_NAME \
-f gs://mybigbucket2024/$PIG_SCRIPT_PATH

# Accès aux résultats
# Le nom de fichier part-r-00000 peut varier, vérifiez le nom correct dans votre bucket GCS
#gsutil cat $OUT_DIR/pagerank_data_1/part-r-00000

#lire les 5 premières lignes
gsutil cat $OUT_DIR/pagerank_data_1/part-r-00000 | head -n 5

# Suppression du cluster
bash delete_cluster.sh
