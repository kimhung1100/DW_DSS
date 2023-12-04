import csv
import psycopg2
from psycopg2 import sql

# Database connection parameters
db_params = {
    'host': 'rain.db.elephantsql.com',
    'database': 'kcpaqbhs',
    'user': 'kcpaqbhs',
    'password': 'ah_Ju83dMCFrsOKQ3s2JrMrGz2LtUB8g'
}

# Table and file information
table_name = 'customer_dim'
csv_file_path = 'data/customers.csv'

# Connect to the PostgreSQL database
conn = psycopg2.connect(**db_params)
cursor = conn.cursor()

# Open the CSV file and insert data into the PostgreSQL table
with open(csv_file_path, 'r') as file:
    reader = csv.reader(file)
    header = next(reader)  # Skip the header row

    columns = [sql.Identifier(col) for col in header]
    insert_query = sql.SQL('INSERT INTO {} ({}) VALUES ({})').format(
        sql.Identifier(table_name),
        sql.SQL(',').join(columns),
        sql.SQL(',').join(sql.Placeholder() for _ in header)
    )

    for row in reader:
        cursor.execute(insert_query, row)

# Commit the changes and close the connection
conn.commit()
cursor.close()
conn.close()

print("Data inserted successfully.")
