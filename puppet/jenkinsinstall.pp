# Install this early, as it takes a few minutes to initilaize
package { 'jenkins':
  ensure   => installed,
  provider => chocolatey
}