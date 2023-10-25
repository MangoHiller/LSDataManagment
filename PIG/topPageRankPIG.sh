#!/bin/bash

# Définir le répertoire de sortie
OUT_DIR="gs://mybigbucket2024/out/pagerank_data_3"

# Créer un fichier temporaire
TMP_FILE=$(mktemp)

# Boucle sur chaque fichier part-* et stocke les 5 premiers éléments dans le fichier temporaire
for i in $(seq -w 00 13); do
    gsutil cat $OUT_DIR/part-000$i | sort -k2,2 -g -r | head -n 5 >> $TMP_FILE
done

# Trie le fichier temporaire et affiche les 5 URL ayant le plus grand PageRank
sort -k2,2 -g -r $TMP_FILE | head -n 5

# Supprime le fichier temporaire
rm $TMP_FILE
