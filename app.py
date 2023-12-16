#!/usr/bin/env python3

# SOURCE: https://towardsdatascience.com/generating-random-data-into-a-database-using-python-fd2f7d54024e

import os
import pandas as pd
import pyodbc
from faker import Faker
from collections import defaultdict
from sqlalchemy import create_engine

db_name = os.getenv("MSSQL_DB")
db_host = os.getenv("MSSQL_URL")
db_user = os.getenv("MSSQL_USER")
db_pass = os.getenv("MSSQL_PASSWORD")
db_port = os.getenv("MSSQL_PORT")

conn = pyodbc.connect("Driver={SQL Server};"
                      f"Server={db_host};"
                      f"Database={db_name};"
                      "Trusted_Connection=yes;")

cursor = conn.cursor()
cursor.execute(f"SELECT * FROM {db_name}")

# # generate fake data
# fake = Faker()
# fake_data = defaultdict(list)

# for _ in range(1000):
#     fake_data["first_name"].append(fake.first_name())
#     fake_data["last_name"].append(fake.last_name())
#     fake_data["occupation"].append(fake.job())
#     fake_data["dob"].append(fake.date_of_birth())
#     fake_data["country"].append(fake.country())

# # create dataframe
# df_fake_data = pd.DataFrame(fake_data)

# # create testdb database
# engine = create_engine(f"mssql+pyodbc://{db_user}:{db_pass}@{db_host}/{db_name}?driver=SQL+Server")

# # insert data into testdb database
# df_fake_data.to_sql(db_name, engine, if_exists="replace", index=False)

# # read data from testdb database
# df_fake_data = pd.read_sql(f"SELECT * FROM {db_name}", engine)


# TODO: test ms sql connection then run faker code
def main():
    for row in cursor:
        print('row = %r' % (row,))
    # print(df_fake_data.head())


if __name__ == "__main__":
    main()
