class profile::sensu::agent_windows {

  class { 'sensu::agent':
    backends    => ['mon.node.consul:8081'],
    config_hash => {
      'subscriptions' => ['windows'],
    },
  }

  file { 'C:\ProgramData\SensuPlugins':
    ensure => directory,
  }
  vcsrepo { 'C:\ProgramData\SensuPlugins\sensu-plugins-windows':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/sensu-plugins/sensu-plugins-windows.git',
    require  => File['C:\ProgramData\SensuPlugins'],
  }

}
