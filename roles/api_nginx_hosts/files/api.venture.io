server {
  listen 443;
  ssl on;
  ssl_certificate     /opt/nginx/conf/ssl/api.venture.io-unified.crt;
  ssl_certificate_key /opt/nginx/conf/ssl/api.venture.io.key;
  server_name api.venture.io;
  rewrite ^/(.*)$ https://api.gridkick.com/$1 redirect;
}

server {
  listen 80;
  server_name api.venture.io;
  rewrite ^/(.*)$ https://api.gridkick.com/$1 redirect;
}
