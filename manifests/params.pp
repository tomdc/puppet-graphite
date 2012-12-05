# = Class: graphite::params
#
# Params class for graphite
#
#
#
class graphite::params (
  $time_zone = 'UTC',
  $manage_httpd = false
) {

  $carbon = $::operatingsystem ? {
    /(?i)(redhat|centos)/      =>  'carbon',
    /(?i)(ubuntu|debian)/      =>  'graphite-carbon',
    default                    =>  'carbon'
  }

  $carbonservice = $::operatingsystem ? {
    /(?i)(redhat|centos)/   =>  'carbon-cache',
    /(?i)(ubuntu|debian)/   =>  'carbon-cache',
    default                 =>  'carbon-cache'
  }

  $whisper = $::operatingsystem ? {
    /(?i)(redhat|centos)/   =>  'whisper',
    /(?i)(ubuntu|debian)/   =>  'python-whisper',
    default                 =>  'whisper'
  }

}
