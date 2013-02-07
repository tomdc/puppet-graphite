Puppet module for Graphite
==========================

This is a puppet-graphite module.
All bugs procduced by Kris.Buytaert@gmail.com

Dependencies
------------
This module depends on

- [concat](http://forge.puppetlabs.com/ripienaar/concat)

Installation
------------

This module can be installed via the puppet module tool:

    puppet module install KrisBuytaert/graphite

Notes
-----

- Centos

I've made the packaged versions of graphite-web, carbon and whisper. 
available on

The repository has been updated to have 0.9.10 versions of carbon, whisper and graphite-web


    yumrepo { 'monitoringsucks':
        baseurl  => 'http://pulp.inuits.eu/pulp/repos/monitoring',
        descr    => 'MonitoringSuck at Inuits',
        gpgcheck => '0',
    }

You can also use your own repo
And you also need to have EPEL available  e.g from 

    yumrepo {'epel':
        baseurl  => 'http://pulp.inuits.eu/pulp/repos/epel/6/x86_64/',
        descr    => 'Epel Repo at Inuits',
        gpgcheck => '0',
    }


- Debian

Debian notes

  * /etc/default/graphite-carbon needs to be changed so that carbon starts at boot.
    CARBON_CACHE_ENABLED=true
  * the default vhostname is the fqdn of the machine, which will conflict with the default vhost.
    So diable the default or change the graphite vhost template vhost name

Packages available upstream:
  * graphite-carbon
  * python-whisper

Still needed is a graphite-web package.
https://github.com/jbraeuer/graphite-debs is used to generate one.
It installs everything in /opt/graphite, and requires some config before it can be used.



Usage
-----

    include graphite

    graphite::carbon::storage {"default_1min_for_1day":
      pattern    => ".*",
      retentions => "60s:1d",
    }

Note that without this define you won't have the default behaviour.

Testing
-------

More Detailed Examples on how to use this module including a fully functional Vagrant box can be found on https://github.com/KrisBuytaert/vagrant-graphite.git

I've tagged the code that supports 0.9.9 versions of graphite-web and carbon with
the 0.9.9 tag ..
