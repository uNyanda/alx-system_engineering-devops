#!/usr/bin/env bash
# This script contains a puppet manifest that sets up a client SSH configuration for passwordless connection

# find the file
file { '~/.ssh/config':
  ensure  => present,
}

# Dissable password authentication
file_line { 'Turn off passwd auth':
  ensure => present,
  line   => 'PasswordAuthentication no',
  match  => '^#?PasswordAuthentication',
  path   => '~/.ssh/config',
}

# Declare the identity file
file_line { 'Declare identity file':
  ensure => present,
  line   => 'IndentityFile ~/.ssh/school',
  match  => '^#?IdentityFile',
  path   => '~/.ssh/config',
}
