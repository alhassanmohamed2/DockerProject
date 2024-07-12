#!/bin/bash
set -e

# Start PostgreSQL server
docker-entrypoint.sh postgres &

# Wait for PostgreSQL to be ready
until pg_isready -h localhost -p 5432 -U "$POSTGRES_USER" -d "$POSTGRES_DB" ; do
    echo "PostgreSQL is unavailable - sleeping"
    sleep 1
done

# Execute custom commands
echo "PostgreSQL is up - executing command"

# Define the SQL command
SQL_COMMAND="CREATE TABLE IF NOT EXISTS shared_table (id SERIAL PRIMARY KEY, name VARCHAR(50));"

# Create .pgpass file with password for postgres user on postgres2 container
echo "postgres2:5432:postgres:postgres:mysecretpassword" > ~/.pgpass
chmod 0600 ~/.pgpass

# Execute the SQL command on the current container (postgres1)
psql -h localhost -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "$SQL_COMMAND"

# Execute the SQL command on postgres2 container
psql -h postgres2 -U postgres -d postgres -c "$SQL_COMMAND"

# Remove the .pgpass file after use (optional)
rm ~/.pgpass

# Wait for PostgreSQL to terminate
wait