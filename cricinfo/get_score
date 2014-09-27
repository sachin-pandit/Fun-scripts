while [ 1 ]
do
	clear
	curl "http://www.espncricinfo.com/india-v-west-indies-2011/engine/current/match/536932.html" >score 2>/dev/null
	sed -n "s/.*<title>\(.*\)<\/title>.*/\1/p" score | cut -d"|" -f1
	sleep 5
done
