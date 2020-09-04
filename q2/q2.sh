#!/usr/bin/bash


for word in $(cat $1):
do
  echo $word >> new
 
done
cat new | sed -i 's/,/"\n/g' new


cp /dev/null url
cat new | sed -n -r '/(http|https):\/\/www\.cse\.iitb\.ac\.in\/~/p' >> url


cp /dev/null newn1
cat $1 >> newn1

sed -i 's!http\(s\)\{0,1\}://[^[:space:] \) \( ]*! !g' newn1
sed -i 's![^[:space:]]*.com\/[^[:space:] \) \( ]*! !g' newn1
sed -i 's![^[:space:]]*.in\/[^[:space:] \) \( ]*! !g' newn1
sed -i 's![^[:space:]]*.net\/[^[:space:] \) \( ]*! !g' newn1
sed -i 's![^[:space:]]*.gov\/[^[:space:] \) \( ]*! !g' newn1
sed -i 's![^[:space:]]*.edu\/[^[:space:] \) \( ]*! !g' newn1
sed -i 's![^[:space:]]*.org\/[^[:space:] \) \( ]*! !g' newn1
sed -i 's![^[:space:]]*.co\/[^[:space:] \) \( ]*! !g' newn1
sed -i 's![^[:space:]]*.us\/[^[:space:] \) \( ]*! !g' newn1
sed -i 's![^[:space:]]*.au\/[^[:space:] \) \( ]*! !g' newn1

sed -i 's/	\{1,\}/ /gi' newn1
sed -i 's/ \{1,\}/ /gi' newn1

cp /dev/null $1
cat newn1 >> $1

rm new
rm newn1
#rm newn1
