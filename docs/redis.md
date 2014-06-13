# Redis

#### Common Issues

Corrupted data in Redis AOF. This error surfaces when restarting redis and 
the AOF file is loaded in order to construct the original dataset. The 
`/var/run/redis.log` file will have this message.

    sudo tail -n 100 /var/log/redis.log
     
     ...
     
    Bad file format reading the append only file: make a backup of your AOF file, then use ./redis-check-aof --fix <filename>

Solution fix.

    sudo redis-check-aof --fix /var/lib/redis/appendonly.aof 
