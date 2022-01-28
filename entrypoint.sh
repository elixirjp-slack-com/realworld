#!/bin/bash
# Docker entrypoint script.

# Wait until Postgres is ready
echo "Testing if Postgres is accepting connections."
while ! pg_isready -q -h db -p 5432 -U postgres
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

mix setup
mix deps.compile

exec mix phx.server