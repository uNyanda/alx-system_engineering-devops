# This manifest installs flask from pip3

package { 'flask':
  command  => 'pip3 install flask',
  ensure   => '2.1.0',
}
