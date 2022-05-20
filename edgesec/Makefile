include $(TOPDIR)/rules.mk

PKG_NAME:=edgesec
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/nqminds/EDGESec.git
PKG_SOURCE_DATE:=2022-05-20
PKG_SOURCE_VERSION:=43dc689b6a985d7ceceac7f6bbc402d9820c26d1

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
  DEPENDS:=+socat +hostapd +dnsmasq
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
