FROM debian:wheezy

MAINTAINER Harvard Unviersity Faculty of Arts and Sciences Research Computing

RUN echo "deb http://packages.hubzero.org/deb ellie-deb7 main" | tee -a /etc/apt/sources.list
RUN apt-key adv --keyserver pgp.mit.edu --recv-keys 143C99EF
RUN apt-get update
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d
RUN apt-get install -y apt-utils
RUN apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server
RUN service mysql start && DEBIAN_FRONTEND=noninteractive apt-get install -y hubzero-mysql
RUN apt-get install -y hubzero-cms-2.0.0
RUN apt-get install -y supervisor python-pip
RUN pip install supervisor-stdout

ADD bin/hubzero_install.sh /usr/local/bin/hubzero_install.sh
ADD bin/apache-foreground.sh /usr/local/bin/apache-foreground.sh
ADD hubzero.conf /etc/supervisor/conf.d/hubzero.conf
ADD start.sh /usr/local/bin/start.sh

CMD ["/usr/local/bin/start.sh"]
