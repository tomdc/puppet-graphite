# = Class: graphite::web
#
# Installs the graphite webfontend.
#
# == Actions:
#
# Installs packages for graphite web frontend.
#
# == Requires:
#
# Running web server.
#
# == Todo:
#
# * Update documentation
#
class graphite::web (
  $vhostname    = $::graphite::vhostname,
  $time_zone    = $::graphite::time_zone,
  $manage_http  = $::graphite::manage_http
  )
  inherits graphite
  {

  require graphite::params
  include graphite::web::package

  class {'graphite::web::config':
    time_zone => $time_zone,
  }
  if $manage_httpd {
    include graphite::web::service
  }
}
