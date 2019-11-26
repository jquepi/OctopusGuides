exec {"wait for bamboo":
  command => "max=30; while ! wget --spider http://localhost:6990/bamboo > /dev/null 2>&1; do max=$(( max - 1 )); [ $max -lt 0 ] && break; echo 'Sleeping';  sleep 10; done;",
}