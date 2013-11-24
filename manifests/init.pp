class mono {
  anchor { 'mono::start': } ->
  package { 'mono': ensure => installed } ->
  anchor { 'mono::end': }
}