FROM quay.io/trueaccord/miniubuntu:latest
MAINTAINER TrueAccord

# From https://toolbelt.treasuredata.com/sh/install-ubuntu-xenial-td-agent2.sh
RUN curl https://packages.treasuredata.com/GPG-KEY-td-agent | apt-key add - && \
 echo "deb http://packages.treasuredata.com/2/ubuntu/xenial/ xenial contrib" > /etc/apt/sources.list.d/treasure-data.list 

RUN installpkg gcc make g++ td-agent

RUN td-agent-gem install \
  gelf \
  fluent-plugin-bigquery \
  fluent-plugin-elasticsearch \
  fluent-plugin-forest \
  fluent-plugin-parser \
  fluent-plugin-s3 \
  fluent-plugin-secure-forward

RUN cd /etc/td-agent/plugin && \
    curl \
    https://raw.githubusercontent.com/emsearcy/fluent-plugin-gelf/master/lib/fluent/plugin/out_gelf.rb \
    -o out_gelf.rb

ENTRYPOINT ["td-agent"]

