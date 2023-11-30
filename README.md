# `unwarp`

[![ci](https://github.com/loozhengyuan/unwarp/actions/workflows/ci.yml/badge.svg)](https://github.com/loozhengyuan/unwarp/actions/workflows/ci.yml)

Disable [Cloudflare WARP](https://developers.cloudflare.com/cloudflare-one/connections/connect-devices/warp/) on macOS

## Install

To install `unwarp`, run the following command:

```shell
brew tap loozhengyuan/tap
brew install unwarp
```

Once installed, you need to enable the `unwarp` service to complete installation:

```shell
brew services start unwarp
```

You can verify that it is installed correctly by enabling [Cloudflare WARP](https://developers.cloudflare.com/cloudflare-one/connections/connect-devices/warp/) and observing that it gets disabled shortly.

## Usage

When you need to be connected to Cloudflare WARP, you can temporarily disable `unwarp` by running:

```shell
brew services kill unwarp
```

Once you are done, you can restart the service by running:

```shell
brew services start unwarp
```

## Troubleshooting

The `stdout` and `stderr` are redirected to the log file in `"$(brew --prefix)/var/log/unwarp.log"`. To view the log file:

```shell
tail "$(brew --prefix)/var/log/unwarp.log"
```

## License

[MIT](https://choosealicense.com/licenses/mit/)
