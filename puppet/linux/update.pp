exec { "apt-update":
  command => "/usr/bin/apt-get update; /usr/bin/apt-get upgrade -y"
}