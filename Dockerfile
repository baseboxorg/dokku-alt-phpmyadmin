FROM ubuntu:trusty
MAINTAINER Kamil Trzciński <ayufan@ayufan.eu>

RUN apt-get update -y
RUN apt-get install -y php5-fpm php5-json php5-mcrypt php5-mysql php5-gd php5-mcrypt git-core

# Clone sources
RUN git clone https://github.com/phpmyadmin/phpmyadmin.git /phpmyadmin -b RELEASE_4_2_0 --depth=1
ADD config.inc.php /phpmyadmin/
ADD fpm-pool.conf /etc/php5/fpm/pool.d/www.conf

# Switch to phpmyadmin
USER nobody
WORKDIR /phpmyadmin

# Start everything
EXPOSE 8080
ENTRYPOINT ["php", "-S", "0.0.0.0:8080"]
