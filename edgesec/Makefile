include $(TOPDIR)/rules.mk

PKG_NAME:=edgesec
PKG_VERSION:=0.0.8
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/nqminds/edgesec.git
PKG_SOURCE_DATE:=2022-07-25
PKG_SOURCE_VERSION:=a23c9541e55d392a0a71e3d5297aa5dc7b98c246

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
endef

$(eval $(call BuildPackage,edgesec))
