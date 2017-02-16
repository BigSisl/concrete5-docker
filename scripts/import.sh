#!/bin/bash

# Simple script which
#  - imports the zip file / endpacks it at the correct location
#       /data/var/www/html/
#  - removes old mysql db
#  - import new sql by .sql file

folder=$1
data=data.zip
sql=db.sql

htmldocs=../data/var/www/html/
sqlimport=../import
sqldata=../data/var/lib

cd "$( dirname "${BASH_SOURCE[0]}" )"

# shutdown
docker-compose down

rm -rf $sqldata

mkdir -p $htmldocs
mkdir -p $sqlimport

cp $folder/$sql ../import
unzip $folder/$data -d ../data/var/www/html/

docker-compose up -d
