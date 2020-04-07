#!/bin/bash

serverUrl="http://localhost"       # The url of your Octous server
serverCommsPort=10943               # The communication port the Octopus Server is listening on (10943 by default)
apiKey=`cat /tmp/api_key.txt`       # An Octopus Server api key with permission to add machines
name=$HOSTNAME                      # The name of the Tentacle at is will appear in the Octopus portal
workerPool="Default Worker Pool"    # The worker pool to register the Tentacle in
configFilePath="/etc/octopus/default/tentacle-default.config"
applicationPath="/home/Octopus/Applications/"

# grab a backup copy of the key to prevent these errors:
# GPG error: https://apt.octopus.com stretch Release: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 896C79DABCE1F8D1
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 896C79DABCE1F8D1
apt-key adv --fetch-keys https://apt.octopus.com/public.key
add-apt-repository "deb https://apt.octopus.com/ stretch main"
apt-get update
apt-get install tentacle

/opt/octopus/tentacle/Tentacle create-instance --config "$configFilePath"
/opt/octopus/tentacle/Tentacle new-certificate --if-blank
/opt/octopus/tentacle/Tentacle configure --noListen True --reset-trust --app "$applicationPath"
echo "Registering the worker $name with server $serverUrl in the worker pool $workerPool"
/opt/octopus/tentacle/Tentacle register-worker --server "$serverUrl" --apiKey "$apiKey" --name "$name" --workerPool "$workerPool" --comms-style "TentacleActive" --server-comms-port $serverCommsPort
/opt/octopus/tentacle/Tentacle service --install --start