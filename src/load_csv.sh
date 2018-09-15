#! /usr/bin/env bash

# cribbed from https://www.cyberciti.biz/faq/unix-linux-extract-filename-and-extension-in-bash/
CSVPATH="$1"
CSVFILE="${CSVPATH##*/}"
TABLENAME="${CSVFILE%.*}"
DBFILE="$TABLENAME.db"

#echo $CSVPATH
#echo $CSVFILE
#echo $TABLENAME
#echo $DBFILE

# TODO: Detect whether $CSVPATH is a well formatted CSV.

echo -e ".mode csv\n.import $CSVPATH '$TABLENAME'" | sqlite3 $DBFILE
