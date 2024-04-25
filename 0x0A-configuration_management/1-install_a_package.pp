# This manifest installs flask from pip3

package { 'flask':
  ensure   => '2.1.0',
  command  => 'pip3 install flask',
  provider => 'pip3',
}
