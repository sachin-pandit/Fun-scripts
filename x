while [ $# != 0 ]
do
	echo "______"
	ls -l $1 | cut -d" " -f1,8
	chmod u+x $1
	ls -l $1 | cut -d" " -f1,8
	shift
done

