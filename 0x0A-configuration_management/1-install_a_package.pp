# This manifest installs flask from pip3

exec { 'install python packages':
  command => 'pip3 install flask==2.1.0',
  path    => ['/usr/bin/'],
  unless  => '/usr/bin/test -f /usr/local/lib/python3.4/dist-packages/flask/app.py',
}
