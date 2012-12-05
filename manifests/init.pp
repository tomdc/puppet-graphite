# = Class: graphite
#
# This module manages graphite
#
# == Sample Usage:
#
#   include graphite
#
# == Todo:
#
# * Implement user creation.
#
class graphite{

  include graphite::carbon
  include graphite::whisper

  case $::operatingsystem {
    centos, redhat: {
      include graphite::web
    }
    debian, ubuntu: {
      fail 'Debian based systems not supported ... yet'
    }
    default: {
      fail "Your OS ${::operatingsystem} is currently not supported"
    }
  }
}
