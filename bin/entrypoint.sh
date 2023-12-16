#!/usr/bin/env bash

# Start the script to create the DB and user
/usr/config/bin/configure-db.sh &

# TODO: "/opt/mssql/bin/sqlservr: Invalid mapping of address 0x4004bac000 in reserved address space below 0x400000000000."
# Start SQL Server
/opt/mssql/bin/sqlservr
