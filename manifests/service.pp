# == Class puppet-aspnet::service
#
# This class is meant to be called from puppet-aspnet.
# It ensure the service is running.
#
class puppet-aspnet::service {

  service { $::puppet-aspnet::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
