docker::image { 'docker.bintray.io/jfrog/artifactory-pro':
  image_tag => 'latest'
}
-> docker::run { 'artifactory':
  image => 'docker.bintray.io/jfrog/artifactory-pro:latest',
  env   => ['EXTRA_JAVA_OPTIONS=-Xms384m -Xmx768m'],
  ports => ['8041:8081'],
  net   => 'octopus'
}

file { '/opt/settings.xml':
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