include $(TOPDIR)/rules.mk

PKG_NAME:=ssh-legion
PKG_VERSION:=0.1.3
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/nqminds/ssh-legion.git
PKG_SOURCE_DATE:=2022-08-22
PKG_SOURCE_VERSION:=7f28f57ca6e63404b6a351cd0a6ee4252f4cc199

PKG_MAINTAINER:=Alois Klink
PKG_LICENSE:=GPL-3.0-only
PKG_LICENSE_FILES:=LICENSE.md

PKG_BUILD_PARALLEL:=1
# Uncomment this if EDGESec does not support MIPS 16
# PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/ssh-legion
  SUBMENU:=ManySecured
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Automatic reverse SSH tunnel for multiple IoT devices.
  URL:=https://github.com/nqminds/ssh-legion
  # runtime only dependency (not used to build)
  EXTRA_DEPENDS:=openssh-client, bash (>=4.4-1), openssl-util (>=1.1.1-1)
  # works on all architectures since it's just a script
  PKGARCH:=all
endef

define Package/ssh-legion/description
  Automatically sets up a reverse SSH tunnel to a remote host through a
  publically accesible Reverse SSH server.

  Each host creates a tunnel so that it's accessible via localhost on the
  reverse SSH server. This means that an SSH proxyjump can be used to SSH
  through the reverse SSH tunnel to the host.

  Importantly, each host creates a file on the server's ~/connections folder
  that contains the port number of the local tunnel port. This means that you
  can deploy this ssh-legion script on multiple devices, and have them all use
  unique ports automatically.
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

	# creates an /etc/machine-id on first boot
	# tried to use dbus-uuidgen, or uuidgen, or fallsback to busybox and /dev/urandom
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/setup-machine-id $(1)/etc/uci-defaults/95-setup-machine-id

	$(INSTALL_DIR) $(1)/etc/ssh-legion
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/ssh-legion.config $(1)/etc/ssh-legion/ssh-legion.config
endef

$(eval $(call BuildPackage,ssh-legion))
