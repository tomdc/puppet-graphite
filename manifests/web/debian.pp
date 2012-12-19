#
# Class graphite::web::debian
#
# Debian Graphite web config
#
# TODO
# webapp/graphite/local_settings.py: set the correct storage path used by
# the debian carbon pkg: /var/lib/graphite
# also users may vary: _graphite
#
class graphite::web::debian ( $vhostname, $timezone, $manage_http ) {

	require graphite::params

	# still needed:
	# Make /opt/graphite/storage/ writable for www-data

	# install pkg
	package {
		$graphite::params::graphiteweb:
			ensure		=>	installed;
		'libapache2-mod-wsgi':
	     ensure    =>  installed;
	}

	# set a local_settings.py with timezone as a var
	file {
		'/opt/graphite/webapp/graphite/local_settings.py':
			ensure		=>	present,
			require		=>	Package[$graphite::params::graphiteweb],
			content		=>	template('graphite/local_settings.py.erb'),
	}

	# initialize DB
	exec {
		'python /opt/graphite/webapp/graphite/manage.py syncdb --noinput':
			require	=>	File['/opt/graphite/webapp/graphite/local_settings.py'],
			cwd			=>	'/opt/graphite/webapp/graphite/',
			path		=>	["/usr/bin", "/usr/sbin"],
			unless	=>	'/usr/bin/test -f /opt/graphite/storage/graphite.db'
	}

	# check owner sqlite db
	file {
		'/opt/graphite/storage/graphite.db':
			require	=>	Exec['python /opt/graphite/webapp/graphite/manage.py syncdb --noinput'],
			owner		=>	www-data,
			mode		=>	'0750',
	}

	# put the apache vhost in place if manage http is set
	if $manage_http {

		# put vhost in place
		file {
			'/etc/apache2/sites-available/graphite-vhost':
			content		=>	template('graphite/graphite-vhost.erb'),
		}

		# enable vhost
		exec {
			'/usr/sbin/a2ensite graphite-vhost':
				require	=>	File['/etc/apache2/sites-available/graphite-vhost'],
      	path    =>  ['/usr/bin', '/usr/sbin'],
				cwd			=>	'/usr/sbin',
				unless	=>	'/usr/bin/test -f /etc/apache2/sites-enabled/graphite-vhost';
			'/bin/cp /opt/graphite/conf/graphite.wsgi.example /opt/graphite/conf/graphite.wsgi':
      	require =>  Package[$graphite::params::graphiteweb],
        path    =>  ['/usr/bin', '/usr/sbin'],
        cwd     =>  '/usr/bin',
				unless	=>	'test -f /opt/graphite/conf/graphite.wsgi'
		}

	}
}
