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
      warning 'Graphite web is currently not supported on Debian ... yet'
    }
    default: {
      warning "Graphite web is currently not supported on Your OS ${::operatingsystem}"
    }
  }
}
