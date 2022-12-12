#!/usr/bin/env bash

echo "-----Creating ${POSTGRES_USER} database-----"
psql -U postgres -c "CREATE DATABASE ${POSTGRES_USER}"

echo "-----Restoring database from ${PATH_RESTORE_FILE}${RESTORE_FILE}-----"
pg_restore -v -d ${POSTGRES_USER} /tmp/${PATH_RESTORE_FILE}${RESTORE_FILE} > /tmp/log

echo "-----Granting privileges-----"
psql -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE ${POSTGRES_USER} TO postgres"

echo "-----Import datamart from ${PATH_DLL_FILE}${DLL_FILE}-----"
psql -U postgres -d ${POSTGRES_USER} -a -f /tmp/${PATH_DLL_FILE}${DLL_FILE}

echo "-----Database restored and datamart imported successfully-----"