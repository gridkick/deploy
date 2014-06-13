server {
  listen 80;
  server_name alpha-staging.api.ad.venture.io;
  rewrite ^/(.*)$ https://staging-api.gridkick.com/$1 redirect;
}
