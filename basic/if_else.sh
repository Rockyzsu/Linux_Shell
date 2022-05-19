#!/bin/bash

a=20
b=10
c=30
if [ $a == $b -o $a==$c ];then
echo "a is equal to b"
else
echo "failed"
fi
