# manysecured-openwrt-packages

📦 OpenWRT package feed for manysecured

## Usage

### Toolchain

Download the OpenWRT SDK toolchain from [https://downloads.openwrt.org/releases](https://downloads.openwrt.org/releases) for your hardware architecture and OpenWRt release.

### Configure and Build

Add the following line to the `feeds.conf` or `feeds.conf.default` files in the OpenWRT SDK toolchain folder:

```conf
src-git node https://github.com/nqminds/manysecured-openwrt-packages.git
```

Run the following to download the OpenWRT package definitions, enable them for compilation, and compile them.

```bash
# pulls data from the feeds to the local PC
./scripts/feeds update -a
# deletes any old contents manysecured contents
rm ./package/feeds/packages/manysecured
rm ./package/feeds/packages/manysecured-*
# enables compiling manysecured contents
./scripts/feeds install -a -p manysecured
make defconfig
# required unless you disable signed packages in OpenWRT (or build base-files)
./staging_dir/host/bin/usign -G -s ./key-build -p ./key-build.pub -c "Local build key"
make
# use `make V=scw` for debugging
# use `nice -n19 make -j15` to make with 15 threads with low CPU priority (recommended)
```

If all goes well, the packages should be found in `bin/packages/*/manysecured` (replacing `*` with your architecture/target)!
For example, the edgesec package may be located at `bin/packages/arm_cortex-a9_vfpv3-d16/manysecured/edgesec_0.0.8-1_arm_cortex-a9_vfpv3-d16.ipk`,
and can be installed via `opkg install ./edgesec_0.0.8-1_arm_cortex-a9_vfpv3-d16.ipk`
