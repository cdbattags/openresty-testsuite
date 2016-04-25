# Openresty Testsuite
A battery included docker image for Openresty lua module developers!

## With powerful modules installed
- [Luarocks](https://github.com/keplerproject/luarocks)
- [Test::Nginx](https://github.com/openresty/test-nginx)
- [CPANm](https://cpanmin.us/)


## Available Versions:
- 1.9.7.4 (latest)

## Usage
1. Install Docker Engine
2. Install Docker Compose
3. Write Your `docker-compose.yml` (See [Sample](#docker-compose-sample))

### Docker Compose Sample
1. Save following content as `docker-compose.yml`
  ```yaml
  version: '2'
  services:
    openresty:
      image: skylothar/openresty-testsuite:latest
      volumes:
        - .:/tests
      working_dir: /tests
      command:
        - '/bin/sh'
        - '-c'
        - 'luarocks make YOUR-ROCKSPEC && prove -r t'
  ```
2. Open your favourite editor to change YOUR-ROCKSPEC to real path or replace command with what ever your test scripts is.
3. Run `docker-compose up`
