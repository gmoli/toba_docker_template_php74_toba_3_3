FROM siudocker/php:7.4-web-v1.0.3

RUN apk --no-cache add \
    git yarn php7-xmlreader php7-ldap\
    graphviz \
    openjdk8-jre \
    nano 
WORKDIR /usr/local/build

RUN curl -sS "https://getcomposer.org/download/latest-2.x/composer.phar" -o /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer
    
COPY composer.json /usr/local/build/composer.json
COPY parameters.yml /usr/local/build/parameters.yml

RUN composer install    
RUN echo -n postgres > /tmp/clave_pg 
RUN echo -n toba > /tmp/clave_toba

ENV PHP_MEMORY_LIMIT    2048M
ENV MAX_UPLOAD          50M
ENV PHP_MAX_FILE_UPLOAD 200
ENV PHP_MAX_POST        100M
ENV PHP_MAX_INPUT_VARS  15000
ENV PHP_LOGS_ERRORS  On

# Set environments
RUN sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php7/php.ini
RUN sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|i" /etc/php7/php.ini
RUN sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php7/php.ini
RUN sed -i "s|;*max_input_vars =.*|max_input_vars = ${PHP_MAX_INPUT_VARS}|i" /etc/php7/php.ini
RUN sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php7/php.ini
RUN sed -i "s|;*display_errors =.*|display_errors = ${PHP_DISPLAY_ERRORS}|i" /etc/php7/php.ini
RUN sed -i "s|;*log_errors =.*|log_errors = ${PHP_LOGS_ERRORS}|i" /etc/php7/php.ini
	
