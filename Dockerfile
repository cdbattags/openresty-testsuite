FROM ubuntu:14.04

ENV LUAROCK_CONF /etc/luarocks/config.lua
ENV OPENRESTY_DIR /tmp/openresty
ENV PREFIX /usr/local
ENV PATH $PREFIX/openresty/nginx/sbin:$PATH

# install basic dependencies
RUN apt-get update -y \
  && apt-get install -y --no-install-recommends \
    libreadline-dev libncurses5-dev libpcre3-dev libssl-dev \
    perl make build-essential unzip luarocks cpanminus

# config luarocks
RUN cp $LUAROCK_CONF $LUAROCK_CONF.bak \
  && tac $LUAROCK_CONF.bak | awk '{ if(NR>2) print }' | tac > $LUAROCK_CONF \
  && echo "   [[$PREFIX/openresty/luajit]]" >> $LUAROCK_CONF \
  && echo } >> $LUAROCK_CONF \
  && rm $LUAROCK_CONF.bak

# install perl openresty test kit
RUN cpanm install Test::Nginx

ARG OPENRESTY_VERSION=1.13.6.2
ENV OPENRESTY_FILE openresty-${OPENRESTY_VERSION}.tar.gz

# install openresty
RUN mkdir ${OPENRESTY_DIR}
WORKDIR ${OPENRESTY_DIR}
ADD https://openresty.org/download/${OPENRESTY_FILE} .
RUN tar xzf ${OPENRESTY_FILE} \
  && rm ${OPENRESTY_FILE} \
  && cd * \
  && ./configure --with-pcre-jit \
  && make && make install

WORKDIR /
RUN rm -rf /var/lib/apt/lists; \
  rm -rf /tmp/* ; \
  apt-get autoremove -y ; \
  apt-get clean
