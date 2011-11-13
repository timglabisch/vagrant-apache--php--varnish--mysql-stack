package { ['varnish']:
    ensure => installed,
}

file {'/etc/varnish/default.vcl':
	source  => '/vagrant/varnish/etc/varnish/default.vcl',
	ensure => 'present',
	owner   => 'root',
	group   => 'root',
	mode    => '700',
	require => Package['varnish'],
}

exec { "varnish_start":
	path => ["/bin", "/usr/bin"],
	cwd => "/vagrant/varnish",
	command => "sh start.sh",
	require => File['/etc/varnish/default.vcl'],
}