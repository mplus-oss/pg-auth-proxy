#!/bin/sh

get_options() {
    grep -A999 "\[options\]" "/opt/odoo/etc/odoo.conf" | grep "$1" | awk -F'=' '{print $2}' | tr -d '[:space:]'
}

export POSTGRESQL_HOST="$(get_options db_host)"
export POSTGRESQL_PORT="$(get_options db_port)"
export POSTGRESQL_USER="$(get_options db_user)"
export POSTGRESQL_PASSWORD="$(get_options db_password)"
export POSTGRESQL_DATABASE="$1"

# Check if POSTGRESQL_HOST is set
if [ -z "$POSTGRESQL_HOST" ]; then
  echo "POSTGRESQL_HOST is not set. Exiting."
  exit 1
fi

# Check if POSTGRESQL_PORT is set
if [ -z "$POSTGRESQL_PORT" ]; then
  echo "POSTGRESQL_PORT is not set. Exiting."
  exit 1
fi

# Check if POSTGRESQL_USER is set
if [ -z "$POSTGRESQL_USER" ]; then
  echo "POSTGRESQL_USER is not set. Exiting."
  exit 1
fi

# Check if POSTGRESQL_PASSWORD is set
if [ -z "$POSTGRESQL_PASSWORD" ]; then
  echo "POSTGRESQL_PASSWORD is not set. Exiting."
  exit 1
fi

# Check if POSTGRESQL_DATABASE is set
if [ -z "$POSTGRESQL_DATABASE" ]; then
  echo "POSTGRESQL_DATABASE is not set. Exiting."
  exit 1
fi

envsubst < /etc/pgbouncer/pgbouncer.ini.tmpl > /etc/pgbouncer/pgbouncer.ini
exec pgbouncer /etc/pgbouncer/pgbouncer.ini