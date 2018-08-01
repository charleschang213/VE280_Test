import sqlite3
import sys
conn = sqlite3.connect('test.sqlite')
cur = conn.cursor()

cur.execute('''INSERT INTO Test (user_name,result) VALUES ( ?, ? )''', ( sys.argv[1],sys.argv[2],))

conn.commit()
