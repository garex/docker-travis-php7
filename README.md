# Dockerized travis's php7

## Build

    docker build --tag=garex/travis-php7 .

## Run

    docker run --name=php7 --detach --restart=always --publish=127.0.7.7:9000:9000 \
            --volume=$(pwd):/var/www \
            --volume=$(pwd):/tmp/wpti \
            garex/travis-php7
