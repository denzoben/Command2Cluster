#!/bin/bash

usage="usage: $(basename "$0") -h <hostfilename> -p [Port] -c <command>\n\n"
port=22

if [ "$*" == "" ]; then
	printf "\n\n"
	echo "$usage"
	printf "\n\n"
	exit 1
fi

while test $# -gt 0;do
	case "$1" in
	-h)	shift
		file=$1
		echo $file
		shift
		;;
	-p)	shift
		port=$1
		shift
		;;
	-c)	shift
		command=$1
		shift
		;;
	-*)	printf "illegal option: -%s\n" >&2
	        echo "$usage" >&2
	        exit 1
	        ;;
	esac
	done

tmpdir=/tmp/ssh.$$
mkdir -p $tmpdir
count=0

#Run command in each remote host server parallelly
while IFS= read -r iplist;do
	ssh -n -o BatchMode=yes ${iplist} -p $port $command > ${tmpdir}/${iplist} 2>&1  &
	count=`expr $count + 1`
	echo "done"
	done<"$file"

#wait for every process to end
while [ "$count" -gt 0 ];do
	wait $pids
	count=`expr $count - 1`
	done

echo "Result is stored in $tmpdir"
