include $(TOPDIR)/rules.mk

PKG_NAME:=ssh-tunnel
PKG_VERSION:=0.1.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git@github.com:nqminds/nqm-ssh-tunnel.git
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

define Package/ssh-tunnel
  SUBMENU:=ManySecured
  SECTION:=net
  CATEGORY:=Network
  TITLE:=NQM SSH Tunneler that stores a file in ~/connections with the tunneled port
  URL:=https://github.com/nqminds/ssh-tunnel
  DEPENDS:=+openssh-client
endef

define Package/ssh-tunnel/description
 NQM SSH Tunneler that stores a file in ~/connections with the tunneled port
endef

# files listed here are preserved by default when a package is updated
define Package/ssh-tunnel/conffiles
/etc/ssh-tunnel/ssh-tunnel.config
endef

define Build/Compile
	# pass, no build script, this is just a shell script
	true
endef

define Build/Install
	true
endef

define Package/ssh-tunnel/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/ssh-tunnel $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/ssh-tunnel.init.sh $(1)/etc/init.d/ssh-tunnel

	$(INSTALL_DIR) $(1)/etc/ssh-tunnel
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/ssh-tunnel.config $(1)/etc/ssh-tunnel/ssh-tunnel.config
endef

$(eval $(call BuildPackage,ssh-tunnel))
