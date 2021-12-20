archive { '/opt/bamboo.jar':
  ensure         => present,
  extract        => false,
  source         => 'https://octopus-guides.s3.amazonaws.com/bamboo/bamboo.jar'
}

# This file is the result of running "atlas-run-standalone --product bamboo" locally and then
# compressing the ~/.m2/repository directy. This was required because it looks like Atlassian
# has started throtting access to their Maven repo from GitHub Action agents. By prepopulating
# the local Maven repo, we can avoid most of the downloads.
archive { '/opt/repository.7z':
  ensure         => present,
  extract        => false,
  source         => 'https://octopus-guides.s3.amazonaws.com/maven/repository.7z'
}
-> package { 'p7zip-full':
  ensure => installed,
}
-> package { 'p7zip-rar':
  ensure => installed,
}
-> file { '/github/home/.m2':
  ensure => 'directory'
}
-> exec { "extract local maven repo":
  command   => "/usr/bin/7z x -o/github/home/.m2 -y /opt/repository2.7z || true",
  logoutput => true,
  timeout   => 3600
}

# Using the repo dorectly started to result in Unknown date format Bad header data:
# https://community.developer.atlassian.com/t/the-repository-https-packages-atlassian-com-atlassian-sdk-deb-stable-release-is-not-signed/36901/11
# apt::key { 'atlassian-repository':
#   id     => 'D648E5571A519459EC58F888B56C9565957495B9',
#   source => 'https://packages.atlassian.com/api/gpg/key/public',
#   server  => 'pgp.mit.edu'
# }
# -> apt::source { 'atlassian':
#   comment  => 'This is the atlassian repository',
#   location => 'https://packages.atlassian.com/debian/atlassian-sdk-deb/',
#   release  => '',
#   repos    => 'stable contrib',
#   key      => {
#     'id' => 'D648E5571A519459EC58F888B56C9565957495B9',
#   },
#   include  => {
#     'deb' => true,
#   },
# }
# -> package { 'atlassian-plugin-sdk':
#   ensure => installed,
# }

package { 'libtcnative-1':
  ensure => installed,
}

# Download the deb file manually
archive { '/opt/atlassian-plugin-sdk_8.2.8_all.deb':
  ensure         => present,
  extract        => false,
  source         => 'https://packages.atlassian.com/atlassian-sdk-deb/debian/pool/contrib/a/atlassian-plugin-sdk/atlassian-plugin-sdk_8.2.8_all.deb'
}
-> package { 'atlassian-plugin-sdk':
  provider => dpkg,
  ensure   => installed,
  source   => "/opt/atlassian-plugin-sdk_8.2.8_all.deb"
}
-> file { '/lib/systemd/system/bamboo.service':
  ensure  => 'file',
  owner   => 'root',
  group   => 'root',
  mode    => '0755',
  content => @(EOT)
    [Unit]
    Description=Bamboo

    [Service]
    Restart=always
    RestartSec=5
    StandardInput=tty
    TTYPath=/dev/tty2
    TTYReset=yes
    TTYVHangup=yes
    StandardOutput=journal+console
    StandardError=journal+console
    ExecStart=/usr/bin/atlas-run-standalone --product bamboo
    Environment=DOTNET_CLI_HOME=/root
    | EOT
}
-> service { 'bamboo':
  ensure => running,
  enable => true
}