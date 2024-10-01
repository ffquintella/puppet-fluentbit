# @summary Manage the configuration of a HTTP output plugin.
#
# The http output plugin allows to flush your records into a HTTP endpoint.
# This type manages the configuration for it.
#
# @param configfile
#  Path to the output configfile. Naming should be output_*.conf to make sure
#  it's getting included by the main config.
#
# @param match
#  Tag to route the output.
#
# @param tls
#   TLS configuration. By default TLS is disabled.
#
# @param host
#   IP address or hostname of the target HTTP Server.
#
# @param port
#   TCP port of the target HTTP Server.
#
# @param http_user
#   Basic Auth Username.
#
# @param http_passwd
#   Basic Auth Password.
#   Requires HTTP_User to be set.
#
# @param splunk_token
#   Splunk auth token.
#
# @example
#   fluentbit::output::http { 'logstash': }
define fluentbit::output::splunk (
  Stdlib::Absolutepath $configfile            = "/etc/fluent-bit/output_splunk_${name}.conf",
  Fluentbit::TLS $tls                         = {},
  Optional[String[1]] $match                  = undef,
  Optional[Stdlib::Host] $host                = undef,
  Optional[Stdlib::Port] $port                = undef,
  Optional[String[1]] $http_user              = undef,
  Optional[String[1]] $http_passwd            = undef,
  Optional[String[1]] $splunk_token           = undef,
) {
  $tls_enabled = $tls['enabled'] ? {
    undef   => undef,
    default => bool2str($tls['enabled'], 'On', 'Off'),
  }
  $tls_verify = $tls['verify'] ? {
    undef   => undef,
    default => bool2str($tls['verify'], 'On', 'Off'),
  }
  $tls_debug = $tls['debug'] ? {
    undef   => undef,
    default => bool2str($tls['debug'], 'On', 'Off'),
  }
  $tls_ca_file = $tls['ca_file']
  $tls_ca_path = $tls['ca_path']
  $tls_crt_file = $tls['crt_file']
  $tls_key_file = $tls['key_file']
  $tls_key_passwd = $tls['key_passwd']

  file { $configfile:
    ensure  => file,
    mode    => $fluentbit::config_file_mode,
    content => template('fluentbit/output/splunk.conf.erb'),
    notify  => Class['fluentbit::service'],
  }
}
