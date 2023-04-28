# start postgres
systemctl start postgresql

#connect to database
sudo -i -u <username> # postgres command prompt
psql # db connected

# list of databases
\l

# use database
\c <db_name>

# list of tables
\dt

# quit
\q

# import sql data
https://www.a2hosting.com/kb/developer-corner/postgresql/import-and-export-a-postgresql-database/