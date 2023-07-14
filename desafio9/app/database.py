import mysql.connector

database = mysql.connector.connect(
    host='db',
    user='root',
    password='root',
    database='app_crud_python'
)