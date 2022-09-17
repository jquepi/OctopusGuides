file_line { 'systemd timeout':
  path    => '/etc/systemd/system.conf',
  line    => 'DefaultTimeoutStartSec=600s',
  match   => '#DefaultTimeoutStartSec=90s',
  replace => true
}
exec { 'reload config':
  command   => '/bin/systemctl daemon-reexec',
  logoutput => true
}