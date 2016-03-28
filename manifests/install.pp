# == Class puppet-aspnet::install
#
# This class is called from puppet-aspnet for install.
#
class puppet-aspnet::install {

  package { $::puppet-aspnet::package_name:
    ensure => present,
  }
}
