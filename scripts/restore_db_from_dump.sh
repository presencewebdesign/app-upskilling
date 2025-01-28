source .env

docker exec -i directus-pg psql -U $DB_USER -d $DB_DATABASE -f - < ./data/directus_dump.sql