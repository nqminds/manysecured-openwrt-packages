include $(TOPDIR)/rules.mk

PKG_NAME:=edgesec
PKG_VERSION:=0.1.0-alpha.0
PKG_RELEASE:=1

# Use the following settings for testing with unreleased git commits
# PKG_SOURCE_PROTO:=git
# PKG_SOURCE_URL:=https://github.com/nqminds/edgesec.git
# PKG_SOURCE_DATE:=2022-07-28
# PKG_SOURCE_VERSION:=20e12a9f295b121dfeba7829622a050a5985452e

PKG_SOURCE:=v$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/nqminds/edgesec/archive/refs/tags
PKG_HASH:=fa467dd2445f182d9fb0d1a2b6e51791a9bc4fbcbf46fb61c28175a66e8c66c3

PKG_MAINTAINER:=Alexandru Mereacre
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_PARALLEL:=1
# Uncomment this if edgesec does not support MIPS 16
# PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/edgesec
  SUBMENU:=ManySecured
  SECTION:=net
  CATEGORY:=Network
  TITLE:=edgesec
  URL:=https://github.com/nqminds/edgesec
  DEPENDS:=+libuuid +libuci +libsqlite3 +libpcap
  EXTRA_DEPENDS=hostapd, dnsmasq
endef

define Package/edgesec/description
 EDGESec secure IoT edge router
endef

# files listed here are preserved by default when a package is updated
define Package/edgesec/conffiles
/etc/edgesec/config.ini
endef

# Not 100% sure if these are still needed, I think CMake adds these
# automatically
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
	-DUSE_CLEANER_MIDDLEWARE=OFF \
	-DUSE_HEADER_MIDDLEWARE=ON \
	-DUSE_PCAP_MIDDLEWARE=OFF

define Package/edgesec/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/edgesec $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/edgesec.init.sh $(1)/etc/init.d/edgesec

	$(INSTALL_DIR) $(1)/etc/edgesec
	$(INSTALL_CONF) ./files/config.ini $(1)/etc/edgesec

	# default folder for storing edgesec databases
	# Warning!! Will error if `/srv` does not exist
	# Normally, this should be external storage, not internal storage
	$(INSTALL_DIR) $(1)/srv/edgesec
endef

$(eval $(call BuildPackage,edgesec))
