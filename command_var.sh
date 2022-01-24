#!/bin/bash

#cmd=$(echo "hela"a)
#echo ${cmd "goo"}


#cmd=$(ls -l)
#echo ${cmd}
s1="ps -aux"
s2="|grep python"
# echo ${s1+s2}
s3=$s1$s2
#echo $3
echo `${s3}`
