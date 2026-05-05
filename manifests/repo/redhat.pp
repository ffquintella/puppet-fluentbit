# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fluentbit::repo::redhat
class fluentbit::repo::redhat {
  assert_private()

  $os_version = dig($facts, 'os', 'release', 'major')
  $supported_releases = ['8', '9', '10']

  unless $os_version in $supported_releases {
    fail("RedHat family release ${os_version} is not supported")
  }

  yumrepo { 'fluentbit':
    ensure    => 'present',
    name      => 'fluentbit',
    descr     => 'Official Treasure Data repository for Fluent-Bit',
    baseurl   => "https://packages.fluentbit.io/centos/${os_version}",
    gpgkey    => 'https://packages.fluentbit.io/fluentbit.key',
    enabled   => '1',
    gpgcheck  => '1',
    target    => '/etc/yum.repos.d/fluentbit.repo',
  }
}
