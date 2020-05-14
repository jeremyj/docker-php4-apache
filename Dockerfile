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
	php4-mysql \
	php4-pear 
	
COPY DB_Pager-0.7.tgz DB_Pager-0.7.tgz
COPY HTML_Common-1.2.5.tgz HTML_Common-1.2.5.tgz
COPY Pager_Sliding-1.6.tgz Pager_Sliding-1.6.tgz
COPY XML_Parser-1.3.4.tgz XML_Parser-1.3.4.tgz
COPY XML_Serializer-0.20.2.tgz XML_Serializer-0.20.2.tgz
COPY XML_Util-1.2.1.tgz XML_Util-1.2.1.tgz

RUN pear install DB_Pager-0.7.tgz
RUN pear install HTML_Common-1.2.5.tgz
RUN pear install Pager_Sliding-1.6.tgz
RUN pear install XML_Util-1.2.1.tgz
RUN pear install XML_Parser-1.3.4.tgz
RUN pear install XML_Serializer-0.20.2.tgz

RUN rm DB_Pager-0.7.tgz HTML_Common-1.2.5.tgz Pager_Sliding-1.6.tgz XML_Util-1.2.1.tgz XML_Parser-1.3.4.tgz XML_Serializer-0.20.2.tgz 

RUN a2enmod rewrite

RUN find /var/lib/apt/lists/ -type f -delete
RUN find /var/cache/apt/archives/ -type f -delete

RUN ln -sf /dev/stdout /var/log/apache2/access.log
RUN ln -sf /dev/stderr /var/log/apache2/error.log

EXPOSE 80

CMD ["apache2","-DFOREGROUND"]
