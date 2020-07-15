user { 'payara':
  ensure => present,
}
-> archive { '/opt/payara-5.2020.2.zip':
  ensure          => present,
  extract         => true,
  extract_path    => '/opt',
  source          => 'https://octopus-guides.s3.amazonaws.com/payara/payara-5.2020.2.zip',
  creates         => '/opt/payara5/README.txt',
  cleanup         => true
}
-> file_line { 'Configure HTTP port':
  path    => '/opt/payara5/glassfish/domains/domain1/config/domain.xml',
  line    => '                    <network-listener port="9092" protocol="http-listener-1" transport="tcp" name="http-listener-1"',
  match   => '                    <network-listener port="8080" protocol="http-listener-1" transport="tcp" name="http-listener-1"',
  replace => true,
}
-> file { '/opt/payara5/glassfish/domains/domain1/autodeploy':
  ensure => 'directory'
}
-> exec { "fix permissions":
  command   => "/bin/chown -R payara:payara /opt/payara5",
  logoutput => true,
  timeout   => 3600
}
-> file { '/lib/systemd/system/payara.service':
  ensure  => 'file',
  owner   => 'root',
  group   => 'root',
  mode    => '0755',
  content => @(EOT)
    [Unit]
    Description=payara
    [Service]
    ExecStart=/opt/payara5/bin/asadmin start-domain domain1
    ExecStop=/opt/payara5/bin/asadmin stop-domains domain1
    Environment="SPRING_CONFIG_NAME=deployed-application"
    User=payara
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
-> service { 'payara':
  ensure => 'running',
  enable => true,
}