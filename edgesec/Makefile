include $(TOPDIR)/rules.mk

PKG_NAME:=edgesec
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/nqminds/EDGESec.git
PKG_SOURCE_DATE:=2022-05-27
PKG_SOURCE_VERSION:=30a495119a1c9a27e873b2cf24f42234a1b39739

PKG_MAINTAINER:=Alexandru Mereacre
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DEPENDS:=node/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/EDGESec
  SUBMENU:=ManySecured
  SECTION:=net
  CATEGORY:=Network
  TITLE:=EDGESec
  URL:=https://github.com/nqminds/EDGESec
  DEPENDS:=+socat +hostapd +dnsmasq +libuuid +libuci +libsqlite3 +libpcap
endef

define Package/EDGESec/description
 EDGESec secure IoT edge router
endef

TAR_OPTIONS+= --strip-components 1
TAR_CMD=$(HOST_TAR) -C $(1) $(TAR_OPTIONS)

TMPNPM:=$(shell mktemp -u XXXXXXXXXX)

# we don't want to delete the NPM cache, so that subsequent builds
# are much faster (`npm install` can take 10minutes and up!)

TARGET_CFLAGS+=$(FPIC)
TARGET_CPPFLAGS+=$(FPIC)

# dynamically link these modules
CMAKE_OPTIONS += \
	-DBUILD_MNL_LIB=OFF \
	-DBUILD_NETLINK_LIB=OFF \
	-DBUILD_NL_LIB=OFF \
	-DUSE_NETLINK_SERVICE=OFF \
	-DUSE_UCI_SERVICE=ON \
	-DUSE_GENERIC_IP_SERVICE=OFF \
	-DBUILD_UCI_LIB=OFF \
	-DBUILD_HOSTAPD=OFF \
	-DBUILD_SQLITE_LIB=OFF \
	-DBUILD_PCAP_LIB=OFF \
	-DBUILD_UUID_LIB=OFF

define Build/Configure
	# does nothing, since EDGESec's `cmake` is a bit annoying, and compiles
	# dependencies during configure time
	true
endef

define Build/Compile
	# run cmake configure step now
	$(Build/Configure/Default)
	# now run default cmake compile step
	$(Build/Compile/Default)
endef

define Package/EDGESec/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/edgesec $(1)/usr/bin/
endef

$(eval $(call BuildPackage,EDGESec))
