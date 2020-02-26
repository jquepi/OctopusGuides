exec { "add dkms":
  command => "/usr/bin/apt-get update; /usr/bin/apt-get install module-assistant build-essential dkms linux-headers-$(uname -r) -y",
  timeout => 3600
}
-> exec { "add virtualbox x11 driver":
  command => "/usr/bin/apt-get install -y -o Dpkg::Options::='--force-confnew' virtualbox-guest-x11",
}
-> exec { "apt-update":
  command => "/usr/bin/apt-get update; /usr/bin/apt-get upgrade -y; /usr/bin/apt-get dist-upgrade -y",
  timeout => 3600
}
# The vboxadd-service fails to run, and is unnecessary anyway because the vboxadd (without the "-service") service does what we need to do.
# https://www.reddit.com/r/virtualbox/comments/abq2bf/extremely_slow_startstop_jobs_for_vboxaddservice/
-> exec { "Disable the existing virtualbox service":
  command => "/bin/systemctl disable vboxadd-service",
  onlyif => "/usr/bin/test -f /lib/systemd/system/vboxadd-service.service"
}