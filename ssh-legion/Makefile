include $(TOPDIR)/rules.mk

PKG_NAME:=ssh-legion
PKG_VERSION:=0.1.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/nqminds/ssh-legion.git
PKG_SOURCE_DATE:=2022-07-08
PKG_SOURCE_VERSION:=4879a5234ccaf322f0e186f0e5109931a3a948db

PKG_MAINTAINER:=Alois Klink
# currently unlicensed
# PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=READEME.md

PKG_BUILD_PARALLEL:=1
# Uncomment this if EDGESec does not support MIPS 16
# PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/ssh-legion
  SUBMENU:=ManySecured
  SECTION:=net
  CATEGORY:=Network
  TITLE:=NQM SSH Tunneler that stores a file in ~/connections with the tunneled port
  URL:=https://github.com/nqminds/ssh-legion
  DEPENDS:=+openssh-client
endef

define Package/ssh-legion/description
 NQM SSH Tunneler that stores a file in ~/connections with the tunneled port
endef

# files listed here are preserved by default when a package is updated
define Package/ssh-legion/conffiles
/etc/ssh-legion/ssh-legion.config
endef

define Build/Compile
	# pass, no build script, this is just a shell script
	true
endef

define Build/Install
	true
endef

define Package/ssh-legion/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/ssh-legion $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/ssh-legion.init.sh $(1)/etc/init.d/ssh-legion

	$(INSTALL_DIR) $(1)/etc/ssh-legion
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/ssh-legion.config $(1)/etc/ssh-legion/ssh-legion.config
endef

$(eval $(call BuildPackage,ssh-legion))
