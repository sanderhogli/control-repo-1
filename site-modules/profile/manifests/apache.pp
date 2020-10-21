class profile::apache {

	class { 'apache':
	#default_vhost => false,
	}

	#apache::vhost { $::fqdn:
	#  port    => '80',
	#  docroot => '/var/www/vhost',
	#}
}