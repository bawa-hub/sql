# pull image
docker run -e POSTGRES_PASSWORD=postgres --name pg postgres

# run
docker exec -it pg psql -U postgres