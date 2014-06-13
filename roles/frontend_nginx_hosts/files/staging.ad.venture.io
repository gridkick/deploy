server {
  listen 80;
  server_name staging.ad.venture.io;
  rewrite ^/(.*)$ https://staging.gridkick.com/$1 redirect;
}
