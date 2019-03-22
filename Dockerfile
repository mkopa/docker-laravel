FROM alpine:3.9

# Build parameters --build-arg
ARG USER=laravel
ARG DIR=/home/laravel

# Install base tools
RUN apk update
RUN apk add --no-cache bash php7 php7-curl php7-common php7-cli php7-mysqli php7-mbstring php7-fpm php7-xml php7-zip nodejs npm nginx

# Install global PM2
#RUN npm install -g pm2@latest \
#    && pm2 install pm2-logrotate \
#    && pm2 set pm2-logrotate:retain 7

# USER dirs and Permissions
RUN addgroup -S laravel && adduser -S laravel -G laravel

#RUN mkdir $LOGDIR

WORKDIR $DIR
#USER $USER

#COPY . .
# Install node-modules
#RUN npm install

# Hack for permissions
#USER root
#RUN chown -R $USER:$USER $DIR
#RUN chown -R $USER:$USER $LOGDIR
#USER $USER

EXPOSE 8000

CMD bash -C 'start.sh'; 'bash'
