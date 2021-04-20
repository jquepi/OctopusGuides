file { '/opt/wait_for_bamboo.sh':
  ensure  => 'file',
  owner   => 'root',
  group   => 'root',
  mode    => '0755',
  content => @(EOT)
    #!/bin/bash
    max=120;
    while [[ \"$(curl --max-time 5 -s -o /dev/null -w ''%{http_code}'' http://localhost:6990/bamboo/)\" != \"200\" ]]; do
      max=$(( max - 1 ));
      [ $max -lt 0 ] && break;
      echo "sleeping";
      sleep 10;
    done;

    echo "$max sleeps ignored"

    journalctl -u bamboo.service

    exit 0
    | EOT
}
-> exec { "wait for bamboo":
  command   => "/opt/wait_for_bamboo.sh",
  logoutput => true,
  timeout   => 3600
}