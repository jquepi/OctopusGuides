# https://askubuntu.com/questions/972215/a-start-job-is-running-for-wait-for-network-to-be-configured-ubuntu-server-17-1
file_line { 'Only expect the first adapter to get an address':
  path    => '/lib/systemd/system/systemd-networkd-wait-online.service',
  line    => 'ExecStart=/lib/systemd/systemd-networkd-wait-online --interface=eth0 --quiet',
  match   => 'ExecStart=/lib/systemd/systemd-networkd-wait-online',
  replace => true,
}