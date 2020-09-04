file=$1

awk 'BEGIN{
			FS="-"
			city["011"] = "New Delhi, Delhi"
			city["022"] = "Mumbai, Maharashtra"
			city["033"] = "Kolkata, West Bengal"
			city["044"] = "Chennai, Tamil Nadu"
			city["040"] = "Hyderabad, Telengana"
			city["080"] = "Bengaluru, Karnataka"
			city["020"] = "Pune, Maharashtra"
			city["079"] = "Ahmedabad, Gujarat"				
		}
	{
		for (I=1;I<=NF;I++)
		{
			if (($I=="011" || $I=="022" || $I=="033" || $I=="044" || $I=="040" || $I=="080" || $I=="020" || $I=="079")) 
				if(substr($(I+1),0,8)!="00000000" && substr($(I+1),9,1)==" ")
					{
						print $I "-" substr($(I+1),0,8)," " city[$I]
					}
				else if(substr($(I+1),0,8)!="00000000" && substr($(I+1),9,1)=="")
					{
						print $I "-" substr($(I+1),0,8), city[$I]
					}
		};}' ./$file > myoutput.txt



awk 'BEGIN{
			FS="-"		
		}
	{
		for (I=1;I<=NF;I++)
		{
			if (($I=="011" || $I=="022" || $I=="033" || $I=="044" || $I=="040" || $I=="080" || $I=="020" || $I=="079")) 
				if(substr($(I+1),0,8)!="00000000" && substr($(I+1),9,1)==" ")
					{
						print "im_sawan_gurjar" $(I-1)
					}
			else if(substr($(I+1),0,8)!="00000000" && substr($(I+1),9,1)=="")
					{
						print $(I-1)
					}
		};}' ./$file> lorem_ipsum_file.txt

awk 'BEGIN{
				FS=" "
		}
	{
		if(substr($1,0,15) == "im_sawan_gurjar")
			{
				print " " $NF
			}
		else
			{
				print $NF
			}
	}' lorem_ipsum_file.txt > finalname.txt


awk 'BEGIN{FS="im_sawan_gurjar"}{getline line < "finalname.txt"; print line,$1}' myoutput.txt

rm lorem_ipsum_file.txt
rm finalname.txt
rm myoutput.txt

