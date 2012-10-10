# = Class: rsyslog
#
# This is the main rsyslog class
#
#
# == Parameters
#
# Module specific variables
# [*syslog_server*]
#   Ip or hostname of a central syslog server. Note that in order to apply
#   it you need a template that uses this $rsyslog::syslog_server variable 
#
# [*mode*]
#   Syslog server mode. If set to server it will bind to the syslog port
#   and act as a central server
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, rsyslog class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $rsyslog_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, rsyslog main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $rsyslog_source
#
# [*source_dir*]
#   If defined, the whole rsyslog configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $rsyslog_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the (top scope) variable $rsyslog_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, rsyslog main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $rsyslog_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $rsyslog_options
#
# [*service_autorestart*]
#   Automatically restarts the rsyslog service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $rsyslog_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $rsyslog_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $rsyslog_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $rsyslog_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for rsyslog checks
#   Can be defined also by the (top scope) variables $rsyslog_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the (top scope) variables $rsyslog_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $rsyslog_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $rsyslog_puppi_helper
#   and $puppi_helper
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $rsyslog_firewall
#   and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module)
#   you want to use to open firewall for rsyslog port(s)
#   Can be defined also by the (top scope) variables $rsyslog_firewall_tool
#   and $firewall_tool
#
# [*firewall_src*]
#   Define which source ip/net allow for firewalling rsyslog. Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $rsyslog_firewall_src
#   and $firewall_src
#
# [*firewall_dst*]
#   Define which destination ip to use for firewalling. Default: $ipaddress
#   Can be defined also by the (top scope) variables $rsyslog_firewall_dst
#   and $firewall_dst
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $rsyslog_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $rsyslog_audit_only
#   and $audit_only
#
# Default class params - As defined in rsyslog::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of rsyslog package
#
# [*service*]
#   The name of rsyslog service
#
# [*service_status*]
#   If the rsyslog service init script supports status argument
#
# [*process*]
#   The name of rsyslog process
#
# [*process_args*]
#   The name of rsyslog arguments. Used by puppi and monitor.
#   Used only in case the rsyslog process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user rsyslog runs with. Used by puppi and monitor.
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*config_file_init*]
#   Path of configuration file sourced by init script
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $rsyslog_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $rsyslog_protocol
#
#
# == Examples
#
# You can use this class in 2 ways:
# - Set variables (at top scope level on in a ENC) and "include rsyslog"
# - Call rsyslog as a parametrized class
#
# See README for details.
#
#
# == Author
#   Alessandro Franceschi <al@lab42.it/>
#
class rsyslog (
  $syslog_server       = params_lookup( 'syslog_server' ),
  $mode                = params_lookup( 'mode' ),
  $my_class            = params_lookup( 'my_class' ),
  $source              = params_lookup( 'source' ),
  $source_dir          = params_lookup( 'source_dir' ),
  $source_dir_purge    = params_lookup( 'source_dir_purge' ),
  $template            = params_lookup( 'template' ),
  $service_autorestart = params_lookup( 'service_autorestart' , 'global' ),
  $options             = params_lookup( 'options' ),
  $version             = params_lookup( 'version' ),
  $absent              = params_lookup( 'absent' ),
  $disable             = params_lookup( 'disable' ),
  $disableboot         = params_lookup( 'disableboot' ),
  $monitor             = params_lookup( 'monitor' , 'global' ),
  $monitor_tool        = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target      = params_lookup( 'monitor_target' , 'global' ),
  $puppi               = params_lookup( 'puppi' , 'global' ),
  $puppi_helper        = params_lookup( 'puppi_helper' , 'global' ),
  $firewall            = params_lookup( 'firewall' , 'global' ),
  $firewall_tool       = params_lookup( 'firewall_tool' , 'global' ),
  $firewall_src        = params_lookup( 'firewall_src' , 'global' ),
  $firewall_dst        = params_lookup( 'firewall_dst' , 'global' ),
  $debug               = params_lookup( 'debug' , 'global' ),
  $audit_only          = params_lookup( 'audit_only' , 'global' ),
  $package             = params_lookup( 'package' ),
  $service             = params_lookup( 'service' ),
  $service_status      = params_lookup( 'service_status' ),
  $process             = params_lookup( 'process' ),
  $process_args        = params_lookup( 'process_args' ),
  $process_user        = params_lookup( 'process_user' ),
  $config_dir          = params_lookup( 'config_dir' ),
  $config_file         = params_lookup( 'config_file' ),
  $config_file_mode    = params_lookup( 'config_file_mode' ),
  $config_file_owner   = params_lookup( 'config_file_owner' ),
  $config_file_group   = params_lookup( 'config_file_group' ),
  $config_file_init    = params_lookup( 'config_file_init' ),
  $pid_file            = params_lookup( 'pid_file' ),
  $data_dir            = params_lookup( 'data_dir' ),
  $log_dir             = params_lookup( 'log_dir' ),
  $log_file            = params_lookup( 'log_file' ),
  $port                = params_lookup( 'port' ),
  $protocol            = params_lookup( 'protocol' )
  ) inherits rsyslog::params {

  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_firewall=any2bool($firewall)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)

  ### Definition of some variables used in the module
  $manage_package = $rsyslog::bool_absent ? {
    true  => 'absent',
    false => $rsyslog::version,
  }

  $manage_service_enable = $rsyslog::bool_disableboot ? {
    true    => false,
    default => $rsyslog::bool_disable ? {
      true    => false,
      default => $rsyslog::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $rsyslog::bool_disable ? {
    true    => 'stopped',
    default =>  $rsyslog::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_service_autorestart = $rsyslog::bool_service_autorestart ? {
    true    => Service[rsyslog],
    false   => undef,
  }

  $manage_file = $rsyslog::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $rsyslog::bool_absent == true
  or $rsyslog::bool_disable == true
  or $rsyslog::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  if $rsyslog::bool_absent == true
  or $rsyslog::bool_disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $rsyslog::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $rsyslog::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $rsyslog::source ? {
    ''        => undef,
    default   => $rsyslog::source,
  }

  $manage_file_content = $rsyslog::template ? {
    ''        => undef,
    default   => template($rsyslog::template),
  }

  ### Managed resources
  package { $rsyslog::package:
    ensure => $rsyslog::manage_package,
  }

  service { 'rsyslog':
    ensure     => $rsyslog::manage_service_ensure,
    name       => $rsyslog::service,
    enable     => $rsyslog::manage_service_enable,
    hasstatus  => $rsyslog::service_status,
    pattern    => $rsyslog::process,
    require    => Package[$rsyslog::package],
  }

  file { 'rsyslog.conf':
    ensure  => $rsyslog::manage_file,
    path    => $rsyslog::config_file,
    mode    => $rsyslog::config_file_mode,
    owner   => $rsyslog::config_file_owner,
    group   => $rsyslog::config_file_group,
    require => Package[$rsyslog::package],
    notify  => $rsyslog::manage_service_autorestart,
    source  => $rsyslog::manage_file_source,
    content => $rsyslog::manage_file_content,
    replace => $rsyslog::manage_file_replace,
    audit   => $rsyslog::manage_audit,
  }

  # The whole rsyslog configuration directory can be recursively overriden
  if $rsyslog::source_dir {
    file { 'rsyslog.dir':
      ensure  => directory,
      path    => $rsyslog::config_dir,
      require => Package[$rsyslog::package],
      notify  => $rsyslog::manage_service_autorestart,
      source  => $rsyslog::source_dir,
      recurse => true,
      purge   => $rsyslog::bool_source_dir_purge,
      replace => $rsyslog::manage_file_replace,
      audit   => $rsyslog::manage_audit,
    }
  }


  ### Include custom class if $my_class is set
  if $rsyslog::my_class {
    include $rsyslog::my_class
  }


  ### Provide puppi data, if enabled ( puppi => true )
  if $rsyslog::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'rsyslog':
      ensure    => $rsyslog::manage_file,
      variables => $classvars,
      helper    => $rsyslog::puppi_helper,
    }
  }

  if $rsyslog::bool_monitor == true and $rsyslog::service != '' {
    monitor::process { 'rsyslog_process':
      process  => $rsyslog::process,
      service  => $rsyslog::service,
      pidfile  => $rsyslog::pid_file,
      user     => $rsyslog::process_user,
      argument => $rsyslog::process_args,
      tool     => $rsyslog::monitor_tool,
      enable   => $rsyslog::manage_monitor,
    }
  }

  if ($rsyslog::mode == 'server') or ($rsyslog::syslog_server == $fqdn) {
    ### Service monitoring, if enabled ( monitor => true )
    if $rsyslog::bool_monitor == true {
      if $rsyslog::port != '' {
        monitor::port { "rsyslog_${rsyslog::protocol}_${rsyslog::port}":
          protocol => $rsyslog::protocol,
          port     => $rsyslog::port,
          target   => $rsyslog::monitor_target,
          tool     => $rsyslog::monitor_tool,
          enable   => $rsyslog::manage_monitor,
        }
      }
    }
  
  
    ### Firewall management, if enabled ( firewall => true )
    if $rsyslog::bool_firewall == true and $rsyslog::port != '' {
      firewall { "rsyslog_${rsyslog::protocol}_${rsyslog::port}":
        source      => $rsyslog::firewall_src,
        destination => $rsyslog::firewall_dst,
        protocol    => $rsyslog::protocol,
        port        => $rsyslog::port,
        action      => 'allow',
        direction   => 'input',
        tool        => $rsyslog::firewall_tool,
        enable      => $rsyslog::manage_firewall,
      }
    }
  }

  ### Debugging, if enabled ( debug => true )
  if $rsyslog::bool_debug == true {
    file { 'debug_rsyslog':
      ensure  => $rsyslog::manage_file,
      path    => "${settings::vardir}/debug-rsyslog",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
    }
  }

}