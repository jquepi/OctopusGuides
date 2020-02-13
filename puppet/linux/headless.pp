include apt

package { 'fluxbox':
  ensure => installed,
}
-> file { '/root/.fluxbox':
  ensure => 'directory'
}
-> file { '/root/.fluxbox/init':
  ensure  => 'file',
  owner   => 'root',
  group   => 'root',
  mode    => '0755',
  content => @(EOT)
    session.screen0.toolbar.visible: false
    | EOT
}
-> package { 'xcompmgr':
  ensure => installed,
}
-> package { 'xvfb':
  ensure => installed,
}
-> exec { 'Run xvfb':
  command   => '/usr/bin/Xvfb :99 -screen 0 1920x1080x24 &',
  logoutput => true
}
-> exec { 'Run composite manager':
  command   => '/usr/bin/xcompmgr -d :99 &',
  logoutput => true
}
-> exec { 'Run fluxbox':
  command   => '/usr/bin/fluxbox &',
  logoutput => true
}