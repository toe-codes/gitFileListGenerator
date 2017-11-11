#!/bin/bash

REPO_PATH=$1
HASH_BEFORE=$2
HASH_AFTER=$3
SCRIPT_DIR=$(cd $(dirname $0);pwd)
pushd $REPO_PATH
git diff -w --numstat $HASH_BEFORE $HASH_AFTER > $SCRIPT_DIR/tmp/numstat.txt
git diff --name-status $HASH_BEFORE $HASH_AFTER > $SCRIPT_DIR/tmp/name-status.txt
git ls-tree -r --name-only $HASH_AFTER > $SCRIPT_DIR/tmp/ls-files.txt
popd
echo $SCRIPT_DIR
pwd
rscript $SCRIPT_DIR/module/createCSV.r $SCRIPT_DIR $SCRIPT_DIR/tmp/numstat.txt $SCRIPT_DIR/tmp/name-status.txt $SCRIPT_DIR/tmp/ls-files.txt
