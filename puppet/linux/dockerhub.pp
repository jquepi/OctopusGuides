docker::registry {'https://index.docker.io/v1/':
  username => 'octopusguides',
  password => "$::dockerhubpass",
}