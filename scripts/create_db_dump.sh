source .env 

docker exec -t directus-pg pg_dump -U pguser $DB_DATABASE > ./data/directus_dump.sql 