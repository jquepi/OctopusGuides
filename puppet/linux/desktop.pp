package { 'ubuntu-desktop':
  ensure => installed,
}
-> ini_setting { "sample setting":
  ensure  => present,
  path    => '/etc/gdm3/custom.conf',
  section => 'daemon',
  setting => 'AutomaticLoginEnable',
  value   => 'True',
}
-> ini_setting { "sample setting":
  ensure  => present,
  path    => '/etc/gdm3/custom.conf',
  section => 'daemon',
  setting => 'AutomaticLogin',
  value   => 'vagrant',
}