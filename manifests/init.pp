# Configures pe-activemq to mount the Jolokia API
#
# When the enable_web_console parameter is set to true,
# this API will be available via a webserver listening
# on localhost with a default username/password:
#
#   curl -u admin:admin http://127.0.0.1:8161/api/jolokia/version
class pe_activemq_jolokia {

  # Use an updated jetty.xml source that enables Jolokia
  File <| title == '/etc/puppetlabs/activemq/jetty.xml' |> {
    source => 'puppet:///modules/pe_activemq_jolokia/jetty.xml',
  }

  # Set up the additional configuration files Jolokia needs
  File {
    ensure => file,
    owner  => 'pe-activemq',
    group  => 'pe-activemq',
    mode   => '0600',
    notify => Service['pe-activemq'],
  }

  file { '/etc/puppetlabs/activemq/jolokia-access.xml':
    source => 'puppet:///modules/pe_activemq_jolokia/jolokia-access.xml',
  }

  file { [ '/opt/puppetlabs/server/apps/activemq/webapps/api',
           '/opt/puppetlabs/server/apps/activemq/webapps/api/WEB-INF' ]:
    ensure => directory,
  }

  file { '/opt/puppetlabs/server/apps/activemq/webapps/api/WEB-INF/web.xml':
    source => 'puppet:///modules/pe_activemq_jolokia/web.xml',
  }

}
