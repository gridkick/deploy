server {
  listen 80;
  server_name venture.io;
  rewrite ^/(.*)$ https://gridkick.com/$1 redirect;
}
