# SPDX-License-Identifier: GPL-2.0
# SPDX-FileCopyrightText: © 2014 Arduino LLC (original node-sqlite3 file)
# SPDX-FileCopyrightText: © 2022 NquiringMinds Ltd. (node-better-sqlite3 adaptations)

include $(TOPDIR)/rules.mk

PKG_NPM_NAME:=better-sqlite3
PKG_NAME:=node-$(PKG_NPM_NAME)
PKG_VERSION:=7.6.2
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NPM_NAME)-$(PKG_VERSION).tgz
PKG_SOURCE_URL:=https://registry.npmjs.org/$(PKG_NPM_NAME)/-/
PKG_HASH:=6b7c4cf414cc032f3c7a244e3013d80ae675b41e7521c6b1a009527fb2795aec

PKG_MAINTAINER:=Alois Klink <alois@nquiringminds.com>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DEPENDS:=node/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/node-better-sqlite3
  SUBMENU:=Node.js
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=The fastest and simplest library for SQLite3 in Node.js.
  URL:=https://www.npmjs.org/package/better-sqlite3
  DEPENDS:=+node
endef

# node-better-sqlite3 currently compiles and bundles it's own version of sqlite3
# see https://github.com/WiseLibs/better-sqlite3/issues/855 for dynamic linking issues

define Package/node-better-sqlite3/description
 Asynchronous, non-blocking SQLite3 bindings for Node.js
endef

TAR_OPTIONS+= --strip-components 1
TAR_CMD=$(HOST_TAR) -C $(1) $(TAR_OPTIONS)

NODEJS_CPU:=$(subst powerpc,ppc,$(subst aarch64,arm64,$(subst x86_64,x64,$(subst i386,ia32,$(ARCH)))))
TMPNPM:=$(shell mktemp -u XXXXXXXXXX)

TARGET_CFLAGS+=$(FPIC)
TARGET_CPPFLAGS+=$(FPIC)

define Build/Compile
	cd $(PKG_BUILD_DIR); \
	$(MAKE_VARS) \
	$(MAKE_FLAGS) \
	npm_config_nodedir=$(STAGING_DIR)/usr/ \
	npm_config_cache=$(TMP_DIR)/npm-cache-$(TMPNPM) \
	npm_config_tmp=$(TMP_DIR)/npm-tmp-$(TMPNPM) \
	npm install --production --global-style --no-save --omit=dev --no-package-lock --build-from-source --target_arch=$(NODEJS_CPU)
	rm -rf $(TMP_DIR)/npm-tmp-$(TMPNPM)
	rm -rf $(TMP_DIR)/npm-cache-$(TMPNPM)
	rm -f $(PKG_BUILD_DIR)/node_modules/.package-lock.json
	find $(PKG_BUILD_DIR)/node_modules -type d -empty -print0 | xargs -0 rmdir || true
endef

define Package/node-better-sqlite3/install
	$(INSTALL_DIR) $(1)/usr/lib/node/$(PKG_NPM_NAME)
	$(CP) $(PKG_BUILD_DIR)/{package.json,*.md} \
		$(1)/usr/lib/node/$(PKG_NPM_NAME)/
	$(CP) $(PKG_BUILD_DIR)/{node_modules,LICENSE,build,lib} \
		$(1)/usr/lib/node/$(PKG_NPM_NAME)/
	$(INSTALL_DIR) $(1)/usr/lib/node_modules
	$(LN) ../node/$(PKG_NPM_NAME) $(1)/usr/lib/node_modules/$(PKG_NPM_NAME)
endef

define Package/node-better-sqlite3/postrm
#!/bin/sh
rm /usr/lib/node_modules/better-sqlite3 || true
rm -rf /usr/lib/node/better-sqlite3 || true
endef

$(eval $(call BuildPackage,node-better-sqlite3))
