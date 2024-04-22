#!/usr/bin/env bash
# This script contains a puppet manifest that sets up a client SSH configuration for passwordless connection

# find the file
file { '~/.ssh/config':
  ensure  => present,
}

# Dissable password authentication
file_line { 'Turn off passwd auth':
  path    => '~/.ssh/config',
  line    => 'PasswordAuthentication no',
  match   => '^#?PasswordAuthentication',
  ensure  => present,
}

# Declare the identity file
file_line { 'Declare identity file':
  path    => '~/.ssh/config',
  line    => 'IndentityFile ~/.ssh/school',
  match   => '^#?IdentityFile',
  ensure  => present,
}
