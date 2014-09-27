while read course
do
    ./res.sh 001 070 $course
    sort -k5,5 -rn ./results/$course | grep [A-Z] - >temp; cat temp >./results/$course
done <courses

rm temp