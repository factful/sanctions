#! /usr/bin/env bash

# cribbed from https://www.cyberciti.biz/faq/unix-linux-extract-filename-and-extension-in-bash/
FILEPATH="$1"
CSVFILE="${FILEPATH##*/}"
TABLENAME="${CSVFILE%.*}"
DBFILE="$TABLENAME.sqlite"

#echo $FILEPATH
#echo $CSVFILE
#echo $TABLENAME
#echo $DBFILE

# Ask what *nix we're on, so we can ask what `file` command we have.
UNAME=$(uname)
if [ $UNAME == 'Darwin' ]
then
  FILESTRING=$(file -I $FILEPATH)
else
  FILESTRING=$(file -i $FILEPATH)
fi
MIMETYPE=${FILESTRING#*:}
#echo $MIMETYPE
#echo ${MIMETYPE%/*}

# Bail if the file 
if [ ${MIMETYPE%/*} == 'text' ]
then
  echo "Text File!  Proceeding..."
  echo -e ".mode csv\n.import $FILEPATH '$TABLENAME'" | sqlite3 $DBFILE
  echo "created $DBFILE"
else
  echo "ERROR: $FILEPATH isn't a text file"
  exit 1
fi
