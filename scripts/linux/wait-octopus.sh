attempt_counter=0
max_attempts=120

echo "Waiting for the Octopus server"

until $(curl --max-time 5 --output /dev/null --silent --head --fail http://localhost); do
    if [ ${attempt_counter} -eq ${max_attempts} ];then
      echo "Max attempts reached"
      docker logs octopusdeploy
      exit 1
    fi

    printf 'Sleeping...'
    attempt_counter=$(($attempt_counter+1))
    sleep 5
done

exit 0