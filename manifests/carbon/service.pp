# = Class: graphite::carbon::service
#
# This module manages the carbon service
#
# Change to true, to enable carbon-cache on boot
# CARBON_CACHE_ENABLED=true
#
class graphite::carbon::service {

require graphite::params

service { $graphite::params::carbonservice:
  ensure     => running,
  enable     => true,
  hasrestart => true,
  hasstatus  => true,
  require    => Package[$graphite::params::carbon],
}
}
