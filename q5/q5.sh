#!/usr/bin/bash

sed '/^[[:space:]]*$/d' $1 > input1.txt 
sed 's/[[:blank:]]*$//' input1.txt > input2.txt
sed -e 's/^[ \t]*//' input2.txt > input.txt
name=""
hobby=""
drive=""

touch csv
echo "Name||Projects||Drive Video Link" > csv
count=0
a=0
b=0
filename='input.txt'
while read line; do
	echo $line > out.txt
	v=$(grep "https://drive" out.txt | wc -l)
	if [ $v -gt 0 ]; then
		let count=2
	fi
	if [ $count -eq 0 ]; then
		name=$(cat out.txt)
		let count=1
		a=$(grep -n "$line" input.txt | grep -o "[0-9][0-9]*"| head -1)
	fi
	if [ $count -eq 2 ]; then
		drive="$line"
		b=$(grep -n "$line" input.txt | grep -o "[0-9][0-9]*:"| grep -o "[0-9][0-9]*")
		sed -n "$((a+1)),$((b-1)) p" input.txt > hobbies.txt
		perl -p -e 's/\n/ /' hobbies.txt > hobbies1.txt
		
		sed 's/[[:blank:]]*$//' hobbies1.txt > hobbies2.txt
		hobby=$(cat hobbies2.txt)
		rm hobbies.txt
		rm hobbies1.txt
		rm hobbies2.txt
		let a=0
		let b=0
		let count=0
		echo "$name||$hobby||$drive" >> csv
	fi
done < $filename

rm input.txt
rm input1.txt
rm input2.txt
rm out.txt
