package { 'ubuntu-desktop':
  ensure => installed,
}
-> ini_setting { "Enable automatic logig":
  ensure  => present,
  path    => '/etc/gdm3/custom.conf',
  section => 'daemon',
  setting => 'AutomaticLoginEnable',
  value   => 'True',
}
-> ini_setting { "Auto login vagrant user":
  ensure  => present,
  path    => '/etc/gdm3/custom.conf',
  section => 'daemon',
  setting => 'AutomaticLogin',
  value   => 'vagrant',
}

