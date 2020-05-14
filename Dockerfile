FROM xaossystems/debian-etch
LABEL maintainer="305674+jeremyj@users.noreply.github.com"

RUN apt-get update
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get -yq install \
	libapache2-mod-php4 \
	php-db \
	php-http \
	php-mail \
	php-net-smtp \
	php-net-socket \
	php-pear \
	php-xml-parser \
	php4-curl \
	php4-domxml \
	php4-gd \
	php4-imap \
	php4-ldap \
	php4-mhash \
	php4-mysql

COPY pear-package.list pear-package.list
RUN cat pear-package.list | while read file; do wget $file ;done
RUN pear install XML_Parser-1.3.4.tgz
RUN for i in `ls -r *.tgz | grep -v XML_Parser`; do pear install $i && rm -f $i; done

RUN rm *.tgz

RUN a2enmod rewrite

RUN find /var/lib/apt/lists/ -type f -delete
RUN find /var/cache/apt/archives/ -type f -delete

RUN ln -sf /dev/stdout /var/log/apache2/access.log
RUN ln -sf /dev/stderr /var/log/apache2/error.log

EXPOSE 80

CMD ["apache2","-DFOREGROUND"]
