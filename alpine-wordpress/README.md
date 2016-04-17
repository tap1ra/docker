1. php-fpm
docker build -f php-fpm.dockerfile -t yasuaki-tahira/php-fpm .
docker run -d --name php-fpm -v $(pwd)/mnt:/DATA yasuaki-tahira/php-fpm

2. nginx
docker build -f nginx.dockerfile -t yasuaki-tahira/nginx .
docker run -d -p 80:80 -v $(pwd)/mnt:/DATA --link php-fpm:php-fpm yasuaki-tahira/nginx

3. test
echo "<?php phpinfo(); ?>" > mnt/htdocs/phpinfo.php
echo "http://$(docker-machine ip default)/phpinfo.php" | pbcopy
http://192.168.99.100/phpinfo.php

---

- `mnt` をmountしている。wordpressなどは `mnt/htdocs` に配置する
- `--name php-fpm` でphp-fpmコンテナを起動し、nginxの起動時に `--link php-fpm:php-fpm` でコンテナ間通信を設定。nginx.confでphpのTransfer先はホスト名ではなくて `--link` で定義した名前にする
