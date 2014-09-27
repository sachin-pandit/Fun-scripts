chmod +x dnld.sh
chmod +x extract.sh
chmod +x gpa.o
./dnld.sh $1 $2 $3 2>/dev/null
./extract.sh usn 2>/dev/null >./results/$3