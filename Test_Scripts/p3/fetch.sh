# !/bin/bash
rm -r -f $1
scp -r $1@47.100.206.163:/home/VE280_Test/p3/answers/$1 $1
