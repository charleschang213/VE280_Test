# !/bin/bash
scp p3.tar $1@47.100.206.163:/home/VE280_Test/p3/workspace/$1/p3.tar
ssh $1@47.100.206.163 << eeooff
cd /home/VE280_Test/p3/workspace/$1
tar -xf p3.tar
rm p3.tar
cp ../../world_type.h world_type.h
g++ -std=c++11 -o p3 p3.cpp simulation.cpp
rm -f -r ../../answers/$1
mkdir ../../answers/$1
cd ../..
./test.sh $1
if [ $# -gt 1 ];
then
    ./compare.sh $1 $2
fi
rm -f workspace/$1/*
eeooff
if [ $# -gt 1 ];
then
    scp $1@47.100.206.163:/home/VE280_Test/p3/diff_$1_$2.txt diff_$1_$2.txt
fi
echo done!
