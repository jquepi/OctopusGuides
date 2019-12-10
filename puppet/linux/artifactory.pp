archive { '/opt/jfrog-artifactory-oss-6.15.0.zip':
  ensure       => present,
  extract      => true,
  extract_path => '/opt',
  source       => 'https://octopus-guides.s3.amazonaws.com/artifactory/jfrog-artifactory-pro-6.15.0.zip',
  creates      => '/opt/artifactory-pro-6.15.0/README.txt',
  cleanup      => true,
}
# Change the repo port to 8041 to avoid a conflict with the IIS ports that have been used to deploy apps
-> file_line { 'Artifactory Port Settings':
  path    => '/opt/artifactory-pro-6.15.0/tomcat/conf/server.xml',
  line    =>
    '        <Connector port="8041" sendReasonPhrase="true" relaxedPathChars=\'[]\' relaxedQueryChars=\'[]\' maxThreads="200"/>'
  ,
  match   =>
    '^\s*<Connector port="8081" sendReasonPhrase="true" relaxedPathChars=\'\[\]\' relaxedQueryChars=\'\[\]\' maxThreads="200"/>'
  ,
  replace => true,
}
# Reduce the memory that Artifactory can consume
-> file_line { 'Artifactory Memory Settings':
  path    => '/opt/artifactory-pro-6.15.0/bin/artifactory.bat',
  line    => 'set JAVA_OPTIONS=-server -Xms384m -Xmx768m -Xss256k -XX:+UseG1GC',
  match   => 'set JAVA_OPTIONS=-server -Xms512m -Xmx4g -Xss256k -XX:\+UseG1GC',
  replace => true,
}
-> file { '/opt/install_artifactory.sh':
  ensure  => 'file',
  owner   => 'root',
  group   => 'root',
  mode    => '0755',
  content => @(EOT)
    chmod +x /opt/artifactory-pro-6.15.0/bin/artifactory.sh
    /opt/artifactory-pro-6.15.0/bin/artifactory.sh &
    touch /opt/ArtifactoryStarted.txt
    df -h
    | EOT
}
-> exec { 'Install Artifactory':
  command   => '/opt/install_artifactory.sh',
  creates   => '/opt/ArtifactoryStarted.txt',
  timeout   => 3600,
  logoutput => true
}

file { '/root/.m2/settings.xml':
  ensure  => 'file',
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  content => @(EOT)
    <settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
      <servers>
          <server>
            <id>artifactory</id>
            <username>admin</username>
            <password>password</password>
          </server>
          <server>
            <id>artifactorysnapshots</id>
            <username>admin</username>
            <password>password</password>
          </server>
        </servers>
    </settings>
    | EOT
}