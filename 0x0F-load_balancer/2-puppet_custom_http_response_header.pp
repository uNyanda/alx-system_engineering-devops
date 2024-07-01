# Install nginx package
package { 'nginx':
  ensure  => installed,
}

# Define custom HTTP header configuration for Nginx
file { '/etc/nginx/sites-available/default':
  content => "
    server {
      listen 80 default_server;
      listen [::]:80 default_server;

      root /var/www/html;
      index index.html index.htm index.nginx-debian.html;

      server_name _;

      location / {
        # Add custom HTTP header
        add_header X-Served-By ${hostname};

        try_files $uri $uri/ =404;
      }
    }
  ",
  notify  => Service['nginx'],
}

# Ensure Nginx service is running and enabled
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}

