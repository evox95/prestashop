#!/bin/bash

docker-compose exec psdev-shop php /var/www/html/install-dev/index_cli.php \
  --domain=127.0.0.1 \
  --db_server=psdev-database \
  --db_name=prestashop \
  --db_user=root \
  --db_password=root1 \
  --language=pl \
  --country=pl \
  --email=demo@prestashop.com \
  --password=prestashop_demo \
  --newsletter=0 \
  --send_email=0 \
  --ssl=0 \
  --db_create=1 \
  --db_clear=1