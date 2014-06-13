server {
  listen 443;
  ssl on;
  ssl_certificate     /opt/nginx/conf/ssl/ad.venture.io-unified.crt;
  ssl_certificate_key /opt/nginx/conf/ssl/ad.venture.io.key;
  server_name ad.venture.io;
  rewrite ^/(.*)$ https://gridkick.com/$1 redirect;
}

server {
  listen 80;
  server_name ad.venture.io;
  rewrite ^/(.*)$ https://gridkick.com/$1 redirect;
}
