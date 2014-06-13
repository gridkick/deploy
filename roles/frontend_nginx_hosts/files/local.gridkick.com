server {
  listen 443;
  ssl on;
  ssl_certificate     /opt/nginx/conf/ssl/gridkick/gridkick.com-unified.crt;
  ssl_certificate_key /opt/nginx/conf/ssl/gridkick/gridkick.com.key;
  server_name local.gridkick.com;
  root /var/www/adventure-frontend/local/current/public;
  passenger_enabled on;
  rails_env local;

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
  server_name local.gridkick.com;
  rewrite ^/(.*)$ https://local.gridkick.com/$1 redirect;
}
