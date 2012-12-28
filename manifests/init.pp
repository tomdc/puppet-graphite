# = Class: graphite
#
# This module manages graphite.
# Debian pkg used was created via: https://github.com/jbraeuer/graphite-debs
#
# == Sample Usage:
#
#   include graphite
#
# == Todo:
#
# * Implement user creation.
#
class graphite ( $vhostname = $::fqdn, $time_zone = 'UTC' , $manage_http = false ) {

  include graphite::carbon
  include graphite::whisper

  case $::operatingsystem {
    centos, redhat: {
      class {
        'graphite::web':
          manage_http =>  $manage_http
      }
    }
    debian, ubuntu: {
      class {
        'graphite::web::debian':
          vhostname   =>  $vhostname,
          time_zone   =>  $time_zone,
          manage_http =>  $manage_http,
      }
    }
    default: {
      warning "Graphite web is currently not supported on Your OS ${::operatingsystem}"
    }
  }
}
