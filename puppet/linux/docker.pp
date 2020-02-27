package { 'docker.io':
  ensure => installed,
}
# There have been cases where docker shuts down (https://github.com/docker/for-linux/issues/742)
# and won't be restarted by systemd. Increasing the RestartSec and StartLimitBurst gives
# systemd more chances of restarting the service.
-> file_line { 'Increase docker restart delay':
  path    => '/lib/systemd/system/docker.service',
  line    => 'RestartSec=30',
  match   => 'RestartSec=\d+',
  replace => true,
}
-> file_line { 'Increase docker restart delay':
  path    => '/lib/systemd/system/docker.service',
  line    => 'StartLimitBurst=10',
  match   => 'StartLimitBurst=\d+',
  replace => true,
}