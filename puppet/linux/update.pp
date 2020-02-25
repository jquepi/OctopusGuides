exec { "add dkms":
  command => "/usr/bin/apt-get update; /usr/bin/apt-get install build-essential dkms linux-headers-$(uname -r) -y",
  timeout => 3600
}
-> exec { "add dkms":
  command => "apt-get install -y -o Dpkg::Options::='--force-confnew' virtualbox-guest-x11",
}
-> exec { "apt-update":
  command => "/usr/bin/apt-get update; /usr/bin/apt-get upgrade -y; /usr/bin/apt-get dist-upgrade -y",
  timeout => 3600
}