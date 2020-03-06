#!/bin/bash

title="SSH Report"
file="report.html"
if test -f "$file";then
	rm "$file"
fi

store=($(ls -d /tmp/ssh.*))
len="${#store[@]}"
filename="192.168.4.40"

echo "<!DOCTYPE html>
	<html style='background-size: 100% 100%;'>
		<head>
			<title>$title</title>
			<link rel="stylesheet" type="text/css"  href="report.css">
		</head>
		<body>
" >> report.html
		for ((i=0; i<$len; i++ ))
		do
			dir="${store[i]}/$filename"
			echo "		<div class='box'>
					<h4>'Reply For Server `expr $i + 1`'</h4>
					$(cat $dir)
					</div>" >> report.html
		done
echo "		</body>
	</html>
" >> report.html
