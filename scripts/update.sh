#!/bin/bash
set -e

# Updates the internal data with an other concrete5 development or production
# server by syncronising the database and persistent data storage (mainly files)
# Specificaly for concrete5 application:
# download
# {FTP:FOLDER}/application/files
# download DB and importing Data to local server
# {SERVER}:{PORT} {DBNAME} {DBPW} {DBUSR}
SERVER=
PORT=
DBNAME=
DBUSR=
DBPW=

# updated new database information
# POSSIBLE REGEX:
#(return *\[[\n\t\ra-zA-Z \[\]\'-=>_,]*\'connections\' *=>[\n\t\ra-zA-Z \[\]\'-=>_,]*\'concrete\' *=>[\n\t\ra-zA-Z \[\]\'-=>_,]*\'server\' *=> *\')(.*)(\')

# Prepare external Database


# Syncronise the database

# Download files
