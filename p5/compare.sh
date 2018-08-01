# !/bin/bash
same=1
if [ ! -f "compare_lock" ];
then
	touch compare_lock
	rm -f diff_$1_$2.txt
	touch diff_$1_$2.txt
	k=$((0));
	echo
	echo **********Calc Part************* >> diff_$1_$2.txt;
	for j in `seq 101`
	do
		i=$(($j-1));
		echo ----------Test Case $i---------- >> diff_$1_$2.txt;
		diff -b answers/$1/test1_$i.out answers/$2/test1_$i.out >> diff_$1_$2.txt;
		if [ ! $? -eq 0 ];
		then
			k=$(($k+1));
			same=0;
		fi
		echo -------------------------------- >> diff_$1_$2.txt;
	done
	if [ $k -eq 0 ];
	then
		echo Your results are the same in Calc Part!
	else
		echo You have differences in $k cases in Calc Part
	fi
	echo 
	k=$((0));
	echo **************Call Part************* >> diff_$1_$2.txt;
	echo
	for j in `seq 101`
	do
		i=$(($j-1));
		echo ----------Test Case $i---------- >> diff_$1_$2.txt;
		diff -b answers/$1/test2_$i.out answers/$2/test2_$i.out >> diff_$1_$2.txt;
		if [ ! $? -eq 0 ];
		then
			k=$(($k+1));
			same=0;
		fi
		echo -------------------------------- >> diff_$1_$2.txt;
	done
	if [ $k -eq 0 ];
	then
		echo Your results are the same in Call Part!
	else
		echo You have differences in $k cases in Call Part
	fi
	echo 

	cd stat
	python dump_compare.py $1 $2 $same
	cd ..
	rm -f compare_lock
else
	echo Error: Someone else is comparing
fi
