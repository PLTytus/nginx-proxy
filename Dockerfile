FROM jwilder/nginx-proxy

RUN apt-get update && \
	apt-get install -y procps htop