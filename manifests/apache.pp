package { ['php5', 'apache2', 'git-core']:
    ensure => installed,
}

exec  {'apache_stop':
	path => '/usr/bin',
	command => 'service apache2 stop',
	require => Package['apache2'],
}

file {'/etc/apache2/sites-enabled/000-default':
	source  => '/vagrant/apache/etc/apache2/sites-enabled/000-default',
	ensure => 'present',
	owner   => 'root',
	group   => 'root',
	mode    => '777',
	require => Exec['apache_stop'],
	notify  => File['/etc/apache2/mods-enabled/rewrite.load'],
}

file {'/etc/apache2/mods-enabled/rewrite.load':
	source  => '/etc/apache2/mods-available/rewrite.load',
	ensure => 'present',
	owner   => 'root',
	group   => 'root',
	mode    => '777',
	require => Exec['apache_stop'],
	notify  => Exec['apache_start'],
}

exec  {'apache_start':
	path => '/usr/bin',
	command => 'service apache2 start',
}
