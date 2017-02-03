M2R-ParallelQuicksort
=====================

_Information sur l'ordinateur_
Les information sur le processeur sont dans le fichier [info_processeur](info_processeur)
La version de gcc est: gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4


_Tests ordonné_
Dans un premier temps j'ai effectué des tests en respectant un ordre sur les tailles.
Les tests ont était fait pour les tailles 100, 1000, 100000, 1000000.

```sh
OUTPUT_DIRECTORY=data/`hostname`_`date +%F`
mkdir -p $OUTPUT_DIRECTORY
OUTPUT_FILE=$OUTPUT_DIRECTORY/measurements_`date +%R`.txt

touch $OUTPUT_FILE
for i in 100 1000 10000 100000 1000000; do
    for rep in `seq 1 100`; do
        echo "Size: $i" >> $OUTPUT_FILE;
        ./src/parallelQuicksort $i >> $OUTPUT_FILE;
    done ;
done
```

Pour les tests en O0 :
![alt text](https://github.com/AntoineBL/M2R-ParallelQuicksort/blob/master/data/djypzi_2017-01-19/measurements_17:42_wide_O0.png "Test_Ordo_O0")

Pour les tests en O2 :
![alt text](https://github.com/AntoineBL/M2R-ParallelQuicksort/blob/master/data/GP626QE_2017-02-02/O2.png "Test_Ordo_O2")

Pour les tests en O3 :
[alt text](https://github.com/AntoineBL/M2R-ParallelQuicksort/blob/master/data/GP626QE_2017-02-02/measurements_22:17_wide.png "Test_Ordo_O3")

Nous pouvons remarquer que les méilleurs performence sont obtenu en O2.

_Tests aléatoire_
Le but du test est de tester l’algorithme avec les tailles dans un ordre aléatoire.
J'ai fait les tests avec les valeurs : 100, 1000, 10000, 100000, 350000, 500000 et cela 10 fois pour chaque taille différente.

La fonction utilisé pour avoir de l'aléatoire est :
```R 
j=0
v=c()
set.seed(42)
w = sample(0:59,60)
for (i in w) {
  if(i<10){v[j]=100}
  else if(i<20){v[j]=1000}
  else if(i<30){v[j]=10000}
  else if(i<40){v[j]=100000}
  else if(i<50){v[j]=350000}
  else{v[j]=500000}
  j=j+1
}
sink("sample.txt")
v
```
Le fichier [sample.txt](sample.txt) contiens les différentes taille dans l’ordre pour le quelle elle vont être utilisé


Le script si dessous permet de faire les différents tests pour l'algorithme
```sh
OUTPUT_DIRECTORY=data/`hostname`_`date +%F`
mkdir -p $OUTPUT_DIRECTORY
OUTPUT_FILE=$OUTPUT_DIRECTORY/measurements_`date +%R`.txt

touch $OUTPUT_FILE

echo n=$RANDOM
tab[60]=-1
j=0
while read line  
do   
   tab[j]=$line 
   j=$((j+1))
done < sample.txt

for i in `seq 0 59`; do
        echo "Size: "${tab[$i]} >> $OUTPUT_FILE;
        ./src/parallelQuicksort ${tab[i]} >> $OUTPUT_FILE;
done
```

Test en O0:
[alt text](https://github.com/AntoineBL/M2R-ParallelQuicksort/blob/master/data/GP626QE_2017-02-03/measurements_01:06_wide.png "Test_Random_O0")

Test en O3:
[alt text](https://github.com/AntoineBL/M2R-ParallelQuicksort/blob/master/data/GP626QE_2017-02-03/measurements_00:56_wide.png "Test_Random_O3")

Les valeurs pour la parallélisation sont trop dispersées. Mais nous pouvons voir quelle reste globalement moins efficace que les autres méthodes pour ces tailles de tableaux.