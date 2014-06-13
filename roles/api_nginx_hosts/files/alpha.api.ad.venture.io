server {
  listen 80;
  server_name alpha.api.ad.venture.io;
  rewrite ^/(.*)$ https://api.gridkick.com/$1 redirect;
}
