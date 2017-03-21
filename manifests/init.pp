# Configures pe-activemq to mount the Jolokia API
#
# When the enable_web_console parameter is set to true,
# this API will be available via a webserver listening
# on localhost with a default username/password:
#
#   curl -u admin:admin http://127.0.0.1:8161/api/jolokia/version
class pe_activemq_jolokia {

  File {
    owner  => 'pe-activemq',
    group  => 'pe-activemq',
    mode   => '0600',
  }

  file {'/etc/puppetlabs/activemq/jetty.xml':
    ensure => file,
    source => 'puppet:///modules/pe_activemq_jolokia/jetty.xml',
    notify => Service['pe-activemq'],
  }

  file {'/etc/puppetlabs/activemq/jetty-realm.properties':
    ensure => file,
  }

  file {'/etc/puppetlabs/activemq/jolokia-access.xml':
    ensure => file,
    source => 'puppet:///modules/pe_activemq_jolokia/jolokia-access.xml',
    notify => Service['pe-activemq'],
  }

  file {'/opt/puppetlabs/server/apps/activemq/webapps/api':
    ensure => directory,
  } ->
  file {'/opt/puppetlabs/server/apps/activemq/webapps/api/WEB-INF':
    ensure => directory,
  } ->
  file {'/opt/puppetlabs/server/apps/activemq/webapps/api/WEB-INF/web.xml':
    ensure => file,
    source => 'puppet:///modules/pe_activemq_jolokia/web.xml',
    notify => Service['pe-activemq'],
  }

}
