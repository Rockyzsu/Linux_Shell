#!/bin/bash
# 切割字符
 
string="hello,shell,split,test"  
array=(${string//,/ })  

for var in ${array[*]}
do
   echo $var
done 

echo ${array[1]}
