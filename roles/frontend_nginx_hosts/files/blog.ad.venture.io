server {
  listen 80;
  server_name blog.ad.venture.io;
  rewrite ^/(.*)$ http://blog.gridkick.com/$1 redirect;
}
