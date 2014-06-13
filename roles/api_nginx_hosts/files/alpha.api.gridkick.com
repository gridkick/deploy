server {
  listen 80;
  server_name alpha.api.gridkick.com;
  rewrite ^/(.*)$ https://api.gridkick.com/$1 redirect;
}
