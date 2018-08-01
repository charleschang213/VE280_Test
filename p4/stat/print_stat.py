import sqlite3
import sys

conn = sqlite3.connect('test.sqlite')
cur = conn.cursor()

print("\n*******************SUBMISSION  STAT*******************\n")
print("     user_name         submit   success      RE     CE")

str_t = '''SELECT 
    user_name,
    count(*),
    sum(case when result=1 then 1 else 0 end),
    sum(case when result=0 then 1 else 0 end),
    sum(case when result=-1 then 1 else 0 end)
    FROM Test
    GROUP BY user_name'''
for row in conn.execute(str_t):
    if row[0].encode('ascii')==sys.argv[1] or sys.argv[1]=='root':
        print("%15s %11d %9d %9d %6d" % (row[0].encode('ascii'),row[1],row[2],row[3],row[4]))

str_c = '''SELECT
    sender,
    compared,
    count(*),
    sum(result)
    FROM Compare
    GROUP BY sender,compared'''

print("\n********************COMPARE   STAT********************\n")
print("       send         compared         total      same")

for row in conn.execute(str_c):
    if row[0].encode('ascii')==sys.argv[1] or sys.argv[1]=='root':
        print("%15s %15s %9d %9d" % (row[0].encode('ascii'),row[1].encode('ascii'),row[2],row[3]))
