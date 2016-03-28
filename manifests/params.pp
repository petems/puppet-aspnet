# == Class puppet-aspnet::params
#
# This class is meant to be called from puppet-aspnet.
# It sets variables according to platform.
#
class puppet-aspnet::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'puppet-aspnet'
      $service_name = 'puppet-aspnet'
    }
    'RedHat', 'Amazon': {
      $package_name = 'puppet-aspnet'
      $service_name = 'puppet-aspnet'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
