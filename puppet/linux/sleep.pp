exec { "sleep for 5 mins":
  command => "/bin/sleep 300",
  timeout => 600
}