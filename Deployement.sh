#!/bin/bash
#File by mpsv
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
     https://github.com/manojpsingh21/my_docker.git
     cp ./my_docker/AutoStartSystem.sh ./my_docker/.bashrc ./my_docker/.License.ini ./my_docker/rupeeseed.env  ./my_docker/entrypoint_master.sh ./my_linux/
     cp ./my_docker/init.sql ./my_docker/my.cnf ./my_docker/sshd_config ./configs/
     mv ./my_docker_test/docker-compose.yaml ./
     cp  ./my_docker_test/libmysqlclient.so.18  ./my_linux/
     mv ./my_docker/StartSystem.sh ./my_linux/Application/Exec/ShellScripts/StartSystem.sh
     mv ./my_docker/WebAdaptor ./my_linux/Application/Exec/Run/
     mv ./my_docker/sysctl.conf ./configs/
     mv ./dump.rdb ./my_redis_data/
     rm ./my_docker/libmysqlclient.so.18
    else
     echo "Please pass correct initialization_type value"
    fi
fi

if [ "$flag" -eq 1 ]; then
    echo "Flag is 1, performing the action..."
    docker compose up my_db -d
    echo "Action performed.DB is UP..Please import the backup.."
else
    echo "Flag is not 1, no action taken."
    docker compose up -d
fi

