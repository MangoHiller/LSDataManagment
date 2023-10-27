#!/bin/bash

# Vérification du nombre de paramètres
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <path-to-cluster-creation-script> <pyspark-script-name>"
    exit 1
fi

# Chemin du script de création du cluster et nom du script PySpark
CLUSTER_CREATION_SCRIPT=$1
PYSPARK_SCRIPT_NAME=$2  # Nouveau paramètre pour le nom du script PySpark

# Nom du cluster (peut être extrait du script de création du cluster ou défini manuellement)
CLUSTER_NAME="cluster-a35a"

# Chemins
DATA_PATH="gs://public_lddm_data/page_links_en.nt.bz2"
PYSPARK_SCRIPT_PATH="~/LSDataManagment/SPARK/$PYSPARK_SCRIPT_NAME"  # Utilisation du paramètre PYSPARK_SCRIPT_NAME

# Définition du répertoire OUT_DIR en fonction du script PySpark
if [[ "$PYSPARK_SCRIPT_NAME" == "pagerankPartitioned.py" ]]; then
    OUT_DIR="gs://mybigbucket2024/out/pagerank_data_spark_partitioned"
else
    OUT_DIR="gs://mybigbucket2024/out/pagerank_data_spark"
fi

# Copie des données et du script PySpark vers le bucket GCS
gsutil cp $PYSPARK_SCRIPT_NAME gs://mybigbucket2024/  # Utilisation du paramètre PYSPARK_SCRIPT_NAME
gsutil cp $DATA_PATH gs://mybigbucket2024/

# Suppression du répertoire de sortie si existant
gsutil rm -rf $OUT_DIR

# Création du cluster
bash $CLUSTER_CREATION_SCRIPT

# Exécution du script PySpark
gcloud dataproc jobs submit pyspark \
--region europe-central2 \
--cluster $CLUSTER_NAME \
$PYSPARK_SCRIPT_PATH -- gs://mybigbucket2024/page_links_en.nt.bz2 3 

# Accès aux résultats
# Le nom de fichier part-r-00000 peut varier, vérifiez le nom correct dans votre bucket GCS
gsutil cat $OUT_DIR/part-00000 | head -n 5

# Suppression du cluster
bash ~/LSDataManagment/CLUSTER/delete_Cluster.sh
