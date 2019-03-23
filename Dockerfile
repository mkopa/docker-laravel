FROM debian:stretch

# Build parameters --build-arg
ARG USER=laravel
ARG DIR=/home/laravel
ARG PUBLIC_DIR=/home/laravel/public

RUN apt-get update && apt-get install wget apt-transport-https lsb-release ca-certificates unzip -y
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
RUN apt-get update && apt-get install php7.2 php7.2-curl php7.2-common php7.2-cli php7.2-mysql php7.2-mbstring php7.2-fpm php7.2-xml php7.2-zip nginx -y
RUN echo "cgi.fix_pathinfo=0" >> /etc/php/7.2/fpm/php.ini

# USER dirs and Permissions
RUN useradd -ms /bin/bash $USER

# Nginx config
COPY nginx.conf /etc/nginx/sites-available/default

RUN mkdir $PUBLIC_DIR

WORKDIR $PUBLIC_DIR

COPY ./public/info.php ./phpinfo.php
COPY ./start.sh ../start.sh

USER root
RUN chown -R $USER:$USER $DIR

EXPOSE 80 443

CMD bash -C '../start.sh'; 'bash'
