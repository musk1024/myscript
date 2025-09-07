# 定义软件包名称
PKG_NAME:=customscript
# 定义版本号
PKG_VERSION:=1.0
# 不从外部下载任何东西
PKG_SOURCE_URL:=
# 不从源码构建，只安装文件
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

# 定义软件包在 menuconfig 中的描述
define Package/customscript
    SECTION:=net
    CATEGORY:=Network
    TITLE:=Script For Custom Route
endef

# 定义如何安装文件
# 这个步骤决定了哪些文件会被复制到固件文件系统里
define Package/customscript/install
    # 添加脚本到启动项
    $(INSTALL_DIR) $(1)/etc/init.d
    $(INSTALL_BIN) ./etc/init.d/iptvrule $(1)/etc/init.d

    # 当接口发生重连后触发以下脚本运行
    $(INSTALL_DIR) $(1)/etc/hotplug.d/iface
    $(INSTALL_BIN) ./etc/hotplug.d/iface/99-iptv $(1)/etc/hotplug.d/iface/
    $(INSTALL_BIN) ./etc/hotplug.d/iface/99-passwall $(1)/etc/hotplug.d/iface/
    $(INSTALL_BIN) ./etc/hotplug.d/iface/99-voip-route $(1)/etc/hotplug.d/iface/
endef

$(eval $(call BuildPackage,customscript))