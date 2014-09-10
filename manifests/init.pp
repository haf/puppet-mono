class mono {
  package { 'mono':
    ensure => installed,
  }

  Exec {
    user    => 'root',
    path    => '/usr/bin:/bin',
    require => Package['mono'],
  }

  # http://www.mono-project.com/FAQ:_Security
  exec {
    'yes | certmgr -ssl -m https://nuget.org && touch /etc/.certs-nuget.org':
      creates => '/etc/.certs-nuget.org';
    'yes | certmgr -ssl -m https://packages.nuget.org/v1/FeedService.svc/ && touch /etc/.certs-packages.nuget.org':
      creates => '/etc/.certs-packages.nuget.org';
    'yes | certmgr -ssl -m https://go.microsoft.com && touch /etc/.certs-go.microsoft.com':
      creates => '/etc/.certs-go.microsoft.com';
    'yes | certmgr -ssl -m https://nugetgallery.blob.core.windows.net && touch /etc/.certs-nugetgallery.blob.core.windows.net':
      creates => '/etc/.certs-nugetgallery.blob.core.windows.net';
  }

  exec { 'update-CAs':
    command => '/usr/bin/mozroots --import --machine --sync && touch /etc/.cmd-update-CAs',
    creates => '/etc/.cmd-update-CAs',
  }
}