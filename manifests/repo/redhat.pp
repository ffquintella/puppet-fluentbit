# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fluentbit::repo::redhat
class fluentbit::repo::redhat {
  assert_private()

  $flavour = dig($facts, 'os', 'distro', 'id')
  $release = dig($facts, 'os', 'distro', 'codename')
  $os_version = dig($facts, 'os', 'release', 'major')
  $supported = $flavour ? {
    'Ol' => [
      'Ootpa',
      'Plow',
    ],
    default => [],
  }

  unless $release in $supported {
    fail("OS ${flavour}/${release} is not supported")
  }

  $_flavour = downcase($flavour)

  yumrepo { 'fluentbit':
    ensure    => 'present',
    name      => 'fluentbit',
    descr     => 'Official Treasure Data repository for Fluent-Bit',
    baseurl   => "https://packages.fluentbit.io/centos/${os_version}",
    gpgkey    => https://packages.fluentbit.io/fluentbit.key,
    enabled   => '1',
    gpgcheck  => '1',
    target    => '/etc/yum.repo.d/fluentbit.repo',
  }
}
