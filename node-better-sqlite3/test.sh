#!/bin/sh

# Very basic test script for better-sqlite3

PKG_NAME="$1"
PKG_VERSION="$2"

test_script='
  const Database = require("better-sqlite3");
  const db = new Database(":memory:")

  db.exec("CREATE TABLE test (my_number INTEGER PRIMARY KEY)");
  db.exec("INSERT INTO test (my_number) VALUES (42)");

  const stmt = db.prepare("SELECT * from test");
  const rows = stmt.all();
  console.log("Got the following rows from the database: ", rows);
'

node --eval="$test_script"
