exec { "Download the laest version of the web driver tool":
  command => "/usr/bin/curl https://octopus-guides.s3.amazonaws.com/webdrivertraining.1.0-SNAPSHOT.jar -o /opt webdrivertraining.1.0-SNAPSHOT.jar",
}