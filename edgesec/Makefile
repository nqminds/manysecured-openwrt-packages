include $(TOPDIR)/rules.mk

PKG_NAME:=edgesec
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/nqminds/EDGESec.git
PKG_SOURCE_DATE:=2022-06-17
PKG_SOURCE_VERSION:=3b7ee501d03fc517ceafbc9e5c518ca86f2e4f6c

PKG_MAINTAINER:=Alexandru Mereacre
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_PARALLEL:=1
# Uncomment this if EDGESec does not support MIPS 16
# PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/edgesec
  SUBMENU:=ManySecured
  SECTION:=net
  CATEGORY:=Network
  TITLE:=edgesec
  URL:=https://github.com/nqminds/EDGESec
  DEPENDS:=hostapd +dnsmasq +libuuid +libuci +libsqlite3 +libpcap
endef

define Package/edgesec/description
 EDGESec secure IoT edge router
endef

# files listed here are preserved by default when a package is updated
define Package/edgesec/conffiles
/etc/edgesec/config.ini
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
	-DUSE_RADIUS_SERVICE=ON \
	-DBUILD_UCI_LIB=OFF \
	-DBUILD_HOSTAPD=OFF \
	-DBUILD_SQLITE_LIB=OFF \
	-DBUILD_PCAP_LIB=OFF \
	-DBUILD_UUID_LIB=OFF \
	-DUSE_CLEANER_MIDDLEWARE=ON \
	-DUSE_HEADER_MIDDLEWARE=ON \
	-DUSE_PCAP_MIDDLEWARE=ON

define Package/edgesec/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/edgesec $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/edgesec.init.sh $(1)/etc/init.d/edgesec

	$(INSTALL_DIR) $(1)/etc/edgesec
	$(INSTALL_CONF) ./files/config.ini $(1)/etc/edgesec
endef

$(eval $(call BuildPackage,edgesec))
