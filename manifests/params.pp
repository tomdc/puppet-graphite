# = Class: graphite::params
#
# Params class for graphite
#
#
#
class graphite::params {

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

  $graphiteweb = $::operatingsystem ? {
    /(?i)(redhat|centos)/   =>  'graphite-web',
    /(?i)(ubuntu|debian)/   =>  'python2.7-graphite-web',
    default                 =>  'graphite-web'
  }

}
