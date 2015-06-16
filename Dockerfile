FROM sameersbn/ubuntu:14.04.20150613
MAINTAINER sameer@damagehead.com

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E1DD270288B4E6030699E45FA1715D88E1DF1F24 \
 && echo "deb http://ppa.launchpad.net/git-core/ppa/ubuntu trusty main" >> /etc/apt/sources.list \
 && apt-key adv --keyserver keyserver.ubuntu.com --recv 80F70E11F0F0D5F10CB20E62F5DA5F09C3173AA6 \
 && echo "deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu trusty main" >> /etc/apt/sources.list \
 && apt-get update \
 && apt-get install -y supervisor git-core openssh-client ruby2.1 \
      zlib1g libyaml-0-2 libssl1.0.0 \
      libgdbm3 libreadline6 libncurses5 libffi6 \
      libxml2 libxslt1.1 libcurl3 libicu52 \
      python-pip python-dev build-essential \
      checkinstall zlib1g-dev libyaml-dev libssl-dev \
      memcached libmemcache-dev python-imaging libjpeg8-dev \
      unzip zlib1g libfreetype6 libfreetype6-dev \
      libcairo2 libpango1.0-0 libgdk-pixbuf2.0-0 \
      libgdk-pixbuf2.0-dev \
      libgdbm-dev libreadline-dev libncurses5-dev libffi-dev \
      libxml2-dev libxslt-dev libcurl4-openssl-dev libicu-dev \
      fontconfig libgeoip-dev \
      python-numpy python-scipy \
      firefox xvfb
&& gem install --no-document bundler \
&& rm -rf /var/lib/apt/lists/* # 20150613

ADD assets/setup/ /app/setup/
RUN chmod 755 /app/setup/install
RUN /app/setup/install

ADD assets/init /app/init
RUN chmod 755 /app/init

VOLUME ["/home/gitlab_ci_runner/data"]

ENTRYPOINT ["/app/init"]
CMD ["app:start"]
