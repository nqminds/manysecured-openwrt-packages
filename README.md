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
# required unless you disable signed packages in OpenWRT (or build base-files)
./staging_dir/host/bin/usign -G -s ./key-build -p ./key-build.pub -c "Local build key"
make
# use `make V=scw` for debugging
# use `nice -n19 make -j15` to make with 15 threads with low CPU priority (recommended)
```
