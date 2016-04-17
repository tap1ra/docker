docker build -f php-fpm.dockerfile -t yasuaki-tahira/php-fpm .
docker run -d --name php-fpm -v $(pwd)/mnt:/DATA yasuaki-tahira/php-fpm

docker build -f nginx.dockerfile -t yasuaki-tahira/nginx .
docker run -d -p 80:80 -v $(pwd)/mnt:/DATA --link php-fpm:php-fpm yasuaki-tahira/nginx

echo "<?php phpinfo(); ?>" > mnt/htdocs/phpinfo.php
echo "http://$(docker-machine ip default)/phpinfo.php" | pbcopy
http://192.168.99.100/phpinfo.php
