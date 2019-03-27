FROM debian:stretch-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -qq update && \
	apt-get -qq upgrade && \
	apt-get -qq install \
		curl \
		gnupg2 \
		apt-utils \
		apt-transport-https \
	&& \
	apt-get -qq autoremove && \
	apt-get -qq clean

RUN echo deb https://packages.grafana.com/oss/deb stable main > /etc/apt/sources.list.d/grafana.list && \
	curl -s https://packages.grafana.com/gpg.key | apt-key add - && \
	apt-get -qq update && \
	apt-get -qq upgrade && \
	apt-get -qq install grafana && \
	mkdir /etc/grafana/data && \
	chown -R grafana:grafana /etc/grafana/data && \
	mkdir /etc/grafana/plugins && \
	chown -R grafana:grafana /etc/grafana/plugins && \
	mkdir /etc/grafana/logs && \
	chown -R grafana:grafana /etc/grafana/logs && \
	apt-get -qq autoremove && \
	apt-get -qq clean

COPY grafana.ini /etc/grafana/grafana.ini

EXPOSE 3000

WORKDIR /usr/share/grafana

VOLUME /etc/grafana

ENV PUID=1000
ENV PGID=1000

COPY start.sh /

CMD ["/start.sh"]