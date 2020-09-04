BEGIN {
	i=1;
	j=1;					# used to trace number of record i  each file
	k=1;
	n_of_r_f1=0;			# count number of record in file one
	FS="[ :]+"				# regular expression for field separator
	arraay[1,1]=0;			# used to hold data of both file,this is 2d array
	arrdup[1]=0;			# avoid duplication problem
	leerec[1]=1;			# keep track number of field in each record	
	ANS=0;
	c=0;
}
{
	if (FNR==NR)
		{						#reading data of file1
			
	i=1;
	while (length($(i)) > 0)
			{
			#printf $(i)" "
			arraay[j,i]=$(i);
			i++;
			leerec[j]=i;
		}
		#arraay[j]=$0;
		
		j++;
		#printf"\n"
		n_of_r_f1=j;
	}
	else {								#reading data of file 2

		i=1;
	while (length($(i)) > 0)
			{
			#printf $(i)" "
			arraay[j,i]=$(i);
			i++;

		}	
	arrdup[$1]=0;
	j++;
}
	
}
END{
	xx=0									#var to keep track number of match in each record
	for ( i=1;i<n_of_r_f1;i++)
	{	
	t=arraay[i,1];
	xx=0;
		for(lm=2;lm<leerec[i];lm++)
		{
		if(arraay[t+n_of_r_f1-1,lm]==arraay[i,lm])
			{
			xx++;
			}
		}
		if (arrdup[arraay[i,1]]<xx)
		{
			arrdup[arraay[i,1]]=xx;
		}
	}
	for (lm=1;lm<=j-n_of_r_f1;lm++)
	{
	ANS+=arrdup[lm];
	}
	print ANS
}