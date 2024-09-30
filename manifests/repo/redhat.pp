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

  contain '::apt'

  $_flavour = downcase($flavour)

  yumrepo { 'fluentbit':
    ensure    => 'present',
    name      => 'fluentbit',
    descr     => 'Official Treasure Data repository for Fluent-Bit',
    baseurl   => 'https://packages.fluentbit.io/${_flavour}/${release}',
    gpgkey    => $fluentbit::repo_key_location,
    enabled   => '1',
    gpgcheck  => '1',
    target    => '/etc/yum.repo.d/fluentbit.repo',
  }
}
