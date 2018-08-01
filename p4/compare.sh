# !/bin/bash
same=1
if [ ! -f "compare_lock" ];
then
	touch compare_lock
	rm -f diff_$1_$2.txt
	touch diff_$1_$2.txt
	k=$((0));
	for j in `seq 101`
	do
		i=$(($j-1));
		echo ----------Test Case $i---------- >> diff_$1_$2.txt;
		diff -b answers/$1/test$i.out answers/$2/test$i.out >> diff_$1_$2.txt;
		if [ ! $? -eq 0 ];
		then
			k=$(($k+1));
			same=0;
		fi
		echo -------------------------------- >> diff_$1_$2.txt;
	done
	if [ $k -eq 0 ];
	then
		echo Your results are the same!
	else
		echo You have differences in $k cases
	fi
	echo 
	cd stat
	python dump_compare.py $1 $2 $same
	cd ..
	rm -f compare_lock
else
	echo Error: Someone else is comparing
fi
