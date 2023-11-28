from dotenv import load_dotenv
from psycopg2 import DatabaseError, connect
import os
load_dotenv()

try:
    conn = connect(
        dbname="postgres",
        user="postgres",
        host="localhost",
        password=os.getenv("DB_PASSWORD"),
    )

    cursor = conn.cursor()

    cursor.execute("SELECT * FROM employees;")
    print(cursor.fetchall())
    cursor.close()
    conn.close()
except DatabaseError as error:
    print(error)

    
"""
1. connect
2. cursor
3. cursor.fetchall()
4. try-except, stänga connection.
5. .env load_dotenv(), python-dotenv, os.getenv
6. commit()
"""
