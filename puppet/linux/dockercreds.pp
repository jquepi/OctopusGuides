docker::registry { 'https://index.docker.io/v1/':
  username => $dockerhub_user,
  password => $dockerhub_password,
}