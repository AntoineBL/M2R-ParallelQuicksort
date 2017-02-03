
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
   #echo $tab[j]
   j=$((j+1))
done < sample.txt


for i in `seq 0 59`; do
        echo "Size: "${tab[$i]} >> $OUTPUT_FILE;
        ./src/parallelQuicksort ${tab[i]} >> $OUTPUT_FILE;
done
