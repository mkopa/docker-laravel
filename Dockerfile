FROM debian:stretch

RUN apt-get update && apt-get install wget apt-transport-https lsb-release ca-certificates unzip -y

RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

RUN apt-get update && apt-get install php7.2 php7.2-curl php7.2-common php7.2-cli php7.2-mysql php7.2-mbstring php7.2-fpm php7.2-xml php7.2-zip composer nginx -y

RUN echo "cgi.fix_pathinfo=0" >> /etc/php/7.2/fpm/php.ini



COPY nginx.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /var/www
WORKDIR /var/www
RUN composer create-project laravel/laravel laravel

RUN chown -R www-data:root /var/www/laravel
RUN chmod 755 /var/www/laravel/storage

# COPY . .

EXPOSE 80 443

CMD bash -C 'start.sh'; 'bash'

