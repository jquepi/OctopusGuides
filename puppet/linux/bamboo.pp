archive { '/opt/bamboo.jar':
  ensure         => present,
  extract        => false,
  source         => 'https://octopus-guides.s3.amazonaws.com/bamboo/bamboo.jar',
  allow_insecure => true
}

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
package { 'atlassian-plugin-sdk':
  provider => dpkg,
  ensure   => installed,
  source   =>
    "https://packages.atlassian.com/atlassian-sdk-deb/debian/pool/contrib/a/atlassian-plugin-sdk/atlassian-plugin-sdk_8.0.16_all.deb"
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
    ExecStart=/usr/bin/atlas-run-standalone --product bamboo
    Environment=DOTNET_CLI_HOME=/root
    | EOT
}
-> service { 'bamboo':
  ensure => running,
  enable => true
}