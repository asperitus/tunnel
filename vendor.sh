#!/usr/bin/env bash

#
echo "#### Vendoring..."

#
which godep; if [ $? -ne 0 ]; then
    echo "godep missing, installing ..."
    go get github.com/tools/godep
fi

#
PKGS=(
)

for pkg in ${PKGS[@]}; do
  echo "Getting: $pkg"
  go get -d -insecure $pkg
done

echo "go get ./..."
go get -v -d -insecure ./...

godep save; if [ $? -ne 0 ]; then
    echo "godep failed"
    exit 1
fi

echo "#### Vendoring done"

exit 0
##
