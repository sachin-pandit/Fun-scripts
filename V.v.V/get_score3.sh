#!/bin/bash

#primitive version of get_score.sh
#
#(turn your sound system on)
#script to view cricket score live (with reasonable delay, of course)
#runs properly only on supplying link to the "espn cricinfo" livescore pages
#

if [ $# -eq 1 ]
then
	link=$1
else
	link="http://www.espncricinfo.com/south-africa-domestic-2011/engine/match/529787.html"
fi

refresh=5 #refresh rate 5 second

old_score="" #before refresh (contains the batsman and bowler details, overs, total, wickets.. )
new_score="" #after refresh ( " )

board="" #string to store score as in a board

old_wickets=0 #before refresh
new_wickets=0 #after refresh

overs=""

#players
striker="" 
non_striker=""
bowler=""

#to ensure that atleast 1 iteration has been performed since the start of the script.
#i.e, the script prefers special announcements to be done only after atleast one entry
#the related section
#else, the script acts as though surprised at the sudden change(initial) in its variables
seen_w=0 #seen wicket count
seen_s=0 #seen score

old_total=0 #before refresh (contains only the total score numerical value)
new_total=0 #after refresh ( " )

#use google transliteration software to simulate the following sounds
wget -q -U Mozilla -O /tmp/gs_six.mp3 "http://translate.google.com/translate_tts?q=six" #SIX
wget -q -U Mozilla -O /tmp/gs_four.mp3 "http://translate.google.com/translate_tts?q=four" #FOUR
wget -q -U Mozilla -O /tmp/gs_out.mp3 "http://translate.google.com/translate_tts?q=out" #OUT
#all files saved in /tmp folder

while [ 1 ]
do
    #update board after every refresh
    board=""

    #get score html page from cric info
    curl $link >/tmp/gs_score 2>/dev/null

    #extract the "title" field from the html page downloaded
    new_score=`sed -n "s/.*<title>\(.*\)<\/title>.*/\1/p" /tmp/gs_score | cut -d"|" -f1`

    #update display only if there is a change in the scoreboard
    if [ "$new_score" != "$old_score" ]
    then
	clear
	
	#some string operations
	board=`echo $new_score | cut -d"(" -f1`  #total

	part=`echo $new_score | cut -d"(" -f2 | cut -d")" -f1`
	part=`echo $part | sed 's/, /|/g'`  #remainder board
	
	old_ov=$overs
	overs=`echo $part | cut -d"|" -f1`
	
	old_str=$striker
	striker=`echo $part | cut -d"|" -f2 | cut -d"*" -f1`
	
	old_non_str=$non_striker
	non_striker=`echo $part | cut -d"|" -f3 | cut -d"*" -f1`
	
	valid=`echo $non_striker | grep -c "/"`
	if [ $valid -eq 0 ]
	then
	    bowler=`echo $part | cut -d"|" -f4`
	else
	    bowler=$non_striker
	    non_striker=""
	fi
	
	#board="$board\n`echo $part | sed 's/, /\\\n/g'`"
	board="$board\n$overs\n$striker\n$non_striker\n$bowler"
	board="$board\n`echo $new_score | cut -d")" -f2`"
	echo -e $board
	#wget -q -U Mozilla -O /tmp/gs_scorer.mp3 "http://translate.google.com/translate_tts?q=$striker+on+strike"
	#mplayer /tmp/gs_scorer.mp3 1>/dev/null

	#update old_score and new_total
	old_score="$new_score"
	new_total=`echo $new_score | cut -d"/" -f1 | cut -d " " -f2`
    fi
    
    #find the difference bw old and new total
    diff=`expr $new_total - $old_total`

    if [ $seen_s -ne 0 ] #if the change occured in score is not for the first time
    then
	if [ $diff -ge 6 ]
	then
	    mplayer /tmp/gs_six.mp3
	    wget -q -U Mozilla -O /tmp/gs_scorer.mp3 "http://translate.google.com/translate_tts?q=$striker"
	    mplayer /tmp/gs_scorer.mp3
	elif [ $diff -ge 4 ]
	then
	    mplayer /tmp/gs_four.mp3
	    wget -q -U Mozilla -O /tmp/gs_scorer.mp3 "http://translate.google.com/translate_tts?q=$striker"
	    mplayer /tmp/gs_scorer.mp3
	fi 2>/dev/null 1>/dev/null
    fi 2>/dev/null 1>/dev/null
    
    #update old_total and set seen_s to TRUE (seen score atleast once)
    old_total=$new_total
    seen_s=1
    
    #extract the 'wickets' field
    new_wickets=`echo $new_score | cut -d"/" -f2 | cut -d" " -f1`

    if [ $old_wickets -ne $new_wickets ] #if there is a change in number of fallen wickets
    then
	if [ $seen_w -ne 0 ]
	then
	    mplayer /tmp/gs_out.mp3 #speak out "out"

	    if [ $striker == $old_str ]
	    then
		wget -q -U Mozilla -O /tmp/gs_gone.mp3 "http://translate.google.com/translate_tts?q=$old_non_str"	  
	    else
		wget -q -U Mozilla -O /tmp/gs_gone.mp3 "http://translate.google.com/translate_tts?q=$old_str"
	    fi
	    mplayer /tmp/gs_gone.mp3

	fi 2>/dev/null 1>/dev/null

	#seen wicket falling, atleast once
	seen_w=1

	#update old_wickets
	old_wickets=$new_wickets

    fi 2>/dev/null 1>/dev/null

    sleep $refresh
done 2>/dev/null
