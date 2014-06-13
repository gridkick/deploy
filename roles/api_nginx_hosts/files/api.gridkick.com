server {
  listen 443;
  ssl on;
  ssl_certificate     /opt/nginx/conf/ssl/gridkick/gridkick.com-unified.crt;
  ssl_certificate_key /opt/nginx/conf/ssl/gridkick/gridkick.com.key;
  server_name api.gridkick.com;
  root /var/www/adventure-api/alpha/current/public;
  passenger_enabled on;
  rails_env production;

  if (-f $document_root/maintenance.html){
    return 503;
  }

  error_page 503 @maintenance;

  location @maintenance {
    rewrite ^(.*)$ /maintenance.html break;
  }
}

server {
  listen 80;
  server_name api.gridkick.com;
  rewrite ^/(.*)$ https://api.gridkick.com/$1 redirect;
}
