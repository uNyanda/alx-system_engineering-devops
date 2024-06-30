# Puppet manifest to install and configure Nginx web server

# Install the package
package { 'nginx':
  ensure  =>  installed,
}

# Define Nginx service
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}

# Configure Nginx site
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => template('nginx/default.erb'),
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Enable default site by creating symlink
file { '/etc/nginx/sites-enabled/default':
  ensure  => link,
  target  => '/etc/nginx/sites-available/default',
  require => File['/etc/nginx/sites-available/default'],
  notify  => Service['nginx'],
}

# Create custom 404 page
file { '/var/www/html/404.html':
  ensure  => present,
  content => "Ceci n'est pas une page\n",
}

# Configure Nginx for custom 404 page and redirection
file { '/etc/nginx/sites-available/default':
  ensure  => present,
  content => template('nginx/default_redirect.erb'),
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Template for Nginx default configuration
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => "\
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html index.htm;

    location / {
        return 200 'Hello World!\n';
    }

    location /redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
    }

    error_page 404 /404.html;
    location = /404.html {
        root /var/www/html;
        internal;
    }
}
",
  require => Package['nginx'],
  notify  => Service['nginx'],
}