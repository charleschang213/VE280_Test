# !/bin/bash
if [ ! -f "lock" ];
then
	touch lock
	echo Username: $1
	echo *****Standard Test*****
	for j in `seq 127`
	do
		i=$(($j-1))
		echo *****Test case $i*****
		if [ $i -eq 10 ]
		then
			./workspace/$1/p3 cases/test$i/spec cases/test$i/world 10 v > answers/$1/test$i.out
		else
			if [ $i -eq 9 ]
			then
				./workspace/$1/p3 cases/test$i/species cases/test$i/world -2 v > answers/$1/test$i.out
			else
				if [ $i -eq 8 ]
				then
					./workspace/$1/p3 cases/test$i/species cases/test$i/world v > answers/$1/test$i.out
				else
					./workspace/$1/p3 cases/test$i/species cases/test$i/world 10 v  > answers/$1/test$i.out
				fi
			fi
		fi
		if [ $? -eq 0 ]
		then
			echo run successfully
		else
			echo fail
		fi
		sleep 0.03
	done
	echo *****Special Test*****
	echo ***Cite: Jiayi Fang***
	cp ./workspace/$1/p3 ./cases/50tests_fang/p3
	chmod 777 ./cases/50tests_fang/p3
	cd cases/50tests_fang
	./test.sh
	rm -f p3
	rm -f output-*
	cd ../..
	rm -f lock
else
	echo Error: Someone else is testing!
fi
