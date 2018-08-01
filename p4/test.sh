# !/bin/bash
count=1
if [ ! -f "lock" ];
then
	touch lock
	echo Username: $1
	echo *****Standard Test*****
	for j in `seq 101`
	do
		i=$(($j-1))
		echo *****Test case $i*****
		cd cases/test$i
		./casetest.sh $1 > ../../answers/$1/test$i.out
		if [ ! $? -eq 0 ];
		then
			echo Failed!
			count=0
		else
			echo Run Successfully!
		fi
		sleep 0.05
		cd ../..
	done
	cd stat
	python dump_test.py $1 $count
	cd ..
	rm -f lock
else
	echo Error: Someone else is testing!
fi
