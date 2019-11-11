docker::registry { 'https://index.docker.io/v2/':
  username => $dockerhub_user,
  password => $dockerhu_password,
}
-> docker::image { 'octopusdeploy/linuxoctopus':
  image_tag => '2019.10.5'
}