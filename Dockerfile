FROM quay.io/travisci/travis-php

MAINTAINER Alexander Ustimenko "a@ustimen.co"

RUN \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get install libc6 && \
  curl -s -o archive.tar.bz2 https://s3.amazonaws.com/travis-php-archives/binaries/ubuntu/12.04/x86_64/php-7.0.tar.bz2 && \
  tar xjf archive.tar.bz2 --directory / && \
  rm -f archive.tar.bz2

USER travis

ENV PATH /home/travis/.phpenv/bin:$PATH

RUN \
  phpenv global 7.0 && \
  phpenv rehash && \
  cd ~/.phpenv/versions/$(phpenv version-name) && \
  mv etc/php-fpm.conf.default etc/php-fpm.conf && \
  mv etc/php-fpm.d/www.conf.default etc/php-fpm.d/www.conf && \
  sed -i 's/127.0.0.1:9000/9000/' etc/php-fpm.d/www.conf

WORKDIR ~

EXPOSE 9000

CMD [ \
  "/home/travis/.phpenv/versions/7.0/sbin/php-fpm", \
    "--nodaemonize", \
    "--force-stderr" \
]
