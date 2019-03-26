FROM debian:stretch-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN \
	apt-get -y -qq update && \
	apt-get -y -qq upgrade && \
	apt-get -y -qq install apt-transport-https apt-utils gnupg2 curl && \
	echo deb https://packages.grafana.com/oss/deb stable main > /etc/apt/sources.list.d/grafana.list && \
	curl -s https://packages.grafana.com/gpg.key | apt-key add - && \
	apt-get -y -qq update && \
	apt-get -y -qq upgrade && \
	apt-get -y -qq install grafana && \
	mkdir /etc/grafana/data && \
	apt-get -y -qq autoremove && \
	apt-get -y -qq clean

EXPOSE 3000

USER grafana:grafana

WORKDIR /usr/share/grafana

COPY conf/grafana.ini /etc/grafana/grafana.ini

VOLUME /etc/grafana

CMD ["/usr/sbin/grafana-server","-config","/etc/grafana/grafana.ini"]
