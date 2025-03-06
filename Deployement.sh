#!/bin/bash

EXPECTED_PARAMS=2

if [ $# -ne $EXPECTED_PARAMS ]; then
  echo "Error: You need to provide exactly $EXPECTED_PARAMS parameters."
  echo "Usage: $0 <build_tar_file> <initialization_type>"
  exit 1
fi


build_version=$1
initialization_type=$2


echo Deploying build version ..... $build_version
echo initialization_type     ..... $initialization_type

sleep 2

if [ "$initialization_type" = "DB" ]; then
  echo "As initialization_type is DB initializing only for taking dump."
  flag=1
else
    if [ "$initialization_type" = "A" ]; then
     echo "As initialization_type is A assuming we have already stored data in DB"
     tar -xvf $build_version
     mkdir configs entrypoints my_redis_data mysql_files miscs
     mkdir -p ./webservice_one/WSLogs40/
     cp -r ./WEB/RupeeSeedWS/ ./webservice_one/
     cp -r ./OMS/* ./my_linux/Application/Exec/
     rm -rf WEB/ INCRRMS/ Configure.sh RMS/ OMS/ READ-ME
     git clone https://github.com/manojpsingh21/my_docker_test.git
    else
     echo "Please pass correct initialization_type value"
    fi
fi

