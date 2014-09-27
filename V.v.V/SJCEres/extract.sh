
while read line
do
    sed -n '/Holder1_lblNAme/,/Holder1_grades/p' $line | grep -e "lblNAme" -e "lblUSN" -e "lblTitle" >/tmp/t1
    name=`sed -n 's/.*VERDANA">\(.*\)<\/font.*/\1/p' /tmp/t1`
    grades=`sed -n '5~3p' /tmp/t1 | sed -n 's/.*>\(.\)<.*/\1/p' | tr '\n' ' ' | sed 's/ //g'`

    echo
    echo -n "| "$grades
    ./gpa.o $line $grades 2>/dev/null
    echo -n "| "$name" |"
done <$1

echo

rm 4JC*