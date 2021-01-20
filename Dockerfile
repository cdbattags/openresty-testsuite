FROM openresty/openresty:1.19.3.1-bionic

ARG http_proxy
ARG https_proxy

ENV PATH $PREFIX/openresty/nginx/sbin:$PATH

# install basic dependencies
RUN apt-get update -y \
  && apt-get install -y --no-install-recommends \
    libreadline-dev libncurses5-dev libpcre3-dev libssl-dev \
    perl make build-essential unzip cpanminus

# install perl openresty test kit
RUN cpan -f -i Test::Nginx

WORKDIR /
