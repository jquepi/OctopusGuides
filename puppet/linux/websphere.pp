user { 'websphere':
  ensure => present,
}
-> archive { '/opt/wlp-javaee8-20.0.0.5.zip':
  ensure          => present,
  extract         => true,
  extract_path    => '/opt',
  source          => 'https://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/wasdev/downloads/wlp/20.0.0.5/wlp-javaee8-20.0.0.5.zip',
  creates         => '/opt/wlp/README.txt',
  cleanup         => true
}
-> exec { "fix permissions":
  command   => "/bin/chown -R websphere:websphere /opt/wlp",
  logoutput => true,
  timeout   => 3600
}
-> file { '/lib/systemd/system/websphere.service':
  ensure  => 'file',
  owner   => 'root',
  group   => 'root',
  mode    => '0755',
  content => @(EOT)
    [Unit]
    Description=websphere
    [Service]
    ExecStart=/opt/wlp/bin/server start
    ExecStop=/opt/wlp/bin/server stop
    User=websphere
    Type=forking
    Restart = always
    [Install]
    WantedBy=multi-user.target
    | EOT
}
-> exec { 'Reload daemon':
  command   => '/bin/systemctl daemon-reload',
  logoutput => true
}
-> service { 'websphere':
  ensure => 'running',
  enable => true,
}