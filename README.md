# OpenResty Testsuite

A batteries-included Docker image for OpenResty Lua module developers. Provides
OpenResty, LuaRocks, and [Test::Nginx](https://github.com/openresty/test-nginx)
out of the box so you can `prove -r t` with zero setup.

## What's Inside

| Component | Version |
|-----------|---------|
| Debian | Bookworm (12) |
| OpenResty | 1.27.1.2 |
| OpenSSL | 3.0.18 (bundled with OpenResty) |
| LuaRocks | 3.13.0 |
| LuaJIT | 2.1 |
| Test::Nginx | 0.30 |
| cpanminus | latest |

## Architectures

Multi-arch images are published for both:

- `linux/amd64`
- `linux/arm64`

## Pulling

Images are published to Docker Hub and GitHub Container Registry on every push
to `master`:

```bash
docker pull cdbattags/openresty-testsuite:latest
docker pull ghcr.io/cdbattags/openresty-testsuite:latest
```

## Usage

### Inline

```bash
docker run \
    -i --rm \
    --entrypoint=/bin/sh \
    -v "$(pwd)":/project \
    -w /project \
    cdbattags/openresty-testsuite:latest \
    -c 'luarocks make your-rockspec.rockspec && prove -r t'
```

### Docker Compose

```yaml
services:
  test:
    image: cdbattags/openresty-testsuite:latest
    volumes:
      - .:/project
    working_dir: /project
    entrypoint: /bin/sh
    command:
      - -c
      - luarocks make your-rockspec.rockspec && prove -r t
```

### GitHub Actions

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          submodules: recursive

      - name: Test
        run: |
          docker run \
            -i --rm \
            --entrypoint=/bin/sh \
            -v "${{ github.workspace }}":/project \
            -w /project \
            cdbattags/openresty-testsuite:latest \
            -c 'luarocks make your-rockspec.rockspec && prove -r t'
```

## Contributing

1. Fork the repo
2. Create a feature branch (`git checkout -b feat/my-change`)
3. Commit using [Conventional Commits](https://www.conventionalcommits.org/)
   (e.g. `feat:`, `fix:`, `chore:`, `docs:`, `ci:`)
4. Open a pull request

## License

[Apache License 2.0](LICENSE)
