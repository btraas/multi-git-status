#!/bin/bash

dump(){
    echo "expected:"
    echo "${1}"
    echo "got:"
    echo "${2}"
}

TESTS_DIR="./tests"
rm -rf "$TESTS_DIR" 2> /dev/null
mkdir -p "$TESTS_DIR/a/b"
(
cd "$TESTS_DIR"; git init foo > /dev/null
cd a; git init bar > /dev/null
cd b; git init baz > /dev/null
)

res=$(./mgitstatus --depth=0 "$TESTS_DIR")
#echo "$res"

# Test 1
expected=$(cat << EOF
./tests/a/b/baz: Repo has no commits yet
./tests/a/bar: Repo has no commits yet
./tests/foo: Repo has no commits yet
EOF
)

[[ "$res" = "$expected" ]] \
    && echo "Test 1: 'Repo has no commits yet' passed" \
    || { echo "Test 1: failed."; dump "$expected" "$res"; }

echo "All tests are passed."
