# !/bin/bash
scp p4.tar $1@47.100.206.163:/home/VE280_Test/p4/workspace/$1/p4.tar
ssh $1@47.100.206.163 << eeooff
cd /home/VE280_Test/p4/workspace/$1
tar -xf p4.tar
rm p4.tar
cp ../../*.h .
cp ../../*.cpp .
if ! g++ -std=c++11 -o p4 blackjack.cpp deck.cpp hand.cpp player.cpp card.cpp rand.cpp -Wall;
then
	echo Compile Error!
	echo
	cd ../../stat
	python dump_test.py $1 -1
	exit
fi
echo Compile Succeeded!
echo
cd ../..
rm -f -r answers/$1
mkdir answers/$1
./test.sh $1
if [ $# -gt 1 ];
then
	./compare.sh $1 $2
fi
rm -f workspace/$1/*
eeooff
if [ $# -gt 1 ];
then
	scp $1@47.100.206.163:/home/VE280_Test/p4/diff_$1_$2.txt diff_$1_$2.txt
fi
echo done!
