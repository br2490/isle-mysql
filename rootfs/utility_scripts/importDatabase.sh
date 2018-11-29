#!/bin/bash

echo "Usage: importDatabases <destination> <optional: absolute path to .sql or .sql.gz file on container>."

dest=$(echo "$1" | tr '[:upper:]' '[:lower:]'); shift

case "$dest" in
	fedora)   echo "Destination is Fedora database."; mysql="mysql -u $FEDORA_DB_USER -p$FEDORA_DB_PASS $FEDORA_DB"; f=/import/fedora.sql.gz; ;;
	drupal)   echo "Destination is Drupal database."; mysql="mysql -u $DRUPAL_DB_USER -p$DRUPAL_DB_PASS $DRUPAL_DB"; f=/import/drupal.sql.gz; ;;
	*)        echo "Unknown database destination. Valid options are 'Drupal' or 'Fedora.'"; exit; ;;
esac

if [ $1 ]; then
	f=$1
fi

case "$f" in
	*.sql)    echo "Importing $f"; "$mysql" < "$f"; echo ;;
	*.sql.gz) echo "Importing $f"; gunzip -c "$f" | "$mysql"; echo ;;
	*)        echo "Importing $f" ;;
esac
echo
