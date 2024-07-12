docker network create mynetwork


docker run -d --name postgres2 --network mynetwork -e POSTGRES_PASSWORD=mysecretpassword postgres
docker build -t test_post . --file dictfile

docker run -d --name test_pos --network mynetwork  test_post

docker exec -it test_pos bash

psql -h localhost -U postgres -d postgres -c "SELECT * FROM shared_table;"
psql -h localhost -U myuser -d mydatabase -c "SELECT * FROM shared_table;"

