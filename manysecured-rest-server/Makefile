include $(TOPDIR)/rules.mk

PKG_NPM_NAME:=nqminds-manysecured-rest-server
PKG_NAME:=node-$(PKG_NPM_NAME)
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

# If we ever make manysecured-rest-server public,
# we can download from NPM automatically by setting the following values
# 
#PKG_SOURCE:=$(PKG_NPM_NAME)-$(PKG_VERSION).tgz
#PKG_SOURCE_URL:=https://registry.npmjs.org/$(PKG_NPM_NAME)/-/
#PKG_HASH:=b5a5404f97c149137840605b118e2f015a7889562fe277979f16acf5593b2139

PKG_MAINTAINER:=Alexandru Mereacre
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=README.md

PKG_BUILD_DEPENDS:=node/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/manysecured-rest-server
  SUBMENU:=ManySecured
  SECTION:=net
  CATEGORY:=Network
  TITLE:=ManySecured Rest Server
  URL:=https://github.com/nqminds/many-secured/tree/main/packages/rest
  DEPENDS:=+node +node-express +node-sqlite3
endef

define Package/manysecured-rest-server/description
 ManySecured REST server
endef

TAR_OPTIONS+= --strip-components 1
TAR_CMD=$(HOST_TAR) -C $(1) $(TAR_OPTIONS)

NODEJS_CPU:=$(subst powerpc,ppc,$(subst aarch64,arm64,$(subst x86_64,x64,$(subst i386,ia32,$(ARCH)))))
TMPNPM:=$(shell mktemp -u XXXXXXXXXX)

# we don't want to delete the NPM cache, so that subsequent builds
# are much faster (`npm install` can take 10minutes and up!)
NPM_CACHE_NAME:="manysecured"

TARGET_CFLAGS+=$(FPIC)
TARGET_CPPFLAGS+=$(FPIC)

define Build/Compile
	# downloads dependencies and builds
	cd $(PKG_BUILD_DIR); \
	$(MAKE_VARS) \
	$(MAKE_FLAGS) \
	npm_config_nodedir=$(STAGING_DIR)/usr/ \
	npm_config_cache=$(TMP_DIR)/npm-cache-$(NPM_CACHE_NAME) \
	npm_config_tmp=$(TMP_DIR)/npm-tmp-$(TMPNPM) \
	npm install && npm pack

	# extracts build to ./package folder
	tar xf $(PKG_BUILD_DIR)/$(PKG_NPM_NAME)-$(PKG_VERSION).tgz --directory $(PKG_BUILD_DIR)

	rm -rf $(TMP_DIR)/npm-tmp-$(TMPNPM)
endef

define Package/manysecured-rest-server/install
	$(INSTALL_DIR) $(1)/usr/lib/node/$(PKG_NPM_NAME)
	$(CP) $(PKG_BUILD_DIR)/package/* \
		$(1)/usr/lib/node/$(PKG_NPM_NAME)/
	$(INSTALL_DIR) $(1)/usr/lib/node_modules
	$(LN) ../node/$(PKG_NPM_NAME) $(1)/usr/lib/node_modules/$(PKG_NPM_NAME)
endef

define Package/manysecured-rest-server/postrm
#!/bin/sh
rm /usr/lib/node_modules/manysecured-rest-server || true
rm -rf /usr/lib/node/manysecured-rest-server || true
endef

$(eval $(call BuildPackage,manysecured-rest-server))
