user { 'wildfly':
  ensure => present,
}
-> file { '/opt/wildfly':
  ensure => 'directory',
  owner   => 'wildfly',
  group   => 'wildfly'
}
-> archive { '/opt/wildfly-19.0.0.Final.tar.gz':
  ensure          => present,
  extract         => true,
  extract_path    => '/opt/wildfly',
  source          => 'https://download.jboss.org/wildfly/19.0.0.Final/wildfly-19.0.0.Final.tar.gz',
  creates         => '/opt/wildfly/README.txt',
  cleanup         => true,
  extract_command => 'tar xfz %s --strip-components=1'
}
-> exec { "fix permissions":
  command   => "/bin/chown -R wildfly:wildfly /opt/wildfly",
  logoutput => true,
  timeout   => 3600
}
-> file { '/etc/systemd/system/wildfly.service':
  ensure => present,
  source => "/opt/wildfly/docs/contrib/scripts/systemd/wildfly.service",
}
-> file_line { 'Define config name':
  path    => '/etc/systemd/system/wildfly.service',
  line    => 'Environment="SPRING_CONFIG_NAME=deployed-application"',
  after   => 'Environment=LAUNCH_JBOSS_IN_BACKGROUND=1'
}
-> file { '/etc/wildfly':
  ensure => 'directory'
}
-> file { '/etc/wildfly/wildfly.conf':
  ensure => present,
  source => "/opt/wildfly/docs/contrib/scripts/systemd/wildfly.conf",
}
-> file { '/opt/wildfly/bin/launch.sh':
  ensure => present,
  mode   => '0755',
  source => "/opt/wildfly/docs/contrib/scripts/systemd/launch.sh",
}
-> exec { 'Reload daemon':
  command   => '/bin/systemctl daemon-reload',
  logoutput => true
}
-> file_line { 'Configure HTTP port':
  path    => '/opt/wildfly/standalone/configuration/standalone.xml',
  line    => '        <socket-binding name="http" port="${jboss.http.port:7070}"/>',
  match   => '\s*<socket-binding name="http" port="\${jboss.http.port:8080}"/>',
  replace => true,
}
-> file_line { 'Configure HTTPS port':
  path    => '/opt/wildfly/standalone/configuration/standalone.xml',
  line    => '        <socket-binding name="https" port="${jboss.https.port:7443}"/>',
  match   => '\s*<socket-binding name="https" port="\${jboss.https.port:8443}"/>',
  replace => true,
}
-> exec { "add management user":
  command   => "/opt/wildfly/bin/add-user.sh admin Password01!",
  logoutput => true
}
-> file_line { 'Increase memory':
  path    => '/opt/wildfly/bin/standalone.conf',
  line    => '   JAVA_OPTS="-Xms64m -Xmx512m -XX:MetaspaceSize=96M -XX:MaxMetaspaceSize=512m -Djava.net.preferIPv4Stack=true"',
  match   => '\s*JAVA_OPTS="-Xms64m -Xmx512m -XX:MetaspaceSize=96M -XX:MaxMetaspaceSize=256m -Djava.net.preferIPv4Stack=true"',
  replace => true,
}
-> service { 'wildfly':
  ensure => 'running',
  enable => true,
}