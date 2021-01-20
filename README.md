# Openresty Testsuite

A batteries included docker image for Openresty lua module developers!

## With powerful modules installed

- [Luarocks](https://github.com/keplerproject/luarocks)
- [Test::Nginx](https://github.com/openresty/test-nginx)
- [CPANm](https://cpanmin.us/)

## Available Versions:

[DockerHub](https://hub.docker.com/r/cdbattags/openresty-testsuite/)
- 1.19.3.1 (latest)
- 1.15.8.3

## Usage

1. Install Docker Engine
2. Install Docker Compose
3. Write Your `docker-compose.yml` (See [Sample](#docker-compose-sample))

### Docker Compose Sample

- Save following content as `docker-compose.yml`

```yaml
openresty:
  image: cdbattags/openresty-testsuite:latest
  volumes:
    - .:/tests
  working_dir: /tests
  command:
    - '/bin/sh'
    - '-c'
    - 'luarocks make YOUR-ROCKSPEC && prove -r t'
```

- Open your favourite editor to change `YOUR-ROCKSPEC` to real path or replace command with what ever your test scripts is.
- Run `docker-compose up`
