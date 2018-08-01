# !/bin/bash
echo '**********************************************************************'
echo '*                    VE280 Project 5 Test Script                     *'
echo '*                                                                    *'
echo '*     Welcome to the VE280 Project Test released by Zhang Yichi      *'
echo '*     To access the test, what you need are:                         *'
echo '*       1. A registered username                                     *'
echo '*       2. The password                                              *'
echo '*                                                                    *'
echo '*     The Test Structure is:                                         *'
echo '*                                                                    *'
echo '*  Whole Test -- Compile Test                                        *'
echo '*             |                                                      *'
echo '*             -- Run Test -- Dlist -- Implementation Test (1 case)   *'
echo '*                         |        |                                 *'
echo '*                         |        -- Memory Test (1 same case)      *'
echo '*                         |                                          *'
echo '*                         -- Calc -- Implementation Test (101 cases) *'
echo '*                         |       |                                  *'
echo '*                         |       -- Memory Test (Case 0-9)          *'
echo '*                         |                                          *'
echo '*                         -- Call -- Implementation Test (101 cases) *'
echo '*                                 |                                  *'
echo '*                                 -- Memory Test (Case 0-9)          *'
echo '*                                                                    *'
echo '*  You can also perform comparison with other users                  *'
echo '**********************************************************************'

scp p5.tar $1@47.100.206.163:/home/VE280_Test/p5/workspace/$1/p5.tar
ssh $1@47.100.206.163 << eeooff
cd /home/VE280_Test/p5/workspace/$1
tar -xf p5.tar
rm p5.tar
cp ../../*.h .
cp ../../*.cpp .
ls
if ! g++ -std=c++11 -o test test.cpp -Wall -g;
then
	echo Compile Error!
	echo
	cd ../../stat
	python dump_test.py $1 -1
	exit
fi
if ! g++ -std=c++11 -o calc calc.cpp -Wall -g;
then
	echo Compile Error!
	echo
	cd ../../stat
	python dump_test.py $1 -1
	exit
fi
if ! g++ -std=c++11 -o call call.cpp -Wall -g;
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
	scp $1@47.100.206.163:/home/VE280_Test/p5/diff_$1_$2.txt diff_$1_$2.txt
fi
echo done
