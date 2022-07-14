# manysecured-openwrt-packages

📦 OpenWRT package feed for manysecured

## Usage
### Toolchain
Download the OpenWRT SDK toolchain from [https://downloads.openwrt.org/releases](https://downloads.openwrt.org/releases) for your hardware architecture and OpenWRt release.

### Configure
Add the following line to the `feeds.conf` or `feeds.conf.default` files in the OpenWRT SDK toolchain folder:

```conf
src-git node https://github.com/nqminds/manysecured-openwrt-packages.git
```

Run

```bash
./scripts/feeds update manysecured
rm ./package/feeds/packages/manysecured
rm ./package/feeds/packages/manysecured-*
./scripts/feeds install -a -p manysecured
make defconfig
```
