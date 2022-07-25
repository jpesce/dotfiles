#!/bin/bash

# Given a file and a line number, return the relevant section to preview

SCRIPTPATH=$(realpath "$0")
SCRIPTDIR=$(dirname "$SCRIPTPATH")

file=$1
line=$2
awk -v line=$line -f $SCRIPTDIR/md_section_plus_children.awk $file $file
