class profile::sensu::backend {

  class { 'sensu::backend':
    old_password => 'P@ssw0rd!',
  }

  include sensu::agent

  sensu_check { 'check-cpu':
    ensure        => 'present',
    command       => '/opt/sensu-plugins-ruby/embedded/bin/check-cpu.rb -w 0.1 -c 10',
    interval      => 60,
    subscriptions => ['linux'],
  }
  sensu_check { 'check-disk-usage':
    ensure        => 'present',
    command       => '/opt/sensu-plugins-ruby/embedded/bin/check-disk-usage.rb -w 50 -c 80',
    interval      => 60,
    subscriptions => ['linux'],
  }
  # the following does not trigger a warning to Sensu, only in CLI, bug?
  sensu_check { 'check-windows-disk':
    ensure        => 'present',
    command       => 'C:\ProgramData\SensuPlugins\sensu-plugins-windows\bin\powershell\check-windows-disk.ps1 20 40',
    interval      => 60,
    subscriptions => ['windows'],
  }

}
