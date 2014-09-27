while [ $# -ne 0 ]
do
    clear
    echo \#\#$1\#\#
    cat $1
    read c
    shift
done
