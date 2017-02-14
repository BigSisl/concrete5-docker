#!/bin/bash

C5_VERSION=8.1.0

# download sourcecode
rm -rf src

git clone -b $C5_VERSION --single-branch https://github.com/concrete5/concrete5.git ./src

# be sure to convert docker-entrypoint & src/concrete/bin/concrete5 on windows to unix
# endings (dos2unix.exe) -> git could be checking out the file wrong

docker-compose up
#docker build . --build-arg CONCRETE5_VERSION=$C5_VERSION -t concrete5/$C5_VERSION
