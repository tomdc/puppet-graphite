# = Class: graphite
#
# This module manages graphite.
# Debian pkg used was created via: https://github.com/jbraeuer/graphite-debs
#
# On Debian, do not forget to enable carbon-cache in /etc/default/graphite-carbon
# CARBON_CACHE_ENABLED=true
#
# == Sample Usage:
#
#   include graphite
#
# == Todo:
#
# * Implement user creation.
#
class graphite ( $vhostname = $::fqdn, $time_zone = 'UTC' , $manage_httpd = false ) {

  include graphite::carbon
  include graphite::whisper

  case $::operatingsystem {
    centos, redhat: {
      class {
        'graphite::web':
          manage_httpd =>  $manage_httpd
      }
    }
    debian, ubuntu: {
      class {
        'graphite::web::debian':
          vhostname    =>  $vhostname,
          time_zone    =>  $time_zone,
          manage_httpd =>  $manage_httpd,
      }
    }
    default: {
      warning "Graphite web is currently not supported on Your OS ${::operatingsystem}"
    }
  }
}
