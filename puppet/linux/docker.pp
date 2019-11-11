docker::registry { 'https://index.docker.io/v2/':
  username => $dockerhub_user,
  password => $dockerhu_password,
}