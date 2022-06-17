# manysecured-openwrt-packages

📦 OpenWRT package feed for manysecured

## Usage

Add the following line to your OpenWRT toolchain/SDK `feeds.conf` or `feeds.conf.default`.

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
