include chocolatey

class octopus::install inherits octopus {
  package { 'sql-server-express':
    ensure   => installed,
    provider => chocolatey
  }
  -> package { 'octopusdeploy':
    ensure   => installed,
    provider => chocolatey
  }
}