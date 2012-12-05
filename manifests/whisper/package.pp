# Class: graphitea::whisper::package
#
# This class install the whisper package
#
class graphite::whisper::package {

require graphite::params

package { $graphite::params::whisper:
  ensure => present;
}
}
