exec { "add dkms":
  command => "/usr/bin/apt-get update; /usr/bin/apt-get install build-essential module-assistant virtualbox-guest-utils virtualbox-guest-dkms dkms linux-headers-$(uname -r) -y",
  timeout => 3600
}
-> exec { "add virtualbox x11 driver":
  command => "/usr/bin/apt-get install -y -o Dpkg::Options::='--force-confnew' virtualbox-guest-x11",
}
# -o Dpkg::Options::='--force-confnew' is used to retain the changes to the resolved.conf file
-> exec { "apt-update":
  command => "/usr/bin/apt-get update; /usr/bin/apt-get upgrade -y; /usr/bin/apt-get dist-upgrade -y -o Dpkg::Options::='--force-confold'",
  timeout => 3600
}
-> exec { "Disable the existing virtualbox service":
  command => "/bin/systemctl disable vboxadd-service; /bin/systemctl disable vboxadd;",
  onlyif => "/usr/bin/test -f /lib/systemd/system/vboxadd-service.service"
}

file_line { 'Disable crash reporting':
  path    => '/etc/default/apport',
  line    => 'enabled=0',
  match   => 'enabled=1',
  replace => true
}