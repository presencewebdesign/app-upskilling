source .env 

docker run --name directus-pg -e POSTGRES_USER=$DB_USER -e POSTGRES_PASSWORD=$DB_PASSWORD -e POSTGRES_DB=$DB_DATABASE -d -p $DB_PORT:5432 postgres