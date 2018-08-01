# !/bin/bash
count=1
if [ ! -f "lock" ];
then
	echo Username: $1
	touch lock
	echo ********Dlist Test*********
	cd workspace/$1
	./test
	if [ ! $? -eq 0 ];
	then
		rm -f lock
		echo Implementation Fail!
		exit
	else
		valgrind --leak-check=full --error-exitcode=10 ./test
		if [ $? -eq 10 ];
		then
			sleep 0.1
			echo Memory Leakage!
			rm -f lock
			exit
		fi
		sleep 0.1
		echo Successful!
		echo
	fi
	cd ../..
	echo *********Calc Test*********
	for j in `seq 101`
	do
		i=$(($j-1))
		echo *****Test case $i*****
		cd cases/test$i
		./../../workspace/$1/calc < test1.in >  ../../answers/$1/test1_$i.out
		rv=$?
		FILE_SIZE=`du ../../answers/$1/test1_$i.out | awk '{print $1}'`
		if [ $FILE_SIZE -gt 10485760 ];
		then
			rm -f ../../answers/$1/test1_$i.out
			echo Abnormal Output FIle
		    count=0
		else
			if [ ! $rv -eq 0 ];
			then
				echo Runtime Failed!
				count=0
			else
				if [ $i -lt 10 ];
				then
					touch ../../answers/$1/report.out
					valgrind --quiet --log-file=../../answers/$1/report.out  --leak-check=full --error-exitcode=10 ./../../workspace/$1/calc < test1.in > ../../answers/$1/vgcheck.out
					if [ $? -eq 10 ];
					then
						echo Memory Leakage!
						cat ../../answers/$1/report.out
						count=0
					else
						echo Run Successfully!
					fi
					rm -f ../../answers/$1/vgcheck.out
					rm -f ../../answers/$1/report.out
				else
					echo Run Successfully!
				fi
			fi
		fi
		sleep 0.05
		cd ../..
	done
	echo
	echo *********Call Test*********
	for j in `seq 101`
	do
		i=$(($j-1))
		echo *****Test case $i*****
		cd cases/test$i
		./../../workspace/$1/call < test2.in >  ../../answers/$1/test2_$i.out
		FILE_SIZE=`du ../../answers/$1/test2_$i.out | awk '{print $1}'`
		rv=$?
		if [ $FILE_SIZE -gt 10485760 ];
		then
			echo Abnormal Output File
			rm -f ../../answers/$1/test2_$i.out
			count=0
		else
			if [ ! $rv -eq 0 ];
			then
				echo Runtime Failed!
				count=0
			else
				if [ $i -lt 10 ];
				then				
					touch ../../answers/$1/report.out
					valgrind --quiet --log-file=../../answers/$1/report.out  --leak-check=full --error-exitcode=10 ./../../workspace/$1/call < test2.in > ../../answers/$1/vgcheck.out
					if [ $? -eq 10 ];
					then
						echo Memory Leakage!
						cat ../../answers/$1/report.out
						count=0
					else
						echo Run Successfully!
					fi
					rm -f ../../answers/$1/vgcheck.out
					rm -f ../../answers/$1/report.out
				else
					echo Run Successfully!
				fi
			fi
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
