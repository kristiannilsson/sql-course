# python -m venv venv
# venv/scripts/activate
# pip install psycopg2
# pip install flask

from flask import Flask, render_template, request
from psycopg2 import connect, DatabaseError


app = Flask(__name__)


def execute_query(query, parameters=None):
    """Ansluter till databasen"""
    conn = None
    try:
        conn = connect(
            dbname="postgres",
            user="postgres",
            host="localhost",
            password="123",
        )
        with conn.cursor() as cursor: #returnerar en cursor
            cursor.execute(query, parameters) # kör en query
            conn.commit() #committar ändringarna i databasen
            if cursor.description: #Om queryn är en SELECT
                return cursor.fetchall() # returnerar alla rader från queryn.
    # vid ett stort resultat kan man använda exempelvis .fetchone() för att förhindra memory overflow
    except DatabaseError as e:
        print(e)
    finally:
        if conn:
            conn.close()


@app.route("/", methods=["GET"])
def render_index():
    return render_template("index.html")


@app.route("/submit", methods=["POST"])
def submit():
    salary = request.form.get("salary")
    query_result = execute_query("SELECT first_name, salary FROM employees WHERE salary > %s", (salary,))
    if query_result is None:
        query_result = []
    return render_template("index.html", data=query_result)


if __name__ == "main":
    app.run()
