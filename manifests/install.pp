# @summary Installs fluentbit package
#
# @private
class fluentbit::install {
  assert_private()

  package{ 'fluentbit':
    ensure => $fluentbit::package_ensure,
    name   => $fluentbit::package_name,
  }
  ->  file { '/usr/local/bin/fluent-bit':
    ensure => 'link',
    target => '/opt/fluent-bit/bin/fluent-bit',
  }
}
