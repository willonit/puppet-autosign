# == Class autosign::install
#
# This class is called from autosign for install.
#
class autosign::install {

  # install the autosign gem
  package { $::autosign::package_name:
    ensure   => $::autosign::ensure,
    provider => 'puppetserver_gem',
  }

  $dir_ensure = $::autosign::ensure ? {
      /(absent|purged)/ => 'absent',
      default           => 'directory',
  }

  # the autosign key journal stores previously-used tokens to prevent re-use
  file {$::autosign::journalpath:
    ensure => $dir_ensure,
    mode   => '0750',
    owner  => 'pe-puppet',
    group  => 'pe-puppet',
  }
}
