#!/usr/bin/env bash

cd "$(dirname "$0")"

source env.source.sh

mkdir -p target/stl

find . \( -type d -name 'templates' -prune \) -o \( -name '*.scad' -print \) | while read f; do
    name="$(basename "$f" .scad)"
    tgt_file=target/stl/"$name".stl
    echo "'$f' -> '$tgt_file'"
    (set -x; "$OPENSCAD_PATH" -o "$tgt_file" "$f")
done
