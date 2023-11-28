from dotenv import load_dotenv
from psycopg2 import DatabaseError, connect
import os
load_dotenv()
conn = None
try:
    conn = connect(
        dbname="postgres",
        user="postgres",
        host="localhost",
        password=os.getenv("DB_PASSWORD"),
    )

    print(conn)

    cursor = conn.cursor()
    #cursor.execute("SELECT * FROM employees;")
    cursor.execute("INSERT INTO users VALUES ('kristian', '123');")
    #print(cursor.fetchall())
    print(cursor)
    print(cursor.fetchone())
    conn.commit()
    cursor.close()
except DatabaseError as error:
    print(error)
finally:
    if conn is not None:
        conn.close()

    
"""
1. connect
2. cursor
3. cursor.fetchall()
4. try-except, stänga connection.
5. .env load_dotenv(), python-dotenv, os.getenv
6. commit()
"""
