attempt_counter=0
max_attempts=5

echo "Waiting for the Octopus server"

until $(curl --max-time 5 --output /dev/null --silent --head --fail http://localhost); do
    if [ ${attempt_counter} -eq ${max_attempts} ];then
      echo "Max attempts reached"
      docker logs octopusdeploy
      docker logs mssql
      journalctl -u docker-octopusdeploy.service
      journalctl -u docker-mssql.service
      exit 1
    fi

    printf 'Resetting the Octopus Server and Database...'
    attempt_counter=$(($attempt_counter+1))

    # The database sometimes fails us, so do a hard reset of the database container
    systemctl stop docker-octopusdeploy
    systemctl stop docker-mssql
    docker stop mssql
    docker rm mssql
    docker stop octopusdeploy
    docker rm octopusdeploy
    systemctl start docker-mssql
    systemctl start docker-octopusdeploy
    sleep 120
done

exit 0