if [ $# -eq 0 ]
then
    mplayer ~/p/voice/hello.mpga >/dev/null 2>/dev/null
else
    while [ $# -ne 0 ]
    do
	if [ "$1" = "hello" -o "$1" = "Hello" ]
	then
	    mplayer ~/p/voice/hello.mpga >/dev/null 2>/dev/null
	elif [ "$1" = "task+completed" -o "$1" = "task+comp" -o "$1" = "tc" ]
	then
	    mplayer ~/p/voice/task_completed.mpga >/dev/null 2>/dev/null
	elif [ "$1" = "your+task+is+done" -o "$1" = "ytid" -o "$1" = "task+done" ]
	then
	    mplayer ~/p/voice/ytid.mpga >/dev/null 2>/dev/null
	elif [ "$1" = "syntax+error" -o "$1" = "syn+err" ]
	then
	    mplayer ~/p/voice/syntax_err.mpga >/dev/null 2>/dev/null
	else
	    echo "not found"
	    echo "Found:"
	    echo "\"task+completed\", \"task+comp\", \"tc\""
	    echo "\"your+task+is+done\", \"ytid\", \"task+done\""
	    echo "\"syntax+error\", \"syn+err\""
	fi
	
	shift
    done
fi
