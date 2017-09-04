#!/usr/bin/env bash

#

#cross build binary
export GOOS=linux
export GOARCH=amd64
export CGO_ENABLED=0

echo "### Cross building for $GOOS $GOARCH ..."

#
[[ $DEBUG ]] && FLAG="-x"

##
function clean() {
    rm -rf ./build
    rm -rf ./vendor
    rm -rf ./Godeps
}

function vendor() {
    chmod +x ./vendor.sh
    ./vendor.sh; if [ $? -ne 0 ]; then
        exit 1
    fi
}

##
function build() {
    mkdir -p bin
    rm -rf bin/*

    echo "## Cleaning ..."
    go clean $FLAG

    echo "## Building ..."
    go build $FLAG -buildmode=exe -o bin/tunnel -ldflags '-extldflags "-static"'

    echo "## Testing ..."
    go test $FLAG
}

echo "#### Cleaning ..."
clean

echo "#### Vendoring ..."
vendor

echo "#### Building ..."

build; if [ $? -ne 0 ]; then
    exit 1
fi

echo "#### Build successful"

exit 0
##

