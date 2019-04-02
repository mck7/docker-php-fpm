# docker-apache-php
Generic php-fpm image

Based of the official image from php - [php:7.2-fpm](https://github.com/docker-library/php/blob/873725e57ec2fc5f2642dc0023676597bcc4bea9/7.2/stretch/fpm/Dockerfile)

Adding the following:
* composer
* wp-cli
* vim

```
[PHP Modules]
bcmath
Core
ctype
curl
date
dom
exif
fileinfo
filter
ftp
gd
hash
iconv
json
libxml
mbstring
mysqli
mysqlnd
openssl
pcntl
pcre
PDO
pdo_mysql
pdo_sqlite
Phar
posix
readline
Reflection
session
SimpleXML
sodium
SPL
sqlite3
standard
tokenizer
xml
xmlreader
xmlwriter
xsl
zip
zlib
```
