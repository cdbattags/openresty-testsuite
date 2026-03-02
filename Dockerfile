FROM openresty/openresty:1.27.1.2-0-bookworm-fat

ARG LUAROCKS_VERSION=3.13.0

ENV PATH="/usr/local/openresty/luajit/bin:/usr/local/openresty/nginx/sbin:/usr/local/openresty/bin:${PATH}"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        cpanminus \
        curl \
        libpcre3-dev \
        libssl-dev \
        make \
        perl \
        unzip \
        wget \
    && cpanm --notest Test::Nginx \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN cd /tmp \
    && curl -fSL "https://luarocks.github.io/luarocks/releases/luarocks-${LUAROCKS_VERSION}.tar.gz" \
        -o "luarocks-${LUAROCKS_VERSION}.tar.gz" \
    && tar xzf "luarocks-${LUAROCKS_VERSION}.tar.gz" \
    && cd "luarocks-${LUAROCKS_VERSION}" \
    && ./configure \
        --prefix=/usr/local/openresty/luajit \
        --with-lua=/usr/local/openresty/luajit \
        --lua-suffix=jit \
        --with-lua-include=/usr/local/openresty/luajit/include/luajit-2.1 \
    && make build \
    && make install \
    && cd /tmp \
    && rm -rf "luarocks-${LUAROCKS_VERSION}" "luarocks-${LUAROCKS_VERSION}.tar.gz"

ARG LUA_RESTY_OPENSSL_VERSION=1.7.1-1

RUN luarocks install \
        --server=https://luarocks.org/manifests/fffonion \
        lua-resty-openssl ${LUA_RESTY_OPENSSL_VERSION} \
    && luarocks list lua-resty-openssl

WORKDIR /
