FROM quay.io/trueaccord/miniubuntu:latest
MAINTAINER TrueAccord

RUN curl -L https://toolbelt.treasuredata.com/sh/install-ubuntu-trusty-td-agent2.sh | sh

RUN installpkg gcc make g++

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

