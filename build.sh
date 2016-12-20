#!/bin/bash

C5_VERSION=8.0.3

# download sourcecode
rm -rf src

git clone -b $C5_VERSION --single-branch https://github.com/concrete5/concrete5.git ./src

docker build . --build-arg CONCRETE5_VERSION=$C5_VERSION
