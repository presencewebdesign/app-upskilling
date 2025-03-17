source .env

# First, restore the schema and data
docker exec -i directus-pg psql -U $DB_USER -d $DB_DATABASE -f - < ./data/directus_dump.sql

# Then reset the sequences
docker exec -i directus-pg psql -U $DB_USER -d $DB_DATABASE -c "SELECT setval('directus_activity_id_seq', (SELECT MAX(id) FROM directus_activity));"
docker exec -i directus-pg psql -U $DB_USER -d $DB_DATABASE -c "SELECT setval('directus_permissions_id_seq', (SELECT MAX(id) FROM directus_permissions));"
docker exec -i directus-pg psql -U $DB_USER -d $DB_DATABASE -c "SELECT setval('directus_presets_id_seq', (SELECT MAX(id) FROM directus_presets));"
docker exec -i directus-pg psql -U $DB_USER -d $DB_DATABASE -c "SELECT setval('directus_relations_id_seq', (SELECT MAX(id) FROM directus_relations));"
docker exec -i directus-pg psql -U $DB_USER -d $DB_DATABASE -c "SELECT setval('directus_settings_id_seq', (SELECT MAX(id) FROM directus_settings));"