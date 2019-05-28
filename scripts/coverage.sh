## coverage analysis
##clipping_profile.py -h

sam_dirs=~/Documents/FernandaRNA/SAM_STAR_files/*.sam

for file in $sam_dirs; do
       samp_name=$(echo $file | sed "s/.*\///g")
       echo RUNNING:clipping_profile.py -i ~/Documents/FernandaRNA/SAM_STAR_files/$samp_name -o data/clip/$samp_name
       clipping_profile.py -i ~/Documents/FernandaRNA/SAM_STAR_files/$samp_name -s "PE"  -o data/clip/$samp_name
done
