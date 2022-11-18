# SPDX-License-Identifier: GPL-2.0
# Originally from https://github.com/openwrt/packages/blob/d36c34f9847d20450f61c955ccab745a5c90e90f/.github/workflows/Dockerfile

ARG ARCH=x86-64
FROM openwrt/rootfs:$ARCH

ADD entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
