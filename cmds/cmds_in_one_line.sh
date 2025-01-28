#! /bin/bash

# execute commands in one line, use `;` to separate commands
echo "hello"; echo "world"

# use && (AND) to execute commands in one line, if one command fails, the whole line will fail
echo "**************************************"
test -d utils && echo "utils dir exists"
test -d tests && echo "tests dir exists"
echo "**************************************"

# use || (OR) to execute commands in one line, if one command fails, the whole line will fail
echo "**************************************"
test -d utils || echo "utils dir does not exist"
test -d tests || echo "tests dir does not exist"
echo "**************************************"

echo "**************************************"
test -d utils && echo "utils dir exists" || echo "utils dir does not exist"
test -d tests && echo "tests dir exists" || echo "tests dir does not exist"
echo "**************************************"
