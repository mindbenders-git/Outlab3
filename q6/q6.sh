#!/usr/bin/bash

tail -n +2 $1 | sort -k1 1>>input.csv

labstart=$(date +%s -d $2)
labend=$(date +%s -d $3)


awk -F '\t' '{print $1}' input.csv > names.txt

prevname=$(awk -F '\t' 'NR==1 {print $1}' input.csv)

filename='input.csv'
awk -F '\t' '{print $3}' input.csv | sed 's/[0-9/]*,[[:blank:]]//' >> time.txt
awk "NR==1" time.txt >> time1.txt

echo -e "bgfb\tbbgbf\tbgngg" >> input.csv

count=0
index=2
len=1
while read line; do
	if [ $count -eq 0 ];then
		let count=1
		continue
	fi
	name=$(awk "NR==$index" names.txt)
	
	if [ "$name" = "$prevname" ]; then
		awk "NR==$index" time.txt >> time1.txt
		len=$((len+1))
	else
		cp time1.txt time2.txt
		sort time2.txt > time1.txt
		if [ $((len%2)) -eq 0 ]; then
			time=0
			counter=0
			start=0
			for line1 in $(cat time1.txt)
			do
				if [ $((counter%2)) -eq 0 ];then
					start=$(date +%s -d ${line1})
					let counter++
					continue
				else
					let counter++
					end=$(date +%s -d ${line1})
					DIFFSEC=0
					if [ $start -lt $labstart ];then
						if [ $end -gt $labend ];then
							DIFFSEC=$(expr $labend - $labstart)
						else
							DIFFSEC=$(expr $end - $labstart)
						fi
					else
						if [ $end -gt $labend ];then
							DIFFSEC=$(expr $labend - $start)
						else
							DIFFSEC=$(expr $end - $start)
						fi
					fi
					time=$((time+DIFFSEC))
				fi
			done
			a=$(date +%H:%M:%S -ud @${time})
			echo -e "${prevname}\t${a}" >> out01
			prevname=$name
		else
			counter=0
			time=0
			start=0
			for line1 in $(cat time1.txt)
			do
				if [ $((counter%2)) -eq 0 ];then
					start=$(date +%s -d ${line1})
					let counter++
					continue
				else
					let counter++;
					end=$(date +%s -d ${line1})
					DIFFSEC=0
					if [ $start -lt $labstart ];then
						if [ $end -gt $labend ];then
							DIFFSEC=$(expr $labend - $labstart)
						else
							DIFFSEC=$(expr $end - $labstart)
						fi
					else
						if [ $end -gt $labend ];then
							DIFFSEC=$(expr $labend - $start)
						else
							DIFFSEC=$(expr $end - $start)
						fi
					fi
					time=$((time+DIFFSEC))
				fi
			done
			if [ $start -lt $labend ]; then
				if [ $start -lt $labstart ]; then
					DIFFSEC=$(expr $labend - $labstart)
					time=$((time+DIFFSEC))
				else
					DIFFSEC=$(expr $labend - $start)
					time=$((time+DIFFSEC))
				fi
				
			fi
			a=$(date +%H:%M:%S -ud @${time})
			echo -e "${prevname}\t${a}" >> out01
			prevname=$name
		fi
		
		rm time1.txt	
		awk "NR==$index" time.txt>> time1.txt
		let len=1
	fi
	let index+=1
done < $filename
rm input.csv
rm names.txt
rm time.txt
rm time1.txt
rm time2.txt
#Refernce-
#https://www.linuxquestions.org/questions/linux-newbie-8/time-difference-calculation-4175459414/
