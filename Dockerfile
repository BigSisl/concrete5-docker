FROM chriswayg/apache-php
MAINTAINER Lucien Zürcher l.zuercher@tincan.ch

ENV CONCRETE5_REPO https://github.com/concrete5/concrete5.git
ARG CONCRETE5_VERSION
ENV CONCRETE5_VERSION ${CONCRETE5_VERSION:-''}
ENV SRC_DIRECTORY /usr/local/src

# add local concrete user
RUN useradd -ms /bin/bash concrete5

# Install pre-requisites for Concrete5 & nano for editing conf files
RUN apt-get update && \
      DEBIAN_FRONTEND=noninteractive apt-get -y install \
      php5-curl \
      php5-gd \
      php5-mysql \
      unzip \
      wget \
      patch \
      git \
      curl \
      sudo \
      nano && \
    apt-get clean && rm -r /var/lib/apt/lists/* && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy apache2 conf dir
# Perl script to enable ability to activate 'Pretty URLs' and redirection in .htaccess by 'AllowOverride'
# - it matches a multi-line string and replaces 'None' with 'FileInfo'
RUN perl -i.bak -0pe 's/<Directory \/var\/www\/>\n\tOptions Indexes FollowSymLinks\n\tAllowOverride None/<Directory \/var\/www\/>\n\tOptions Indexes FollowSymLinks\n\tAllowOverride FileInfo/' /etc/apache2/apache2.conf && \
    cp -r /etc/apache2 /usr/local/etc/apache2

RUN echo $CONCRETE5_VERSION

# install concrete5
ADD ./src $SRC_DIRECTORY/concrete${CONCRETE5_VERSION}

RUN chown -Rf concrete5:concrete5 $SRC_DIRECTORY
USER concrete5

# Install compose
RUN cd $SRC_DIRECTORY/concrete${CONCRETE5_VERSION}/web/concrete && \
    php /usr/local/bin/composer install

USER root

# turn on short open tags for php
RUN sed -i -e 's/short_open_tag = .*/short_open_tag = On/g' /etc/php5/cli/php.ini && \
    sed -i -e 's/short_open_tag = .*/short_open_tag = On/g' /etc/php5/apache2/php.ini

EXPOSE 80 443
WORKDIR /var/www/html

COPY docker-entrypoint /docker-entrypoint
RUN chmod 755 /docker-entrypoint

ENTRYPOINT ["/docker-entrypoint"]
CMD ["apache2-foreground"]
