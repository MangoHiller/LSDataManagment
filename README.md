# Projet Large Scale Data Management

Ce projet a pour objectif de comparer les performances de l'algorithme PageRank implémenté avec Apache Pig et PySpark sur différentes configurations de clusters. Les configurations varient selon le nombre de nœuds (master et workers) dans le cluster. Les données utilisées sont stockées dans le bucket Google Cloud Storage `gs://public_lddm_data/page_links_en.nt.bz2`.

## Configuration des Clusters

Les clusters sont configurés avec un nœud master et un nombre variable de nœuds workers. Les configurations testées sont :

- 1 nœud master et 0 workers
- 1 nœud master et 2 workers
- 1 nœud master et 3 workers
- 1 nœud master et 4 workers
- 1 nœud master et 5 workers

## Résultats

Les temps d'exécution de l'algorithme PageRank pour chaque configuration sont résumés dans le tableau ci-dessous :

| Configuration       | Temps d'Exécution Pig | Temps d'Exécution PySpark |
|---------------------|-----------------------|---------------------------|
| 1 master, 0 workers | 1 h 43 min            | (Non testé)               |
| 1 master, 2 workers | 51 min 43 s           | 41 min 2 s                |
| 1 master, 3 workers | 41 min 43 s           | 38 min 9 s                |
| 1 master, 4 workers | (Non testé)           | 35 min 46 s               |
| 1 master, 5 workers | 36 min 31 s           | 34 min                    |

## Top 5 PageRank

Les 5 URL avec le plus grand PageRank calculé par chaque implémentation sont listées ci-dessous :

### PySpark

1. [Living People](http://dbpedia.org/resource/Living_people) : 36794.33
2. [United States](http://dbpedia.org/resource/United_States) : 13201.34
3. [Race and ethnicity in the United States Census](http://dbpedia.org/resource/Race_and_ethnicity_in_the_United_States_Census) : 10371.16
4. [List of sovereign states](http://dbpedia.org/resource/List_of_sovereign_states) : 5195.35
5. [United Kingdom](http://dbpedia.org/resource/United_Kingdom) : 4923.82

### Apache Pig

1. [Living People](http://dbpedia.org/resource/Living_people) : 33320.51
2. [United States](http://dbpedia.org/resource/United_States) : 15212.14
3. [Race and ethnicity in the United States Census](http://dbpedia.org/resource/Race_and_ethnicity_in_the_United_States_Census) : 11309.12
4. [United Kingdom](http://dbpedia.org/resource/United_Kingdom) : 5373.22
5. [France](http://dbpedia.org/resource/France) : 5044.95

## Conclusion

Les résultats montrent une légère amélioration des temps d'exécution avec PySpark comparé à Apache Pig. Le classement des URL par PageRank est relativement similaire entre les deux implémentations, ce qui indique une cohérence dans les calculs effectués par les deux frameworks.

## Code Source

Le code source pour ce projet est disponible sur [GitHub](https://github.com/momo54/large_scale_data_management).

## Données

Les données sont stockées dans le bucket Google Cloud Storage suivant : `gs://public_lddm_data/page_links_en.nt.bz2`.

## Exécution du Code

Pour exécuter le code sur votre cluster, suivez les étapes ci-dessous :

1. Clonez le dépôt GitHub à l'adresse [https://github.com/MangoHiller/LSDataManagment](https://github.com/MangoHiller/LSDataManagment).
2. Naviguez vers le répertoire `LSDataManagment/SCRIPTS/` pour accéder aux scripts Pig et PySpark.
3. Exécutez le script run.sh en spécifiant le chemin vers le script de création du cluster comme argument :
   ```bash
   ./run.sh ~/LSDataManagment/CLUSTER/run_cluster0w.sh
4. Exécutez le script run.sh topPageRank[...].sh en fonction du type de framework utilisé.
    ```bash
    ./run.sh 
## Description des Dossiers et Fichiers

- `LSDataManagment/CLUSTER/` : Contient les scripts pour créer et supprimer les clusters.
- `LSDataManagment/PIG/` : Contient le code Pig pour l'implémentation de l'algorithme PageRank.
- `LSDataManagment/PYSPARK/` : Contient le code PySpark pour l'implémentation de l'algorithme PageRank.


# Contributors

| -------------------------------------------------- | ---------------- |
| [@MangoHiller](https://github.com/MangoHiller)     | Hugo LEGUILLIER  |
| [@miranovic](https://github.com/miranovic)         | Imran NAAR       |
