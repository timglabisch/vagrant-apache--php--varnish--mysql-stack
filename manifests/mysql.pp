package { ['mysql-server']:
    ensure => installed,
}

service { "mysql":
	enable => true,
	ensure => running,
	require => Package["mysql-server"],
	subscribe => File['/etc/mysql/my.cnf'],
	hasrestart => true,
}

file {'/etc/mysql/my.cnf':
	source  => '/vagrant/mysql/etc/mysql/my.cnf',
	ensure => 'present',
	owner   => 'root',
	group   => 'root',
	mode    => '700',
	require => Package['mysql-server'],
}

exec { "set-create-user":
	unless => "mysqladmin -uroot -pvagrant status",
	path => ["/bin", "/usr/bin"],
	command => "mysqladmin -uroot password vagrant",
	require => Service["mysql"],
}

exec { "create_db_and_user":
  unless => "/usr/bin/mysql -uroot -pvagrant proj",
  command => "/usr/bin/mysql -uroot -pvagrant -e \"create database proj DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci; grant all on proj.* to vagrant identified by 'vagrant';\"",
  require => Exec["set-create-user"],
}