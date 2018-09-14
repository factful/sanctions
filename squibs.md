# Squibs

## Goals

* Prove out a packaging pipeline.
* Package cleaned data to target software to.

## Approach

* Begin by packaging cleaned data and beginning to define a destination target.
* Incrementally define transforms and intermediate/parent packages for the end result
* incorporate as much of the OpenSanctions pipeline as we're comfortable with.

## Processing Log

### 1) CSV -> SQLite

Poked around a couple existing mechanisms for importing CSV into SQLite.

There are two main things that have to be done to dump a CSV into SQLite in the ideal case.

1. figure out what you want to call the table.
2. analyze the CSV contents to generate table schema & name the columns.
3. produce some indexes?

So, Ted poked around to see what existing tools did.

Simon Willison's [`csvs-to-sqlite`][csvs-to-sqlite] uses [PANDAS to scan rows and infer types](https://github.com/simonw/csvs-to-sqlite/blob/master/csvs_to_sqlite/utils.py#L370-L394), and then generates table schemas on that basis.

PANDAs in turn does type inference just [by sequentially trying converters](https://rushter.com/blog/pandas-data-type-inference/).  This means that PANDAs type conversion is relatively slow, particularly for columns that are in fact text.

Rufus from Frictionless built [a csv to sqlite extractor as well](https://github.com/rufuspollock/csv2sqlite).  

CSVKit has `csvsql` which can be used to target any db that django can handle.

SQLite3 has a CSV module which, if available, could be used to read into a temporary virtual table, and then get copied into a real table.  Unfortunately the built in version of sqlite3 on OSX was not compiled with the ability to load modules.

SQLite3 does include a Full Text Search module (FTS4) built in on OSX.

[csvs-to-sqlite]: https://github.com/simonw/csvs-to-sqlite/