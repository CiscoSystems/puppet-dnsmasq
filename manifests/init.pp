class dnsmasq($only_dns = true) {
    package { "dnsmasq":
        ensure => present
    }

    file { "/etc/dnsmasq.conf":
        content => template("dnsmasq/dnsmasq.conf.erb"),
        owner => root,
        group => root,
        mode => 0644,
        notify => Exec["reload-dnsmasq"]
    }

    exec { "reload-dnsmasq":
        command => "/usr/sbin/service dnsmasq restart",
        refreshonly => true,
        require => Package[dnsmasq]
    }
}
