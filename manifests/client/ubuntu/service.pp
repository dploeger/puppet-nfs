class nfs::client::ubuntu::service {

  service { 'rpcbind':
    ensure    => running,
    enable    => true,
    hasstatus => false,
  }

  if versioncmp($::operatingsystemrelease, '16.04') == -1 {

    if $nfs::client::ubuntu::nfs_v4 {
      service { 'idmapd':
        ensure    => running,
        enable    => true,
        subscribe => Augeas['/etc/idmapd.conf', '/etc/default/nfs-common'],
      }
    } else {
      service { 'idmapd':
        ensure => stopped,
        enable => false,
      }
    }

  }
}
