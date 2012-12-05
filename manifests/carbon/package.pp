# Class: graphite
#
# This class installs the carbon package
#
class graphite::carbon::package {

  require graphite::params

  package { $graphite::params::carbon:
    ensure  =>  present;
  }
}
