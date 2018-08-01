import sqlite3
import sys
conn = sqlite3.connect('test.sqlite')
cur = conn.cursor()

cur.execute('''INSERT INTO Compare (sender,compared,result) VALUES ( ?, ?, ? )''', ( sys.argv[1],sys.argv[2],sys.argv[3],))

conn.commit()
