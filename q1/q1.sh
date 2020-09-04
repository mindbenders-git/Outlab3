
awk '
BEGIN {					#This block run only once befor file processed 
	FS="-";				#set the field separater
	RS="!"				#set the record separater
	x=0;				#initialize variable
	y=0;
}
{
	if ( $1=="L")						#condition checking
		{
			x=x-$2;
		}
	else if ($1=="R")
		{
			x=x+$2;
		}
	else if ($1=="U")
	{
		y=y+$2;
	}
	else if ($1=="D")
		{
			y=y-$2;
		}
	print $1"\t("x","y")"				
	
}
END {								#run only once after the file processed
	print "Final Position: ("x","y")"
}										#$1 take input file from terminal
' <"$1">out01						
