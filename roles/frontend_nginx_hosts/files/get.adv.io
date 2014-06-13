server {
  listen 80;
  server_name get.adv.io;
  rewrite ^/(.*)$ http://bit.ly/get_advio redirect;
}
