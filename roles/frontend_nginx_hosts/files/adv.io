server {
  listen 80;
  server_name adv.io;
  rewrite ^/(.*)$ https://gridkick.com/$1 redirect;
}
