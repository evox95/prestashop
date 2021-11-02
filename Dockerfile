FROM prestashop/base:7.1-apache

ENV TZ Europe/Warsaw

RUN \
    # install ioncube
    cd /tmp/ && wget https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz && \
    tar -zxvf /tmp/ioncube_loaders_lin_x86-64.tar.gz && \
    mkdir -p /usr/local/ioncube && \
    cp /tmp/ioncube/ioncube_loader_* /usr/local/ioncube && \
    echo 'zend_extension = /usr/local/ioncube/ioncube_loader_lin_7.1.so' > /usr/local/etc/php/conf.d/00-ioncube.ini && \
    rm -rf /tmp/ioncube && rm /tmp/ioncube_loaders_lin_x86-64.tar.gz
