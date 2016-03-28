# Class: puppet-aspnet
# ===========================
#
# Full description of class puppet-aspnet here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class puppet-aspnet (
  $package_name = $::puppet-aspnet::params::package_name,
  $service_name = $::puppet-aspnet::params::service_name,
) inherits ::puppet-aspnet::params {

  # validate parameters here

  class { '::puppet-aspnet::install': } ->
  class { '::puppet-aspnet::config': } ~>
  class { '::puppet-aspnet::service': }

  contain '::puppet-aspnet::install'
  contain '::puppet-aspnet::config'
}
