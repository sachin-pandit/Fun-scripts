
i=0

while [ $i -lt 25 ]
do
	curl "http://www.mbaskool.com/plugins/content/yj_bumpit.php?yj_vote=921&amp;yj_time=1322372177"
	curl "http://www.mbaskool.com/plugins/content/yj_bumpit.php?yj_vote=1033&amp;yj_time=1322371627"
	curl "http://www.mbaskool.com/plugins/content/yj_bumpit.php?yj_vote=1033&amp;yj_time=1322372207"
	curl "http://www.mbaskool.com/plugins/content/yj_bumpit.php?yj_vote=922&amp;yj_time=1322372437"
	echo -e "Count = $i\n" 	
	i=`expr $i + 1`
done
