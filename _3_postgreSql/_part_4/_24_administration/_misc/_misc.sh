# docker postgres
docker run -e POSTGRES_PASSWORD=postgres --name pg postgres # pull image
docker exec -it pg psql -U postgres # run

# install on mac
https://www.geeksforgeeks.org/install-postgresql-on-mac/

# postgres psql commands
https://www.geeksforgeeks.org/postgresql-psql-commands/

# restore database
pg_restore -U postgres -d dvdrental C:\users\sample_datbase\dvdrental.tar
