exec {"wait for bamboo":
  command => "max=30; while [[ \"$(curl -s -o /dev/null -w ''%{http_code}'' http://localhost:6990/bamboo/)\" != \"200\" ]]; do max=$(( max - 1 )); [ $max -lt 0 ] && break; echo 'Sleeping';  sleep 10; done;",
}