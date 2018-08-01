# !/bin/bash
ssh $1@47.100.206.163 << eeooff
cd /home/VE280_Test/p4/stat
python print_stat.py $1
eeooff
echo
echo done!
